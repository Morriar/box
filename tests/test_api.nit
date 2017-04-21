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

module test_api is test_suite

import popcorn::pop_tests
import debug

abstract class TestAPI
	super TestPopcorn

	var config: AppConfig
	var model: Model
	var app: App

	var testid: Int = "NIT_TESTING_ID".environ.to_i

	redef fun before_test do
		# Drop MAKELEVEL to avoid makelevel output variation
		"MAKELEVEL".setenv("")
		# Force local to avoid l10n variation in messages (e.g. make)
		"LC_ALL".setenv("C")

		config = new AppConfig
		config.parse_options(new Array[String])

		model = new Model
		model.load_boxes("data/test_api")

		app = new App
		app.use_before("/*", new SessionInit)
		app.use_before("/*", new SessionRefresh(config))
		app.use("/api", new APIRouter(config, model))
	end

	fun clean_submissions(box_id: String) do
		system "rm -rf data/test_api/{box_id}/submissions"
	end
end

class TestAPIUser
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/user"
	end

	fun test_api_user do run_test(app)
end

class TestAPIUserBoxes
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/user/boxes"
	end

	fun test_api_user_boxes do run_test(app)
end

class TestAPIUserSubmissions
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/user/submissions"
	end

	fun test_api_user_submissions do run_test(app)
end

class TestAPISearch
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/search"
		system "curl -s {host}:{port}/api/search?q=foo"
		system "curl -s {host}:{port}/api/search?q=BoxJava"
		system "curl -s {host}:{port}/api/search?q=dev:BoxJava"
		system "curl -s {host}:{port}/api/search?q=dev"
	end

	fun test_api_search do run_test(app)
end

class TestAPIBoxes
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/boxes"
	end

	fun test_api_boxes do run_test(app)
end

class TestAPIBox
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/boxes/NOTFOUND"
		system "curl -s {host}:{port}/api/boxes/dev:BoxJava"
		system "curl -s {host}:{port}/api/boxes/dev:BoxNit"
		system "curl -s {host}:{port}/api/boxes/BoxPep"
	end

	fun test_api_box do run_test(app)
end

class TestAPIBoxTests
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/boxes/NOTFOUND"
		system "curl -s {host}:{port}/api/boxes/dev:BoxNit/tests"
		system "curl -s {host}:{port}/api/boxes/BoxPep/tests"
	end

	fun test_api_box_tests do run_test(app)
end

class TestAPIBoxSubmissions
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/boxes/NOTFOUND/submissions"
		system "curl -s {host}:{port}/api/boxes/dev:BoxNit/submissions"
		system "curl -s {host}:{port}/api/boxes/BoxPep/submissions"
	end

	fun test_api_box_submissions do run_test(app)
end

class TestAPIBoxSubmission
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/boxes/NOTFOUND/submissions/NOTFOUND"
		system "curl -s {host}:{port}/api/boxes/dev:BoxNit/submissions/NOTFOUND"
		system "curl -s {host}:{port}/api/boxes/dev:BoxNit/submissions/1491971159000_dev"
		system "curl -s {host}:{port}/api/boxes/BoxPep/submissions/1491970595000_dev"
		system "curl -s {host}:{port}/api/boxes/BoxPep/submissions/1491970695000_dev"
	end

	fun test_api_box_submission do run_test(app)
end

class TestAPIBoxSubmit
	super TestAPI

	redef fun client_test do
		system "curl -s {host}:{port}/api/boxes/NOTFOUND/submit"
		system "curl -s {host}:{port}/api/boxes/BoxPep/submit"
		system "curl -s {host}:{port}/api/boxes/dev:BoxNit/submit"
		clean_submissions("BoxJava")
		system "curl -s {host}:{port}/api/boxes/dev:BoxJava/submit"
		clean_submissions("BoxJava")
	end

	fun test_api_box_submit do run_test(app)
end

class TestAPIBoxSubmitPost
	super TestAPI

	redef fun client_test do
		system "curl -X POST -s {host}:{port}/api/boxes/NOTFOUND/submit"

		var box = model.get_box("dev:BoxJava").as(not null)
		var files = box.source_files
		var sub = new SubmissionForm(files)
		var json = "test_api_box_submit_post.json"
		sub.to_json.write_to_file json
		system "curl -X POST -d @{json} -s {host}:{port}/api/boxes/{box.id}/submit"
		system "rm -f {json}"
		clean_submissions("BoxJava")
	end

	fun test_api_box_submit_post do run_test(app)
end

class TestAPIBoxSubmitPut
	super TestAPI

	redef fun client_test do
		system "curl -X PUT -s {host}:{port}/api/boxes/NOTFOUND/submit"
		system "curl -X PUT -s {host}:{port}/api/boxes/dev:BoxNit/submit"

		var box = model.get_box("dev:BoxJava").as(not null)
		var files = box.source_files
		var sub = new SubmissionForm(files)
		var json = "test_api_box_submit_put.json"
		sub.to_json.write_to_file json
		system "curl -X PUT -d @{json} -s {host}:{port}/api/boxes/{box.id}/submit"
		system "rm -f {json}"
		clean_submissions("BoxJava")
	end

	fun test_api_box_submit_put do run_test(app)
end

redef class Submission
	redef var timestamp = 0
end
