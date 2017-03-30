# BOXME

This is the scratchpad for the boxme program used to

## BOX and BOXME

A BOX is a directory containing tests, configuration and other things used to validate a submission for a programming exercise or competition.
The point of the BOX is to be simple to setup, safe enough to run untrusted code, and agnostic to the used technologies.

## Format of a BOX

A BOX is a directory with expected files.

The root of the box should contains the following files and directory:

* `Makefile` A simple makefile to build the submission.
* `tests` The inputs and outputs of each tests
* `src` The source (or the submission template)
* `boxme.local.sh` The local configuration and overriding of the boxme. (optional)

### Makefile

The default rule should build the source from the src directory.

The `runone` rule should execute the binany and is used to run a single test case.
The $(IN) parameter will be the path of the input file.
The result should be written to stdout, and error messages to stderr.
If the return value is non-zero, the test is considered failed.

A sample Makefile is

~~~Makefile
all:
	mkdir -p bin
	nitc src/hello.nit --dir bin
runone:
	bin/hello "$(IN)"
~~~

### Tests

The `tests/` directory contains the tests. e.g.

* `tests/test1.in`.
* `tests/test1.res`.
* `tests/test2.in`.
* `tests/test2.res`.

Where `tests/*.in` is the inputs of the tests and `tests/*.res` the expected output.

The result of `make runone` is diffed with it.
If there is difference, the test is considered failed.

### Source

`src/` is the base source code.

## The boxme program

boxme accepts a first argument that is the command to execute.
Use `boxme help` to get the help.

## Results

The results are stored in the out directory.

* `out/work` is the workdir
* `out/tests` is the directory with the tests results:
  * `out/tests/*.cmd` the executed command
  * `out/tests/*.log` a log of various information
  * `out/tests/*.out` the stdout of each test
  * `out/tests/*.err` the stderr of each test
  * `out/tests/*.code` the return value of each test
  * `out/tests/*.fail` exists if the test failed (and contains the message)
  * `out/tests/*.pass` exists if the test passed
  * `out/tests/*.diff` contains the diff with the saved .res file
