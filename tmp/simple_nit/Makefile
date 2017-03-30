all:
	mkdir -p bin
	nitc src/hello.nit --dir bin

runone:
	bin/hello `cat $(IN)`

check:
	-../boxme tests
	-for d in submissions/*; do ../boxme -s $$d tests; done
