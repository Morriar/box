# BOXME

This is the scratchpad for the boxme program used to

## BOX and BOXME

A BOX is a directory containing tests, configuration and other things used to validate a submission for a programming exercise or competition.
The point of the BOX is to be simple to setup, safe enough to run untrusted code, and agnostic to the used technologies.

## Format of a BOX

A BOX is a directory with expected files.

In the root of the box

* `Makefile` A simple makefile to build the submission. (recommended)
* `tests/*.in` The inputs of the tests
  `*` is the name of the test and should be a simple identifier.
  e.g. `tests/test1.in`.
* `bin/runtestcase.sh` The script used to run a single test case.
  The argument is the path of the `.in` file to test.
  The result should be written to stdout, and error messages to stderr.
  If the return value is non-zero, the test is considered failed.
* `tests/*.res` The expected output for the tests, if any
  The result of `bin/runtestcase.sh` is diffed with it.
  If there is difference, the test is considered failed.
* `src/` The base source code.
* `boxme.local.sh` The local configuration and overriding of the boxme.

## The boxme program

boxme accepts a first argument that is the command to execute.
Use `boxme help` to get the help.

## Results

The results are stored in the out directory.

* `out/work` is the workdir
* `out/tests` is the directory with the tests results:
  * `out/tests/*.cmd` the executed command
  * `out/tests/*.out` the stdout of each test
  * `out/tests/*.err` the stderr of each test
  * `out/tests/*.code` the return value of each test
  * `out/tests/*.fail` exists if the test failed (and contains the message)
  * `out/tests/*.pass` exists if the test passed
  * `out/tests/*.diff` contains the diff with the saved .res file
