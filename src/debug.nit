import api

redef class AppConfig
	# The default user, if any, that will be logged on a new session
	var debug_user: String is lazy do return ini["app.debug.user"] or else "dev"

	redef fun admin_ids do
		var res = super
		res.add "dev"
		return res
	end
end

redef class Session
	# Was the session auto logged by `debug_user`?
	# Used to allow a real logout by not auto-login again and again.
	var auto_logged = false
end

redef class SessionRefresh
	redef fun all(req, res) do
		super
		var debug_user = config.debug_user
		if debug_user == "" then return

		var session = req.session
		if session == null then return
		if session.auto_logged then return
		var player = session.user
		if player == null then
			session.user = new User(debug_user, debug_user, "https://www.gravatar.com/avatar/")
			session.auto_logged = true
		end
	end
end
