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

# Use the nitunit infrastructure to test the boxme cli interface.
module test_cli is test_suite
import test_suite

import src::model

class TestBoxCli
	super TestSuite

	redef fun before_test
	do
		# Drop MAKELEVEL to avoid makelevel output variation
		"MAKELEVEL".setenv("")
		# Force local to avoid l10n variation in messages (e.g. make)
		"LC_ALL".setenv("C")
	end

	# default boxdir
	var boxdir = "data/test_cli/simple_c/"

	# Run a box command with arguments
	fun box(args: String)
	do
		print "== boxme {args} =="
		args = "-C {boxdir} {args}"
		print(boxme_cmd(args.split(" ")...))
	end

	# Run a box with and without the -p flag
	fun boxp(args: String)
	do
		box(args)
		box("-p {args}")
	end

	# Run a box command with all -j flags and -p
	fun boxj(args: String)
	do
		boxp(args)
		boxp("-j copy {args}")
		boxp("-j none {args}")
		#boxp("-j firejail {args}")
	end

	# Run a make clean
	fun make(args: String...)
	do
		print "== make {args.join(" ")} =="
		args.prepend(["-C", boxdir, "--no-print-directory"])
		print(make_cmd(args...))
	end

	# Make clean and clean submissions
	fun clean do
		make("clean")
		system("rm -r {boxdir}/submissions/*/out 2> /dev/null")
	end

	fun test_base_cmds do
		clean
		boxp("list")
		box("list-src")
		box("-s src-private list-src")
		boxp("list-tests")
		boxp("status")

		boxj("tests")
		boxp("status")

		clean
		boxj("-s src-private tests")
		boxp("status")
	end

	fun test_sub do
		clean
		box("sub")
		box("sub list")
		boxp("sub status")

		boxp("sub sub1")
		boxp("sub sub1 list")
		boxp("sub sub1 list-src")
		boxp("sub sub1 list-tests")
		boxp("sub sub1 status")

		boxj("sub sub1 tests")
		boxp("sub sub1 status")
		boxp("sub sub1")
		boxp("sub")

		boxj("sub tests")
		boxp("sub sub2 status")
		boxp("sub sub1")
		boxp("sub")

		boxp("sub status")
	end

	fun test_user do
		clean
		boxp("user")
		boxp("user list")
		boxp("user status")
		boxp("user tests")
		boxp("user list")
		boxp("user status")
	end

	fun test_testcase do
		boxdir = "data/test_cli/testcase/"
		clean
		box("tests")
	end
end
