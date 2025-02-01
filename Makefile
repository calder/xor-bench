.PHONY: naive
naive: naive.cc
	clang++ naive.cc -O3 -march=$(ARCH) -lbenchmark -o naive.bin
	./naive.bin
