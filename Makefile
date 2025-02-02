.PHONY: gbench-cc
gbench-cc: gbench.cc
	clang++ gbench.cc -O2 -march=haswell -lbenchmark

.PHONY: naive-cc
naive-cc: naive.cc
	clang++ naive.cc -O2 -march=haswell

.PHONY: naive-rs
naive-rs: naive.rs
	rustc -C opt-level=3 -C target-feature=+avx2,+fma -o a.out naive.rs

.PHONY: map-rs
map-rs: map.rs
	rustc -C opt-level=3 -C target-feature=+avx2,+fma -o a.out map.rs

.PHONY: fold-rs
fold-rs: fold.rs
	rustc -C opt-level=3 -C target-feature=+avx2,+fma -o a.out fold.rs

.PHONY: algebraic-rs
algebraic-rs: algebraic.rs
	~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc -C opt-level=3 -C target-feature=+avx2,+fma -o a.out algebraic.rs

.PHONY: fast-rs
fast-rs: fast.rs
	~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc -C opt-level=3 -C target-feature=+avx2,+fma -o a.out fast.rs

.PHONE: profile
profile:
	perf record ./a.out
	perf annotate
