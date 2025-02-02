.PHONY: gbench-cc
gbench-cc: gbench.cc
	clang++ gbench.cc -O2 -march=haswell -lbenchmark

.PHONY: naive-cc
naive-cc: naive.cc
	clang++ naive.cc -O2 -march=haswell

.PHONY: naive-rs
naive-rs: naive.rs
	rustc -C opt-level=3 -C target-feature=+avx2,+fma -o a.out naive.rs

.PHONY: functional-rs
functional-rs: functional.rs
	rustc -C opt-level=3 -C target-feature=+avx2,+fma -o a.out functional.rs

.PHONE: profile
profile:
	perf record ./a.out
	perf annotate
