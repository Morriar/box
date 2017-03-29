all:
	mkdir -p bin
	nitc src/hello.nit --dir bin

check:
	./boxme tests || true
	./boxme -s src2 -o out2 tests || true
	./boxme -s src3 -o out3 tests || true
