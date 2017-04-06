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

import api_base

redef class APIRouter
	redef init do
		super
		use("/boxes/", new APIBoxes(model))
		use("/boxes/:bid", new APIBox(model))
		use("/boxes/:bid/submission", new APIBoxSubmission(model))
		use("/boxes/:bid/submission/save", new APIBoxSubmissionSave(model))
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
end

# Boxes handler
#
# GET: return a array of all the boxes
class APIBoxes
	super APIBoxHandler

	redef fun get(req, res) do
		res.json new JsonArray.from(model.boxes.values)
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

# Box submission handler
#
# GET: return the last submission
class APIBoxSubmission
	super APIBoxHandler

	redef fun get(req, res) do
		var box = get_box(req, res)
		if box == null then return

		var submission = box.last_submission
		res.json submission
	end

	redef fun post(req, res) do
		var box = get_box(req, res)
		if box == null then return

		var post = req.body
		var deserializer = new JsonDeserializer(post)
		var submission_form = new SubmissionForm.from_deserializer(deserializer)
		if not deserializer.errors.is_empty then
			res.error 400
			print "Error deserializing submission"
			return
		end
		var submission = new Submission(submission_form.files)
		var results = box.check_submission(submission)
		res.json results
	end
end

# Box submission handler
#
# GET: return the last submission
class APIBoxSubmissionSave
	super APIBoxHandler

	redef fun post(req, res) do
		var box = get_box(req, res)
		if box == null then return

		var post = req.body
		var deserializer = new JsonDeserializer(post)
		var submission_form = new SubmissionForm.from_deserializer(deserializer)
		if not deserializer.errors.is_empty then
			res.error 400
			print "Error deserializing submission"
			return
		end
		var submission = new Submission(submission_form.files)
		submission.create_workspace(box)
		res.json submission
	end
end

# This model provides easy deserialization of posted submission forms
class SubmissionForm
	serialize

	# Source code to be run
	var files: Array[SourceFile]
end
