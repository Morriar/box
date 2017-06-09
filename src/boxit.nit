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

# Command line interface for box
#
# Used to see, check and manage boxes and submissions.
module boxit

import model
import json
import opts

redef class Model
	# Command that lists all boxes
	fun cli_boxes do for box in get_boxes do print box.cli_line
end

redef class Box
	# One-liner information
	fun cli_line: String do return "{id} {title} {path}"

	# Command that print multi-line information
	fun cli_info do
		print "{id}: {title} ({path})"
		print "owner: {owner or else "-"}"
		if not active then print "INACTIVE"
	end

	# Command that lists all submissions
	fun cli_subs do for sub in submissions do print sub.cli_line
end

redef class Submission
	# One-liner information
	fun cli_line: String do return "{id}: {status.cli_line}"

	# Command that print multi-line information
	fun cli_info do
		print "{id}: {path}"
		print "user: {user}"
		print "tests: {status.cli_line}"
	end
end

redef class SubmissionResult
	# One-liner information
	fun cli_line: String do
		var st
		if is_passed then
			st = "Passed {tests_passed} tests"
		else if is_runned then
			st = "Failed {tests_failed} tests; passed {tests_passed}"
		else
			st = "Pending"
		end
		return st
	end
end

# Print some verbose information
fun verb(s: String) do
	print s
end

var opt_dir = new OptionArray("Directory of boxes", "--dir")
var opt_box = new OptionString("Box to act on (id or path)", "--box")
var optctx = new OptionContext
optctx.add_option(opt_dir, opt_box)

optctx.parse sys.args
var args = optctx.rest

var errors = optctx.errors
if errors.not_empty then
	for e in errors do print_error e
	exit 1
end

if args.is_empty then
	print """
Usage: boxit [options] [command] [arguments]

Options
"""
	optctx.usage
	print """

Commands
  boxes           list boxes
  subs            list submissions
  check <sub>...  check submissions <sub>
  checkall        check all submissions
  boxme <args>    execute plain script boxme
"""
	return
end


var model = new Model

# Load boxes #

var boxes_dir = opt_dir.value
if boxes_dir.not_empty then
	for dir in boxes_dir do
		model.load_boxes(dir)
	end
	verb "Loaded {model.boxes.length} boxes from {boxes_dir.length} directories"
end

var cmd = args.pop

# Multi-boxes commands #

if cmd == "boxes" then
	model.cli_boxes
	return
end

# Load a single box #

var box_name = opt_box.value
if box_name == null then
	box_name = "."
	if not model.is_box(box_name) then
		print_error "Current directory is not a box. Maybe --box is needed?"
		exit 1
	end
end

var box = model.get_box(box_name)
if box == null then box = model.load_box(box_name)
if box == null then
	print_error "{box_name}: box does not exist"
	exit 1
	abort
end

# Single-box commands #

if cmd == "subs" then
	box.cli_subs
	return
else if cmd == "check" then
	if args.is_empty then
		print "{cmd}: missing submissions to tests"
	end
	for a in args do
		var sub = box.get_submission(a)
		if sub == null then
			print "{a}: unknown submission"
			continue
		end
		sub.check
		sub.cli_info
	end
	return
else if cmd == "checkall" then
	for sub in box.submissions do
		sub.check
		sub.cli_info
	end
	return
else if cmd == "boxme" then
	print box.boxme(args...)
	return
else
	print_error "{cmd}: unknown command"
	exit 1
end
