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
import markdown

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

redef class Box

	# README.md as HTML
	var html_readme: nullable String is lazy do
		var readme = self.readme
		if readme == null then return null
		var proc = new MarkdownProcessor
		proc.emitter.decorator = new DescDecorator(path, "data")
		return proc.process(readme).write_to_string
	end

	redef fun core_serialize_to(s) do
		super
		s.serialize_attribute("readme", html_readme)
	end
end

redef class User
	serialize

	# Is this user admin?
	#
	# Used by frontend to display admin related controls.
	var admin = false is writable

	# Is this user an admin?
	#
	# Users are admin if their ID matches one in the `AppConfig::admin_ids` list.
	fun is_admin(config: AppConfig): Bool do
		return config.admin_ids.has(id)
	end
end

# Box description markdown decorator
#
# Used to extract assets from box markdown description and make them public in
# the frontend site.
class DescDecorator
	super HTMLDecorator

	# The directory to find original local resources (links and images)
	var ressources_dir: String

	# Storage directory to put copied resources
	# Assume it will be served as is by nitcorn
	var data_dir: String

	# Copy a local resource to the storage directory.
	#
	# If it is successful, return a new link.
	# If the link is not local, return `null`.
	# If the resource is not found, return `null`.
	fun copy_ressource(link: String): nullable String
	do
		# Keep absolute links as is
		if link.has_prefix("http://") or link.has_prefix("https://") then
			return null
		end

		# Get the full path to the local resource
		var fulllink = ressources_dir / link
		var stat = fulllink.file_stat
		if stat == null then
			print_error "Error: cannot find local resource `{link}`"
			return null
		end

		# Get a collision-free name for the resource
		var hash = fulllink.md5
		var ext = fulllink.file_extension
		if ext != null then hash = hash + "." + ext

		# Copy the local resource in the resource directory of the catalog
		data_dir.mkdir
		var res = data_dir / hash
		fulllink.file_copy_to(res)

		# Produce a new absolute link for the HTML
		var new_link = "/" / data_dir / hash
		#print "{link} -> {new_link}; as {res}"
		return new_link
	end

	redef fun add_image(v, link, name, comment)
	do
		var new_link = copy_ressource(link.to_s)

		if new_link == null then
			super
		else
			super(v, new_link, name, comment)
		end
	end

	redef fun add_link(v, link, name, comment)
	do
		var new_link = copy_ressource(link.to_s)

		if new_link == null then
			super
		else
			super(v, new_link, name, comment)
		end
	end
end
