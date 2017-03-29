#!/bin/bash

# WIP of a test command

# File hierarchy
#
# Static:
#
# tests/*.in an input of a test case
# tests/*.res an expected output of a test case
# tests.sh  this file
#
# Input:
#
# src/* input user source-files, should be unmodified
#
# Output: (could be safely removed)
#
# out/work the jailed working dir (copies and produced artefacts)
# out/work/src a copy of src
# out/work/tests/*.in a copy of the input of a test case
# out/tests/* the result for each test case:
# out/tests/*.cmd the command executed
# out/tests/*.out the standard output (stdout)
# out/tests/*.err the standard output for errors (stderr)
# out/tests/*.code the exit status code
# out/tests/*.diff the diff with the res file (if any)
# out/tests/*.fail the test has failed (and why)
# out/tests/*.pass the test has succeeded (and why)

# Environments variables used trough the script (instead of passing parameters)
#
# * BOX_OUT the output directory (to clean)
#   It contains the various produced files, results and artefact produced by this script.
#   It is set by default to 'out/'
# * BOX_WORK the jailed work directory
#   It is used as the directory where commands are run
#   It is set by default to '$BOX_OUT/work/'
# * BOX_RUN_NAME the name of the current command. (set by `run`)
#   Each executed by `run` need a name and metadata are tracked
# * BOX_RUN_OUT the output basename for the current command metadata. (set by `run`)
#   It is set by default to '$BOX_OUT/tests/$BOX_RUN_NAME'

set -e

# This run a single command in a jailed work directory and log its results.
#
# $1 is the unique name of the command (used to read an produce metadata)
# the rest is the command to run.
#
# Example:
#
#     run force_make make -B
#     run my_test1 bin/app argument
#
# The various results of the test will be written in the `out/tests/` directory
run() {
	local name=$1
	export BOX_RUN_NAME=$name
	shift

	# Special dry-up behavior if 'list' or 'status' commands are given.
	if [ "$cmd" = "list" ]; then
		echo "$name: $*"
		return 0
	fi

	if [ "$cmd" = "status" ]; then
		status "$name"
		return 0
	fi

	# Run the command
	mkdir -p $BOX_OUT/tests
	local out=$BOX_OUT/tests/$name
	export BOX_RUN_OUT=$out
	rm $out.* 2> /dev/null || true
	echo "$@" > $out.cmd
	./safe_run $BOX_WORK "$@" > $out.out 2> $out.err
	local code=$?

	# Process, check and aggregate the results
	# TODO: move in a subfunction?
	# TODO: how to integrate a user-custom checker?
	echo $code > $out.code
	local res=tests/$name.res
	if [ -e "$res" ]; then
		if diff -u $res $out.out > $out.diff; then
			echo "diff -u $res $out.out" > $out.fail
		fi
	else
		if [ "$code" != "0" ]; then
			echo "Test exited with $code" > $out.fail
			sed 's|^|\t|' $out.err >> $out.fail
		fi
	fi
	if [ ! -e $out.fail ]; then
		touch $out.pass
	fi

	# Display the result
	status "$name"

	unset BOX_RUN_NAME
	unset BOX_RUN_OUT
}

# Display the status of the test named $1 without running it not .
#
# This just check the content of the out/tests/ directory and display the information to the user.
status() {
	local name=$BOX_RUN_NAME
	local out=$BOX_RUN_OUT

	if [ ! -e $out.cmd ]; then
		echo "[NOT RUN] $name."
	elif [ -e $out.pass ]; then
		echo -n "[PASS] $name. "
		cat $out.pass
		echo ""
	elif [ -e $out.fail ]; then
		echo -n "[FAIL] $name."
		cat $out.fail
		echo ""
		return 1
	else
		echo -n "[ABORTED] $name."
	fi
	return 0
}

# Function called when the engine wants to setup the work directory.
#
# pwd is the root directory of the box.
#
# By default, this just call `prepare_core "$@"`.
# Specific scripts can override it and call `prepare_core` themselves.
prepare() {
	prepare_core "$@"
}

# Default behavior of `prepare`
#
# * Create the `out` directory structure.
# * Copy src
# * Copy tests/*.in
#
# You should override `prepare` instead of this function.
prepare_core() {
	export BOX_WORK=$BOX_OUT/work
	mkdir -p $BOX_WORK/tests
	cp -ra tests/*.in $BOX_WORK/tests
	cp -ra src/ $BOX_WORK/
	cp -ra Makefile $BOX_WORK/
}

# Function called when the engine need to build the source, whatever this means
#
# By default, this just call `make` if a Makefile is present in the jailed workdir.
# You might redefine this function but it is often better to implement the build in the Makefile.
build() {
	if test -f $BOX_WORK/Makefile; then
		run "make" "make"
	fi
}

# Function called when the engine need to execute all test-cases.
#
# Each test-case correspond to a file `tests/*.in` where `*` is the name of the test case.
#
# You should not override this function.
check() {
for i in tests/*.in; do
	local name=$(basename "$i" .in)
	run "$name" bin/hello "$i"
done
}

# Run a single test.
#
# $1 the name of the test (eg `test1`)
# $2 the .in file (eg `tests/test1.in`)
#
# This IS the important function to override.
# You must use the `run` command to implement it to the execution is jailed and the metadata are collected.
# E.g.
#
#     run "$1" bin/app < "$2"
#     run "$1" java org.app.Main "$2"
#     run "$1" src/hello.sh $(cat "$2")
runtestcase() {
	echo "runtestcase not implemented" >&2
	return 1
}

# My implementation 
# TODO
runtestcase() {
	run "$1" bin/hello $(cat "$2")
}

export BOX_OUT=out

# The main part of the script
main() {
	prepare
	build
	check
}

# The entry-point of the script
cmd=$1
shift
case "$cmd" in
	help)
		echo "Non!"
		exit 0
		;;
	list|status|test)
		# TODO filter specific tests?
		:
		;;
	*)
		echo 2>&1 "Unknown command $cmd. Use the command 'help'."
		exit 1
		;;
esac

main
