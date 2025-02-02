.PHONY: naive-cc
naive-cc: naive.cc
	clang++ naive.cc -O3 -march=haswell -lbenchmark -o naive-cc.bin
	./naive-cc.bin

.PHONY: naive-rs
naive-rs: naive.rs
	rustc -C opt-level=3 -C target-feature=+avx2,+fma -o naive-rs.bin naive.rs
	./naive-rs.bin

.PHONY: functional-rs
functional-rs: functional.rs
	rustc -C opt-level=3 -C target-feature=+avx2,+fma -o functional-rs.bin functional.rs
	./functional-rs.bin
