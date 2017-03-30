all:
	mkdir -p bin
	nitc src/hello.nit --dir bin

check:
	-../boxme tests
	-for d in submissions/*; do ../boxme -s $d tests; done
