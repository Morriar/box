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

cmd=$1

case "$cmd" in
	help)
		echo "Non!"
		exit 0
		;;
	list)
		echo "compile"
		echo "run"
		exit 0
		;;
	status)
		;;
esac

# This run a single test in the current out directory
#
# $1 is the name
# the rest is the command to run.
#
# Example:
#
#     runtest my_test1 bin/app argument
#
#
# The various results of the test will be written in the `out/tests/` directory
runtest() {
	local name=$1
	shift

	mkdir -p out/tests
	local out=out/tests/$name
	echo "$@" > $out.cmd
	./safe_run out/work/ "$@" > $out.out 2> $out.err
	local code=$?
	echo $code > $out.code

	local res=tests/$name.res
	if [ -e "$res" ]; then
		if diff -u $res $out.out > $out.diff; then
			echo "[FAIL] $name. diff -u $res $out.out"
			return 1
		fi
	else
		if [ "$code" != "0" ]; then
			echo "[FAIL] $name. Test exited with $code"
			sed 's|^|\t|' $out.err
			return 1
		fi
	fi
	echo "[PASS] $name."
	return 0
}

# Prepare the out/work working directory
mkdir -p out/work/bin
mkdir -p out/work/tests
cp -ra tests/*.in out/work/tests
cp -ra src/ out/work/

# run some tests (manually at the moment)
runtest nitc nitc src/hello.nit --dir bin
runtest run bin/hello
for i in tests/*.in; do
	bi=$(basename "$i" .in)
	runtest "$bi" bin/hello "$i"
done
