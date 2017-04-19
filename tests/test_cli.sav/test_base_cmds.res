== make clean ==
rm -rf bin/ out/

== boxme list ==
make: make --no-print-directory
test1: make --no-print-directory -s runone IN=tests/test1.in
test2: make --no-print-directory -s runone IN=tests/test2.in
test3: make --no-print-directory -s runone IN=tests-private/test3.in

== boxme -p list ==
make: make --no-print-directory
test1: make --no-print-directory -s runone IN=tests/test1.in
test2: make --no-print-directory -s runone IN=tests/test2.in

== boxme list-src ==
src/hello.c

== boxme -s src-private list-src ==
src-private/hello.c

== boxme list-tests ==
make
test1 tests/test1.in
test2 tests/test2.in
test3 tests-private/test3.in

== boxme -p list-tests ==
make
test1 tests/test1.in
test2 tests/test2.in

== boxme status ==
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.

== boxme -p status ==
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.

== boxme tests ==
[PASS] make. 
[FAIL] test1. diff -u tests/test1.res out/tests/test1.out
	The expected output and the produced output are different.
[FAIL] test2. diff -u tests/test2.res out/tests/test2.out
	The expected output and the produced output are different.
[FAIL] test3. diff -u tests-private/test3.res out/tests/test3.out
	The expected output and the produced output are different.

== boxme -p tests ==
[PASS] make. 
[FAIL] test1. diff -u tests/test1.res out/tests/test1.out
	The expected output and the produced output are different.
[FAIL] test2. diff -u tests/test2.res out/tests/test2.out
	The expected output and the produced output are different.

== boxme -j copy tests ==
[PASS] make. 
[FAIL] test1. diff -u tests/test1.res out/tests/test1.out
	The expected output and the produced output are different.
[FAIL] test2. diff -u tests/test2.res out/tests/test2.out
	The expected output and the produced output are different.
[FAIL] test3. diff -u tests-private/test3.res out/tests/test3.out
	The expected output and the produced output are different.

== boxme -p -j copy tests ==
[PASS] make. 
[FAIL] test1. diff -u tests/test1.res out/tests/test1.out
	The expected output and the produced output are different.
[FAIL] test2. diff -u tests/test2.res out/tests/test2.out
	The expected output and the produced output are different.

== boxme -j none tests ==
[PASS] make. 
[FAIL] test1. diff -u tests/test1.res out/tests/test1.out
	The expected output and the produced output are different.
[FAIL] test2. diff -u tests/test2.res out/tests/test2.out
	The expected output and the produced output are different.
[FAIL] test3. diff -u tests-private/test3.res out/tests/test3.out
	The expected output and the produced output are different.

== boxme -p -j none tests ==
[PASS] make. 
[FAIL] test1. diff -u tests/test1.res out/tests/test1.out
	The expected output and the produced output are different.
[FAIL] test2. diff -u tests/test2.res out/tests/test2.out
	The expected output and the produced output are different.

== boxme status ==
[PASS] make. 
[FAIL] test1. diff -u tests/test1.res out/tests/test1.out
	The expected output and the produced output are different.
[FAIL] test2. diff -u tests/test2.res out/tests/test2.out
	The expected output and the produced output are different.
[NOT RUN] test3.

== boxme -p status ==
[PASS] make. 
[FAIL] test1. diff -u tests/test1.res out/tests/test1.out
	The expected output and the produced output are different.
[FAIL] test2. diff -u tests/test2.res out/tests/test2.out
	The expected output and the produced output are different.

== make clean ==
rm -rf bin/ out/

== boxme -s src-private tests ==
[PASS] make. 
[PASS] test1. 
[PASS] test2. 
[PASS] test3. 

== boxme -p -s src-private tests ==
[PASS] make. 
[PASS] test1. 
[PASS] test2. 

== boxme -j copy -s src-private tests ==
[PASS] make. 
[PASS] test1. 
[PASS] test2. 
[PASS] test3. 

== boxme -p -j copy -s src-private tests ==
[PASS] make. 
[PASS] test1. 
[PASS] test2. 

== boxme -j none -s src-private tests ==
[PASS] make. 
[PASS] test1. 
[PASS] test2. 
[PASS] test3. 

== boxme -p -j none -s src-private tests ==
[PASS] make. 
[PASS] test1. 
[PASS] test2. 

== boxme status ==
[PASS] make. 
[PASS] test1. 
[PASS] test2. 
[NOT RUN] test3.

== boxme -p status ==
[PASS] make. 
[PASS] test1. 
[PASS] test2. 

