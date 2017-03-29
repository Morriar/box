# BOXME

This is the scratchpad for the boxme program used to

## BOX and BOXME

A BOX is a directory containing tests, configuration and other things used to validate a submission for a programming exercice or competition.
The point of the BOX is to be simple to setup, safe enough to run untrusted code, and agnostic to the used technologies.

## Format of a BOX

A BOX is a directory with expected files.

In the root of the box

* `boxme.local.sh` The local configuration of the tools, see `boxme` section for details. (mandatory)
* `Makefile`. A simple makefile to build the submission. (recommanded)
* `tests/*.in` The inputs of the tests
* `tests/*.res` The expected output for the tests
* `src/` The base source code

## The boxme program

boxme is the program

boxme accepts a first argument that is the command to execute.
Use `boxme help` to get the help.

You MUST have a `boxme.local.sh` file that implement the function `runtestcase`.
