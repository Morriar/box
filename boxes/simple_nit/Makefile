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
	mkdir -p bin
	nitc src/hello.nit --dir bin

files:
	@find src -type f -print

list_tests:
	@ls -1 tests/*.in

runone:
	bin/hello `cat $(IN)`

check:
	../boxme tests

check-submission:
	@../boxme -s $(SUB) -j copy tests

clean:
	rm -rf bin/ out/
