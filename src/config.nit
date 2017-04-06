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

module config

import popcorn::pop_config

redef class AppConfig

	# --admins
	var opt_admins = new OptionArray("List of user ids to treat as admin.", "--admins")

	init do
		super
		add_option(opt_admins)
	end

	# List of admin user ids
	#
	# See `User::is_admin`
	fun admin_ids: Array[String] do
		var opt = opt_admins.value
		if not opt.is_empty then
			return opt
		end
		var res = new Array[String]
		for id in (ini["admins"] or else "").split(",") do
			id = id.trim
			if id.is_empty then continue
			res.add id
		end
		return res
	end

	# Site root url to use for some redirect
	# Useful if behind some reverse proxy
	fun app_root_url: String do
		var host = app_host
		var port = app_port
		var url = "http://{host}"
		if port != 80 then url += ":{port}"
		return ini["app.root_url"] or else url
	end
end
