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
		if box != null and box.is_active then boxes.add box
		if not boxes.is_empty then return boxes

		# Search box by title
		for tbox in self.boxes.values do
			if not tbox.is_active then continue
			if tbox.id.split(":").last == search then boxes.add tbox
		end
		if not boxes.is_empty then return boxes

		# Lookup boxes by user id
		for ubox in self.boxes.values do
			if not ubox.is_active then continue
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
		var base_id = config["id"] or else path.basename
		var owner = self.owner
		if owner != null then return "{owner}:{base_id}"
		return base_id
	end

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

	# Execute a `make` command in the box path
	fun box_make(command: String...): String do
		command.add_all(["-C", path, "--no-print-directory"])
		return make_cmd(command...)
	end

	# Get all the submissions for `self`
	fun submissions: Array[Submission] do
		var res = new Array[Submission]
		for file in (path / "submissions").files do
			res.add get_submission(file)
		end
		(new SubmissionComparator).sort(res)
		return res
	end

	# Get the submission with `id`
	fun get_submission(id: String): Submission do
		var files = new Array[SourceFile]
		for file in source_files_list do
			files.add new SourceFile(file, (path / "submissions" / id / file).to_path.read_all)
		end
		var submission = new Submission(files)
		submission.timestamp = id.to_i
		return submission
	end

	# Get the last submission
	# TODO plug with a user system
	fun last_submission: Submission do
		var submissions = self.submissions
		if submissions.is_empty then
			return new Submission(source_files)
		end
		return submissions.last
	end

	# Check a submission
	# TODO plug with a user system
	fun check_submission(submission: Submission): SubmissionResult do
		var id = submission.create_workspace(self)
		box_make("SUB=submissions/{id}/src", "check-submission")
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
		v.serialize_attribute("is_active", is_active)
		v.serialize_attribute("closes_at", close_date)
		v.serialize_attribute("tests", new JsonArray.from(tests))
	end

	redef fun to_s do return id
end

# A box submission
# TODO plug with a user system
class Submission
	super Jsonable
	super Comparable
	serialize

	# Submitted files
	var files: Array[SourceFile]

	# Submission timestamp
	var timestamp: Int = get_time * 1000

	# Create the submission working directory
	fun create_workspace(box: Box): String do
		var dir = box.path / "submissions" / timestamp.to_s
		dir.mkdir

		for file in files do
			var path = dir / file.path
			path.dirname.mkdir
			file.content.write_to_file(path)
		end

		return timestamp.to_s
	end

	redef fun to_s do return timestamp.to_s
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
end

# A submission result
class SubmissionResult
	super Jsonable
	serialize

	# List of executed tests
	var test_results: Array[TestResult]

	# Has this submission passed all the tests?
	var passed: Bool is lazy do
		for test in test_results do
			if not test.is_passed then return false
		end
		return true
	end
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
end

# Compare submission by timestamp in reverse order
class SubmissionComparator
	super DefaultComparator

	redef type COMPARED: Submission
	redef fun compare(a, b) do return b.timestamp <=> a.timestamp
end

# Execute a make command and return the result
fun make_cmd(command: String...): String do
	var p = new ProcessReader("make", command...)
	var res = p.read_all
	p.close
	p.wait
	return res
end
