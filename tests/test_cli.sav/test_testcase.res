== make clean ==
rm -rf out/

== boxme tests ==
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res out/tests/test2.out
	Expected an output but nothing was produced.
[FAIL] test3. diff -u tests/test3.res out/tests/test3.out
	Expected no output but something was produced.
[FAIL] test4. diff -u tests/test4.res out/tests/test4.out
	There are whitespace differences between expected output and the produced output.
	
	To pass the test, there should be no superfluous (nor missing) spaces, tabulations and blank lines.
[FAIL] test5. diff -u tests/test5.res out/tests/test5.out
	There are whitespace differences between expected output and the produced output.
	
	To pass the test, there should be no superfluous (nor missing) spaces, tabulations and blank lines.
[FAIL] test6. diff -u tests/test6.res out/tests/test6.out
	There are whitespace differences between expected output and the produced output.
	
	To pass the test, there should be no superfluous (nor missing) spaces, tabulations and blank lines.

