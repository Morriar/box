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

module test_model is test_suite

import model
import test_suite

class TestModel
	super TestSuite

	var model: Model

	redef fun before_test do
		model = new Model
	end

	fun test_is_box do
		assert model.is_box("data/test_model/box1")
		assert model.is_box("data/test_model/box2")
		assert not model.is_box("data/test_model/box3")
		assert model.is_box("data/test_model/box4")
	end

	fun test_load_boxes do
		model.load_boxes("data/test_model/")
		assert model.boxes.has_key("box1")
		assert model.boxes.has_key("BOX2")
		assert not model.boxes.has_key("box3")
		assert model.boxes.has_key("terrasa_a:Box4")
	end

	fun test_get_box do
		model.load_boxes("data/test_model/")
		assert model.get_box("box1") != null
		assert model.get_box("BOX2") != null
		assert model.get_box("box3") == null
		assert model.get_box("terrasa_a:Box4") != null
	end
end

class TestUser
	super TestSuite

	fun test_user_boxes do
		var model = new Model
		model.load_boxes("data/test_model/")

		var user = new User("terrasa_a")
		var boxes = user.boxes(model)

		assert boxes.length == 1
		assert boxes[0].id == "terrasa_a:Box4"
	end
end

class TestBox
	super TestSuite

	fun test_source_files_list do
		var box = new Box("data/test_model/box1")
		assert box.source_files_list == ["src/file1.src", "src/file2.src"]

		box = new Box("data/test_model/box2")
		assert box.source_files_list == ["src/dir1/file2.src", "src/file1.src"]
	end

	fun test_box_title do
		var box = new Box("data/test_model/box1")
		assert box.title == "box1"
		box = new Box("data/test_model/box5")
		assert box.title == "BOX5"
	end

	fun test_box_readme do
		var box = new Box("data/test_model/box1")
		assert box.readme == null
		box = new Box("data/test_model/box4")
		assert box.readme == "README content\n"
	end

	fun test_box_active do
		var box = new Box("data/test_model/box1")
		assert box.is_active
		box = new Box("data/test_model/box4")
		assert not box.is_active
		box = new Box("data/test_model/box5")
		assert not box.is_active
	end

	fun test_box_allow_submissions do
		var box = new Box("data/test_model/box1")
		assert box.allow_submissions
		box = new Box("data/test_model/box2")
		assert not box.allow_submissions
		box = new Box("data/test_model/box4")
		assert box.allow_submissions
	end

	fun test_box_close_date do
		var box = new Box("data/test_model/box1")
		assert box.close_date == null
		box = new Box("data/test_model/box5")
		assert box.close_date == 1491442535000
	end

	fun test_list_tests do
		var box = new Box("data/test_model/box4")
		var tests = box.tests
		assert tests.length == 4
		assert tests[0].name == "make"
		assert tests[0].in_path == null
		assert tests[0].res_path == null
		assert not tests[0].is_private
		assert tests[1].name == "test1"
		assert tests[1].in_path == "tests/test1.in"
		assert tests[1].res_path == "tests/test1.res"
		assert not tests[1].is_private
		assert tests[2].name == "test2"
		assert tests[2].in_path == "tests/test2.in"
		assert tests[2].res_path == "tests/test2.res"
		assert not tests[2].is_private
		assert tests[3].name == "test3"
		assert tests[3].in_path == "tests-private/test3.in"
		assert tests[3].res_path == "tests-private/test3.res"
		assert tests[3].is_private
	end

	fun test_list_public_tests do
		var box = new Box("data/test_model/box4")
		var tests = box.public_tests
		print box.public_tests
		assert tests.length == 3
		assert tests[0].name == "make"
		assert tests[0].in_path == null
		assert tests[0].res_path == null
		assert not tests[0].is_private
		assert tests[1].name == "test1"
		assert tests[1].in_path == "tests/test1.in"
		assert tests[1].res_path == "tests/test1.res"
		assert not tests[1].is_private
		assert tests[2].name == "test2"
		assert tests[2].in_path == "tests/test2.in"
		assert tests[2].res_path == "tests/test2.res"
		assert not tests[2].is_private
	end

	fun test_list_private_tests do
		var box = new Box("data/test_model/box4")
		var tests = box.private_tests
		assert tests.length == 1
		assert tests[0].name == "test3"
		assert tests[0].in_path == "tests-private/test3.in"
		assert tests[0].res_path == "tests-private/test3.res"
		assert tests[0].is_private
	end

	fun test_source_files do
		var box = new Box("data/test_model/box1")
		var files = box.source_files
		assert files[0].filename == "file1.src"
		assert files[0].path == "src/file1.src"
		assert files[0].extension == "src"
		assert files[0].content == "file1 content\n"
		assert files[1].filename == "file2.src"
		assert files[1].path == "src/file2.src"
		assert files[1].extension == "src"
		assert files[1].content == "file2 content\n"
	end

	fun test_source_owner do
		var box = new Box("data/test_model/box1")
		assert box.id == "box1"
		assert box.owner == null
		box = new Box("data/test_model/box4")
		assert box.id == "terrasa_a:Box4"
		assert box.owner == "terrasa_a"
	end

	fun test_last_submission do
		var user = new User("dev")
		var box = new Box("data/test_model/box1")
		box.clean_submissions
		assert box.submissions.is_empty

		var sub = box.last_submission(user)
		var id = sub.id
		assert sub.user == "dev"
		assert box.submissions.length == 1

		sub = box.last_submission(user)
		assert sub.id == id
		assert box.submissions.length == 1

		box.clean_submissions
	end

	fun test_get_submission do
		var user = new User("dev")
		var box = new Box("data/test_model/box1")
		box.clean_submissions
		assert box.submissions.is_empty

		var sub = null
		sub = box.last_submission(user)
		var id = sub.id
		assert sub.user == "dev"
		assert box.submissions.length == 1

		sub = box.get_submission(id)
		assert sub != null
		assert sub.id == id

		box.clean_submissions
	end

	fun test_submissions do
		var box = new Box("data/test_model/box1")
		box.clean_submissions
		assert box.submissions.is_empty

		var sub = new Submission(box, "user1", box.source_files)
		sub.save_files
		assert box.submissions.length == 1

		sub = new Submission(box, "user2", box.source_files)
		sub.save_files
		assert box.submissions.length == 2

		box.clean_submissions
	end

	fun test_user_submissions do
		var box = new Box("data/test_model/box1")
		box.clean_submissions
		assert box.submissions.is_empty

		var u1 = new User("user1")
		var sub = new Submission(box, u1.id, box.source_files)
		sub.save_files
		assert box.user_submissions(u1).length == 1

		var u2 = new User("user2")
		sub = new Submission(box, u2.id, box.source_files)
		sub.save_files
		assert box.user_submissions(u1).length == 1
		assert box.user_submissions(u2).length == 1

		1.0.sleep

		sub = new Submission(box, u1.id, box.source_files)
		sub.save_files
		assert box.user_submissions(u1).length == 2
		assert box.user_submissions(u2).length == 1

		box.clean_submissions
	end
end

class TestSourceFile
	super TestSuite

	fun test_source_file do
		var path = "data/test_model/box1/src/file1.src"
		var file = new SourceFile(path, path.to_path.read_all)
		assert file.filename == "file1.src"
		assert file.extension == "src"
		assert file.content == "file1 content\n"
	end
end
