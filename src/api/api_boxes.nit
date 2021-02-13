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

# Boxes API
#
# Used for box management and submissions checking.
module api_boxes

import api_auth

redef class APIRouter
	redef init do
		super

		use("/search", new APISearchBoxes(config, model))

		use("/boxes/", new APIBoxes(config, model))
		use("/boxes/:bid", new APIBox(config, model))
		use("/boxes/:bid/tests", new APIBoxTests(config, model))
		use("/boxes/:bid/submit", new APIBoxSubmit(config, model))
		use("/boxes/:bid/submit/status", new APIBoxSubmitStatus(config, model))
		use("/boxes/:bid/submissions", new APIBoxUserSubmissions(config, model))
		use("/boxes/:bid/submissions/:sid", new APIBoxUserSubmission(config, model))
		use("/boxes/:bid/submissions/:sid/status", new APIBoxUserSubmissionStatus(config, model))
	end
end

# Abstract handler for box related services
abstract class APIBoxHandler
	super APIHandler

	# Get the box matching uri param `?bid=`
	fun get_box(req: HttpRequest, res: HttpResponse): nullable Box do
		var bid = req.param("bid")
		if bid == null then
			res.api_error("Missing URI param `bid`", 400)
			return null
		end
		var box = model.get_box(bid)
		if box == null then
			res.api_error("Box `{bid}` not found", 404)
			return null
		end
		return box
	end

	# Deserialize a submission form
	fun deserialize_submission(req: HttpRequest, res: HttpResponse): nullable SubmissionForm do
		var post = req.body
		var deserializer = new JsonDeserializer(post)
		var submission_form = new SubmissionForm.from_deserializer(deserializer)
		if not deserializer.errors.is_empty then
			res.error 400
			print "Error deserializing submission"
			print deserializer.errors.join("\n")
			print post.write_to_string
			return null
		end
		return submission_form
	end
end

# GET: search boxes with param `?q=`
class APISearchBoxes
	super APIBoxHandler

	redef fun get(req, res) do
		var q = req.string_arg("q")
		if q == null then
			res.json new JsonArray
			return
		end
		res.json new JsonArray.from(model.search_boxes(q.trim))
	end
end

# Boxes handler
#
# GET: return a array of all the boxes
class APIBoxes
	super APIBoxHandler

	redef fun get(req, res) do
		res.json new JsonArray.from(model.get_boxes)
	end
end

# Box handler
#
# GET: return a box
class APIBox
	super APIBoxHandler

	redef fun get(req, res) do
		var box = get_box(req, res)
		if box == null then return
		res.json box
	end
end

# Box tests handler
#
# GET: return the box tests
class APIBoxTests
	super APIBoxHandler

	redef fun get(req, res) do
		var box = get_box(req, res)
		if box == null then return

		var obj = new JsonObject
		obj["public"] = new JsonArray.from(box.public_tests)
		# TODO add private test if the user is admin or box owner
		res.json obj
	end
end

# Box submission handler
#
# GET: return the last submission
class APIBoxSubmit
	super APIAuthHandler
	super APIBoxHandler

	redef fun get(req, res) do
		var box = get_box(req, res)
		if box == null then return
		var user = get_auth_user(req, res)
		if user == null then return

		var submission = box.last_submission(user)
		res.json submission
	end

	redef fun post(req, res) do
		var user = get_auth_user(req, res)
		if user == null then return
		var box = get_box(req, res)
		if box == null then return
		var sub_form = deserialize_submission(req, res)
		if sub_form == null then return

		var submission = new Submission(box, user.id, sub_form.files, sub_form.teammate)
		submission.check
		res.json submission
	end

	redef fun put(req, res) do
		var user = get_auth_user(req, res)
		if user == null then return
		var box = get_box(req, res)
		if box == null then return

		if not box.allow_submissions then
			res.api_error("Box does not accept submissions", 403)
			return
		end

		if not box.is_active then
			res.api_error("Box is closed", 403)
			return
		end

		var sub_form = deserialize_submission(req, res)
		if sub_form == null then return

		var submission = box.last_submission(user)
		submission.teammate = sub_form.teammate
		submission.files = sub_form.files
		submission.save_files
		res.json submission.approuve
	end
end

# Box submission status handler
#
# GET: return the last submission status
class APIBoxSubmitStatus
	super APIAuthHandler
	super APIBoxHandler

	redef fun get(req, res) do
		var box = get_box(req, res)
		if box == null then return
		var user = get_auth_user(req, res)
		if user == null then return

		var submission = box.last_submission(user)
		res.json submission.status
	end
end

# Box submission handler
#
# GET: return the last submission
class APIBoxUserSubmission
	super APIAuthHandler
	super APIBoxHandler

	# Get the submission from `:sid`
	fun get_submission(req: HttpRequest, res: HttpResponse): nullable Submission do
		var box = get_box(req, res)
		if box == null then return null
		var user = get_auth_user(req, res)
		if user == null then return null

		var sid = req.param("sid")
		if sid == null then
			res.api_error("Missing URI param `sid`", 400)
			return null
		end
		var submission = box.get_submission(sid)
		if submission == null then
			res.api_error("Submission `{sid}` not found", 404)
			return null
		end
		if submission.user != user.id then
			res.api_error("Submission `{sid}` not found", 404)
			return null
		end
		return submission
	end

	redef fun get(req, res) do
		var submission = get_submission(req, res)
		if submission == null then return
		res.json submission
	end
end

# Box submission status handler
#
# GET: return the submission status
class APIBoxUserSubmissionStatus
	super APIBoxUserSubmission

	redef fun get(req, res) do
		var submission = get_submission(req, res)
		if submission == null then return
		res.json submission.status
	end
end

# Logged user submissions on a box
#
# GET: get user submissions for a box
class APIBoxUserSubmissions
	super APIAuthHandler
	super APIBoxHandler

	redef fun get(req, res) do
		var user = get_auth_user(req, res)
		if user == null then return
		var box = get_box(req, res)
		if box == null then return
		res.json new JsonArray.from(box.user_submissions(user))
	end
end

# This model provides easy deserialization of posted submission forms
class SubmissionForm
	serialize

	# Source code to be run
	var files: Array[SourceFile]

	# Teammate student code if ant
	var teammate: nullable String
end
