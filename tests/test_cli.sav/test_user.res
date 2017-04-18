== make clean ==
rm -rf bin/ out/

== boxme user ==
user1
user2
user3

== boxme -p user ==
user1
user2
user3

== boxme user list ==
user1
user2
user3

== boxme -p user list ==
user1
user2
user3

== boxme user status ==
# user1: 10_user1
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# user2: 1_user2
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# user3: no approuval

== boxme -p user status ==
# user1: 10_user1
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# user2: 1_user2
[NOT RUN] make.
[NOT RUN] test1.
[NOT RUN] test2.
# user3: no approuval

== boxme user tests ==
# user1: 10_user1
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# user2: 1_user2
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# user3: no approuval

== boxme -p user tests ==
# user1: 10_user1
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# user2: 1_user2
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

# user3: no approuval

== boxme user list ==
user1
user2
user3

== boxme -p user list ==
user1
user2
user3

== boxme user status ==
# user1: 10_user1
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# user2: 1_user2
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
[NOT RUN] test3.
# user3: no approuval

== boxme -p user status ==
# user1: 10_user1
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
# user2: 1_user2
[FAIL] make. Test exited with 2
	src/hello.c:1:1: error: unknown type name 'BAD'
	 BAD C
	 ^
	src/hello.c:1:1: error: expected '=', ',', ';', 'asm' or '__attribute__' at end of input
	make: *** [all] Error 1

[NOT RUN] test1.
[NOT RUN] test2.
# user3: no approuval

