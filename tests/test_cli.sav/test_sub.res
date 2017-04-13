== make clean ==
rm -rf bin/ out/

== boxme sub ==
submissions/10_user1: not run
submissions/10_user2: not run
submissions/1_user1: not run
submissions/1_user2: not run
submissions/1_user3: not run
submissions/2_user1: not run
submissions/2_user2: not run
submissions/sub1: not run
submissions/sub2: not run

== boxme sub list ==
submissions/10_user1: not run
submissions/10_user2: not run
submissions/1_user1: not run
submissions/1_user2: not run
submissions/1_user3: not run
submissions/2_user1: not run
submissions/2_user2: not run
submissions/sub1: not run
submissions/sub2: not run

== boxme sub status ==
# submissions/10_user1/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/10_user2/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/1_user1/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/1_user2/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/1_user3/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/2_user1/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/2_user2/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/sub1/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/sub2/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.

== boxme -p sub status ==
# submissions/10_user1/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# submissions/10_user2/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# submissions/1_user1/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# submissions/1_user2/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# submissions/1_user3/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# submissions/2_user1/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# submissions/2_user2/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# submissions/sub1/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# submissions/sub2/
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.

== boxme sub sub1 ==
0 run, 0 passed, 0 failed

== boxme -p sub sub1 ==
0 run, 0 passed, 0 failed

== boxme sub sub1 list ==
make: make --no-print-directory
test1: make --no-print-directory -s runone IN=tests/test1.in
test2: make --no-print-directory -s runone IN=tests/test2.in
test3: make --no-print-directory -s runone IN=tests-private/test3.in

== boxme -p sub sub1 list ==
make: make --no-print-directory
test1: make --no-print-directory -s runone IN=tests/test1.in
test2: make --no-print-directory -s runone IN=tests/test2.in

== boxme sub sub1 list-src ==
submissions/sub1/src/hello.c

== boxme -p sub sub1 list-src ==
submissions/sub1/src/hello.c

== boxme sub sub1 list-tests ==
make
test1 tests/test1.in
test2 tests/test2.in
test3 tests-private/test3.in

== boxme -p sub sub1 list-tests ==
make
test1 tests/test1.in
test2 tests/test2.in

== boxme sub sub1 status ==
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.

== boxme -p sub sub1 status ==
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.

== boxme sub sub1 tests ==
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1/out/tests/test2.out

[FAIL] test3. diff -u tests-private/test3.res submissions/sub1/out/tests/test3.out


== boxme -p sub sub1 tests ==
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1/out/tests/test2.out


== boxme -j copy sub sub1 tests ==
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1/out/tests/test2.out

[FAIL] test3. diff -u tests-private/test3.res submissions/sub1/out/tests/test3.out


== boxme -p -j copy sub sub1 tests ==
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1/out/tests/test2.out


== boxme -j none sub sub1 tests ==
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1/out/tests/test2.out

[FAIL] test3. diff -u tests-private/test3.res submissions/sub1/out/tests/test3.out


== boxme -p -j none sub sub1 tests ==
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1/out/tests/test2.out


== boxme sub sub1 status ==
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1/out/tests/test2.out

[NOT RUN] test3.

== boxme -p sub sub1 status ==
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1/out/tests/test2.out


== boxme sub sub1 ==
3 run, 2 passed, 1 failed

== boxme -p sub sub1 ==
3 run, 2 passed, 1 failed

== boxme sub ==
submissions/10_user1: 0 run, 0 passed, 0 failed
submissions/10_user2: 0 run, 0 passed, 0 failed
submissions/1_user1: 0 run, 0 passed, 0 failed
submissions/1_user2: 0 run, 0 passed, 0 failed
submissions/1_user3: 0 run, 0 passed, 0 failed
submissions/2_user1: 0 run, 0 passed, 0 failed
submissions/2_user2: 0 run, 0 passed, 0 failed
submissions/sub1: 3 run, 2 passed, 1 failed
submissions/sub2: 0 run, 0 passed, 0 failed

== boxme -p sub ==
submissions/10_user1: 0 run, 0 passed, 0 failed
submissions/10_user2: 0 run, 0 passed, 0 failed
submissions/1_user1: 0 run, 0 passed, 0 failed
submissions/1_user2: 0 run, 0 passed, 0 failed
submissions/1_user3: 0 run, 0 passed, 0 failed
submissions/2_user1: 0 run, 0 passed, 0 failed
submissions/2_user2: 0 run, 0 passed, 0 failed
submissions/sub1: 3 run, 2 passed, 1 failed
submissions/sub2: 0 run, 0 passed, 0 failed

== boxme sub tests ==
# submissions/10_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/10_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user3/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/sub1/
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1//out/tests/test2.out

[FAIL] test3. diff -u tests-private/test3.res submissions/sub1//out/tests/test3.out

# submissions/sub2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1


== boxme -p sub tests ==
# submissions/10_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/10_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user3/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/sub1/
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1//out/tests/test2.out

# submissions/sub2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1


== boxme -j copy sub tests ==
# submissions/10_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/10_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user3/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/sub1/
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1//out/tests/test2.out

[FAIL] test3. diff -u tests-private/test3.res submissions/sub1//out/tests/test3.out

# submissions/sub2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1


== boxme -p -j copy sub tests ==
# submissions/10_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/10_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user3/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/sub1/
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1//out/tests/test2.out

# submissions/sub2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1


== boxme -j none sub tests ==
# submissions/10_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/10_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user3/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/sub1/
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1//out/tests/test2.out

[FAIL] test3. diff -u tests-private/test3.res submissions/sub1//out/tests/test3.out

# submissions/sub2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1


== boxme -p -j none sub tests ==
# submissions/10_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/10_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/1_user3/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/2_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# submissions/sub1/
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1//out/tests/test2.out

# submissions/sub2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1


== boxme sub sub2 status ==
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.

== boxme -p sub sub2 status ==
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.

== boxme sub sub1 ==
3 run, 2 passed, 1 failed

== boxme -p sub sub1 ==
3 run, 2 passed, 1 failed

== boxme sub ==
submissions/10_user1: 1 run, 0 passed, 1 failed
submissions/10_user2: 1 run, 0 passed, 1 failed
submissions/1_user1: 1 run, 0 passed, 1 failed
submissions/1_user2: 1 run, 0 passed, 1 failed
submissions/1_user3: 1 run, 0 passed, 1 failed
submissions/2_user1: 1 run, 0 passed, 1 failed
submissions/2_user2: 1 run, 0 passed, 1 failed
submissions/sub1: 3 run, 2 passed, 1 failed
submissions/sub2: 1 run, 0 passed, 1 failed

== boxme -p sub ==
submissions/10_user1: 1 run, 0 passed, 1 failed
submissions/10_user2: 1 run, 0 passed, 1 failed
submissions/1_user1: 1 run, 0 passed, 1 failed
submissions/1_user2: 1 run, 0 passed, 1 failed
submissions/1_user3: 1 run, 0 passed, 1 failed
submissions/2_user1: 1 run, 0 passed, 1 failed
submissions/2_user2: 1 run, 0 passed, 1 failed
submissions/sub1: 3 run, 2 passed, 1 failed
submissions/sub2: 1 run, 0 passed, 1 failed

== boxme sub status ==
# submissions/10_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/10_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/1_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/1_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/1_user3/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/2_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/2_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# submissions/sub1/
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1//out/tests/test2.out

[NOT RUN] test3.
# submissions/sub2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.

== boxme -p sub status ==
# submissions/10_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
# submissions/10_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
# submissions/1_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
# submissions/1_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
# submissions/1_user3/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
# submissions/2_user1/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
# submissions/2_user2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
# submissions/sub1/
[PASS] make. 
[PASS] test1. 
[FAIL] test2. diff -u tests/test2.res submissions/sub1//out/tests/test2.out

# submissions/sub2/
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C FILE
	 ^
	src/hello.c:1:7: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'FILE'
	 BAD C FILE
	       ^
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.

