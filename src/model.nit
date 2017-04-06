# Copyright 2017 Alexandre Terrasa <alexandre@moz-code.org>.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Box model
#
# Introduce the main entities of the box application.
module model

import ini
import json::static

# Box Model
#
# Contains all the loaded boxes.
# Used to access boxes and other data from the tools (web API, CLI...).
class Model

	# Boxes by id
	var boxes = new HashMap[String, Box]

	# Get the box with `id` or `null`
	fun get_box(id: String): nullable Box do
		return boxes.get_or_null(id)
	end

	# Load all boxes from `path`
	fun load_boxes(path: String) do
		for file in path.files do
			if not is_box(path / file) then continue
			var box = new Box(path / file)
			boxes[box.id] = box
		end
	end

	# Is `path` a correct box directory?
	fun is_box(path: String): Bool do
		if not path.file_exists then return false
		var stat = path.to_path.stat
		if stat != null and not stat.is_dir then return false
		if not (path / "box.ini").file_exists then return false
		return true
	end

	# Search boxes matching `search` from repo
	#
	# The search algorithm is the following:
	# 1 - try to match box where box.id == search
	# 2 - try to match box where box.title == search
	# 3 - try to find professor where user.id == search and return the list of active boxes
	fun search_boxes(search: String): Array[Box] do
		var boxes = new Array[Box]
		# Search box by id
		var box = self.get_box(search)
		if box != null then boxes.add box
		if not boxes.is_empty then return boxes

		# Search box by title
		for tbox in self.boxes.values do
			if tbox.id.split(":").last == search then boxes.add tbox
		end
		if not boxes.is_empty then return boxes

		# Lookup boxes by user id
		for ubox in self.boxes.values do
			if ubox.owner == search then boxes.add ubox
		end
		return boxes
	end
end

# A user can own boxes and make submissions
class User
	super Jsonable
	serialize

	# User unique identifier (from shib uqam)
	var id: String

	# User name
	var name: nullable String is writable

	# User avatar url
	var avatar_url: nullable String is writable

	# Get all the boxes owned by `user`
	fun boxes(model: Model): Array[Box] do
		var res = new Array[Box]
		for id, box in model.boxes do
			if box.owner == self.id then res.add box
		end
		return res
	end

	# Get all the submissions from `user`
	fun submissions(model: Model): Array[Submission] do
		var res = new Array[Submission]
		for id, box in model.boxes do
			res.add_all box.user_submissions(self)
		end
		return res
	end

	redef fun ==(o) do return o isa User and o.id == id

	redef fun to_s do return id
end

# Box
#
# A Box is a container for submissions and tests.
class Box
	super Jsonable
	serialize

	# Box path
	var path: String

	# Box configuration file.
	#
	# Always located at `path / "box.ini"`.
	var config: ConfigTree is lazy do return new ConfigTree(path / "box.ini")

	# Box owner id if any
	var owner: nullable String is lazy do return config["owner"]

	# Box active flag
	var active: Bool is lazy do
		var v = config["active"]
		if v != null and v == "false" then return false
		return true
	end

	# Box closing time
	var close_date: nullable Int is lazy do
		var v = config["closes_at"]
		if v != null then return v.to_i
		return null
	end

	# Is this box active?
	var is_active: Bool is lazy do
		var date = close_date
		if date != null then
			if get_time * 1000 > date then return false
		end
		return active
	end

	# Box unique ID
	#
	# Default is `path.basename`.
	# Set the key `id` in the INI file to overwritte the default value.
	var id: String is lazy do
		var base_id = config["id"] or else path.basename.strip_id
		var owner = self.owner
		if owner != null then return "{owner}:{base_id}".strip_id
		return base_id
	end

	# Box readable title
	var title: String is lazy do return config["title"] or else path.basename.strip_id

	# List the box source files paths
	var source_files_list: Array[String] is lazy do
		var files = box_make("files").split("\n")
		files.pop
		return files
	end

	# List the source files of the box
	var source_files: Array[SourceFile] is lazy do
		var res = new Array[SourceFile]
		for file in source_files_list do
			res.add new SourceFile(file, (path / file).to_path.read_all)
		end
		return res
	end

	# List the box tests (only the name)
	var tests: Array[TestFile] is lazy do
		var tests = new Array[TestFile]
		for line in box_make("list_tests").split("\n") do
			if line.is_empty then continue
			tests.add new TestFile(line.trim)
		end
		return tests
	end

	# The box README.md file content
	var readme: nullable String is lazy do
		var file = path / "README.md"
		if not file.file_exists then return null
		return file.to_path.read_all
	end

	# Execute a `make` command in the box path
	fun box_make(command: String...): String do
		command.add_all(["-C", path, "--no-print-directory"])
		return make_cmd(command...)
	end

	# Get all the submissions for `self`
	fun submissions: Array[Submission] do
		var res = new Array[Submission]
		for file in (path / "submissions").files do
			var submission = get_submission(file)
			if submission == null then continue
			res.add submission
		end
		(new SubmissionComparator).sort(res)
		return res
	end

	# Get the submission with `id`
	fun get_submission(id: String): nullable Submission do
		if not (path / "submissions" / id).file_exists then return null
		return new Submission.from_id(self, id)
	end

	# Get the submissions for user
	fun user_submissions(user: User): Array[Submission] do
		var submissions = new Array[Submission]
		for submission in self.submissions do
			if submission.user == user.id then submissions.add submission
		end
		return submissions
	end

	# Get the last submission
	fun last_submission(user: User): Submission do
		var submissions = user_submissions(user)
		if submissions.is_empty then
			return new Submission(self, user.id, source_files)
		end
		return submissions.last
	end

	# Check a submission
	fun check_submission(submission: Submission): SubmissionResult do
		box_make("SUB=submissions/{submission.id}/src", "check-submission")
		var out = path / "out/tests"
		var tests = new HashMap[String, TestResult]
		for file in out.files do
			var test_name = file.strip_extension
			if not tests.has_key(test_name) then
				tests[test_name] = new TestResult(out, test_name)
			end
		end
		return new SubmissionResult(tests.values.to_a)
	end

	redef fun core_serialize_to(v) do
		v.serialize_attribute("id", id)
		v.serialize_attribute("title", title)
		v.serialize_attribute("is_active", is_active)
		v.serialize_attribute("closes_at", close_date)
		v.serialize_attribute("tests", new JsonArray.from(tests))
	end

	redef fun ==(o) do return o isa Box and o.id == id

	redef fun to_s do return id
end

# A box submission
class Submission
	super Jsonable
	super Comparable
	serialize

	# The box this submission belongs to
	var box: Box

	# The user who submitted
	var user: String

	# Submitted files
	var files: Array[SourceFile] is writable

	# Teamate student code if any
	var teamate: nullable String

	# Submission path
	var path: String is lazy do return box.path / "submissions" / id

	# Submission timestamp
	var timestamp: Int = get_time * 1000

	# The submission id
	var id: String is lazy do return "{timestamp}_{user}".strip_id

	# Is this submission approuved by the student?
	var is_approuved: Bool is lazy do return (path / "APPROUVED").file_exists

	init do
		save_files
	end

	# Create a submission from an existing directory in `box`
	init from_id(box: Box, id: String) do
		self.box = box
		self.id = id

		var parts = id.split("_")
		self.timestamp = parts.shift.to_i
		var user = parts.join("_")

		var files = new Array[SourceFile]
		for file in box.source_files_list do
			files.add new SourceFile(file, (path / file).to_path.read_all)
		end

		init(box, user, files)
	end

	# Approuve this submission
	fun approuve do
		var signoff = user
		var teamate = self.teamate
		if teamate != null then signoff = "{signoff} teamate: {teamate}"
		signoff.write_to_file(path / "APPROUVED")
	end

	# Create the submission working directory
	fun save_files do
		for file in files do
			var path = self.path / file.path
			path.dirname.mkdir
			file.content.write_to_file(path)
		end
	end

	redef fun ==(o) do return o isa Submission and o.id == self.id

	redef fun to_s do return id.to_s
end

# A test result
class TestResult
	super Jsonable
	serialize

	# Test result base path
	var path: String

	# Test name
	var test_name: String

	# Is this test ok?
	var is_passed: Bool is lazy do return (path / "{test_name}.pass").file_exists

	# cmd output
	var cmd: String is lazy do return (path / "{test_name}.cmd").to_path.read_all

	# code output
	var code: String is lazy do return (path / "{test_name}.code").to_path.read_all

	# err output
	var err: String is lazy do return (path / "{test_name}.err").to_path.read_all

	# log output
	var log: String is lazy do return (path / "{test_name}.log").to_path.read_all

	# std output
	var out: String is lazy do return (path / "{test_name}.out").to_path.read_all

	# diff output
	var diff: String is lazy do return (path / "{test_name}.diff").to_path.read_all

	redef fun ==(o) do return o isa TestResult and o.path == path

	redef fun to_s do return path
end

# A submission result
class SubmissionResult
	super Jsonable
	serialize

	# List of executed tests
	var tests_results: Array[TestResult]

	# Count of passed tests
	var tests_passed: Int is lazy do
		var res = 0
		for test in tests_results do
			if test.is_passed then res += 1
		end
		return res
	end

	# Count of failed tests
	var tests_failed: Int is lazy do
		var res = 0
		for test in tests_results do
			if not test.is_passed then res += 1
		end
		return res
	end

	# Has this submission passed all the tests?
	var is_passed: Bool is lazy do return tests_failed == 0
end

# Editable source file
#
# See `Box.source_files`.
class SourceFile
	super Jsonable
	serialize

	# Path to the file from the box root directory
	var path: String

	# File content
	var content: String

	# File path basename
	var filename: String is lazy do return path.basename

	# File extension
	var extension: nullable String is lazy do return filename.file_extension

	redef fun ==(o) do return o isa SourceFile and o.path == path

	redef fun to_s do return path
end

# A test file
class TestFile
	super Jsonable
	serialize

	# Path to the test file
	var path: String

	# Test name
	var name: String is lazy do return path.basename.strip_extension

	redef fun ==(o) do return o isa TestFile and o.path == path

	redef fun to_s do return path
end

# Compare submission by timestamp in reverse order
class SubmissionComparator
	super DefaultComparator

	redef type COMPARED: Submission
	redef fun compare(a, b) do return a.timestamp <=> b.timestamp
end

redef class String
	# Replace sequences of non-alphanumerical characters by underscore (allows semicolons).
	#
	# ~~~
	# assert "abcXYZ123_".strip_id == "abcXYZ123_"
	# assert ", 'A[]\nB#$_".strip_id == "_A_B_"
	# assert "abcX::YZ123_".strip_id == "abcX::YZ123_"
	# ~~~
	fun strip_id: String
	do
		var res = new Buffer
		var sp = false
		for c in chars do
			if c != ':' and not c.is_alphanumeric then
				sp = true
				continue
			end
			if sp then
				res.add '_'
				sp = false
			end
			res.add c
		end
		if sp then res.add '_'
		return res.to_s
	end
end

# Execute a make command and return the result
fun make_cmd(command: String...): String do
	var p = new ProcessReader("make", command...)
	var res = p.read_all
	p.close
	p.wait
	return res
end
