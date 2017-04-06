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

# API base services
module api_base

import model
import config
import popcorn

# Basic API Handler
abstract class APIHandler
	super Handler

	# App config
	var config: AppConfig

	# Box model
	var model: Model
end

# Basic API Router
class APIRouter
	super Router

	# App config
	var config: AppConfig

	# Box model
	var model: Model
end

redef class HttpResponse

	# Return a JSON error
	#
	# Format:
	# ~~~json
	# { message: "Not found", status: 404 }
	# ~~~
	fun api_error(message: String, status: Int) do
		var obj = new JsonObject
		obj["status"] = status
		obj["message"] = message
		json_error(obj, status)
	end
end
