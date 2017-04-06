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
