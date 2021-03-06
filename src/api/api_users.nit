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

# User related routes
module api_users

import model
import api::api_auth
import api::api_boxes

redef class APIRouter
	redef init do
		super
		use("/user", new APIUserAuth(config, model))
		use("/user/boxes", new APIUserBoxes(config, model))
		use("/user/submissions", new APIUserSubmissions(config, model))
	end
end

# Get the API authentificated user
class APIUserAuth
	super APIAuthHandler

	redef fun get(req, res) do
		var user = get_auth_user(req, res)
		if user == null then return
		user.admin = user.is_admin(config)
		res.json user
	end
end

# Logged user boxes handler
#
# GET: get user boxes
class APIUserBoxes
	super APIAuthHandler
	super APIBoxHandler

	redef fun get(req, res) do
		var user = get_auth_user(req, res)
		if user == null then return
		res.json new JsonArray.from(user.boxes(model))
	end
end

# Logged user submissions
#
# GET: get user submissions
class APIUserSubmissions
	super APIAuthHandler
	super APIBoxHandler

	redef fun get(req, res) do
		var user = get_auth_user(req, res)
		if user == null then return
		res.json new JsonArray.from(user.submissions(model))
	end
end
