all:
	mkdir -p bin
	nitc src/hello.nit --dir bin

check:
	+../boxme tests
	+../boxme -s src2 -o out2 tests
	+../boxme -s src3 -o out3 tests
