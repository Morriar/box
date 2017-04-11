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

all:
	pwd
	mkdir -p bin/
	cp src/trap src/pep8os.pepo bin/
	cd bin/ && asem8 ../src/romcryption.pep
	mv src/romcryption.pepo bin/

files:
	@echo "src/romcryption.pep"

list_tests:
	@ls -1 tests/*.in

runone:
	echo -n "" > bin/canned_command
	echo "l" >> bin/canned_command
	echo "romcryption" >> bin/canned_command
	echo "i" >> bin/canned_command
	echo "f" >> bin/canned_command
	echo "../$(IN)" >> bin/canned_command
	echo "o" >> bin/canned_command
	echo "f" >> bin/canned_command
	echo "out" >> bin/canned_command
	echo "x" >> bin/canned_command
	echo "q" >> bin/canned_command
	cd bin && pep8 < canned_command > /dev/null 2>&1
	echo "" >> bin/out
	cat bin/out

check:
	../../boxme tests

check-submission:
	@../boxme -s $(SUB) -j copy tests

clean:
	rm -rf bin/ out/
