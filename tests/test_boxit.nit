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
module test_boxit is test_suite
import test_suite

import src::model

# Execute a boxme command and return the result
fun boxit_cmd(command: String...): String do
	var p = new ProcessReader("../bin/boxit", command...)
	var res = p.read_all
	p.close
	p.wait
	return res
end

class TestBoxit
	super TestSuite

	redef fun before_test do
		# Drop MAKELEVEL to avoid makelevel output variation
		"MAKELEVEL".setenv("")
		# Force local to avoid l10n variation in messages (e.g. make)
		"LC_ALL".setenv("C")
	end

	# default boxdir
	var boxdir = "data/test_cli"

	# Default boxname
	var boxname = "simple_c"

	# Run a box command with arguments
	fun boxit(args: String) do
		print "== boxit {args} =="
		args = "--dir {boxdir} --box {boxname} {args}"
		print(boxit_cmd(args.split(" ")...))
	end

	# Run a make clean
	fun make(args: String...) do
		print "== make {args.join(" ")} =="
		args.prepend(["-C", boxdir/boxname, "--no-print-directory"])
		print(make_cmd(args...))
	end

	# Make clean and clean submissions
	fun clean do
		make("clean")
		system("rm -r {boxdir/boxname}/submissions/*/out 2> /dev/null")
	end

	fun test_base_cmds do
		clean
		boxit("boxes")
		boxit("subs")
		boxit("checkall")
		boxit("subs")
	end
end
