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

# Base authentification services
module api_auth

import api_base

# The common auth router
# Specific auth method can refine the class and plug additional handler
class AuthRouter
	super Router

	# App config
	var config: AppConfig

	init do
		super
		use("/logout", new Logout)
	end
end

redef class Session
	# The current logged user
	var user: nullable User = null is writable

	# Page to redirect on successful authentication
	var auth_next: nullable String = null is writable
end

# Reload session player from db between pages
class SessionRefresh
	super Handler

	redef fun all(req, res) do
		super
		var session = req.session
		if session == null then return
		var user = session.user
		if user == null then return
		session.user = user
	end
end

# Logout handler
#
# Basically write `null` in `req.session`.
# Redefine it if you need to do more.
class Logout
	super Handler
	redef fun get(req, res) do
		var session = req.session
		if session == null then return
		session.user = null
		res.redirect "/"
	end
end

# Common services related to authentication/login.
abstract class AuthLogin
	super Handler

	# App config
	var config: AppConfig

	# Extract a possible next page from the GET arguments and store it in the session for later
	#
	# Helper method to use before initiating a login attempt.
	fun store_next_page(req: HttpRequest) do
		var session = req.session
		if session == null then return

		var next = req.string_arg("next")
		if next != null then next = next.from_percent_encoding
		session.auth_next = next
	end

	# Redirect to the `next` page.
	#
	# Helper method to use at the end of the login attempt.
	fun redirect_after_login(req: HttpRequest, res: HttpResponse) do
		var session = req.session
		if session == null then return

		var next = session.auth_next or else "/player"
		session.auth_next = null
		res.redirect next
	end
end

# Abstract authentification handler
#
# Subclass this handler if you need to access the authentificated user.
#
# See `AuthHandler::get_auth_user`
abstract class AuthHandler
	super APIHandler

	# Get the authentification user if any.
	#
	# If no `req.session` or no `req.session.user` is found, then set `res.status = 403`
	# and return  null.
	fun get_auth_user(req: HttpRequest, res: HttpResponse): nullable User do
		var session = req.session
		if session == null then
			res.api_error("Unauthorized", 403)
			return null
		end
		var user = session.user
		if user == null then
			res.api_error("Unauthorized", 403)
			return null
		end
		return user
	end
end
