CC := clang++
RUSTC := rustc
RUSTC_NIGHTLY := ~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
RUSTC_PATCHED := ~/Source/rust/build/x86_64-unknown-linux-gnu/stage2/bin/rustc


.PHONY: naive-cc
naive-cc: naive.cc
	$(CC) naive.cc -O2 -march=haswell

.PHONY: naive-rs
naive-rs: naive.rs
	$(RUSTC) -C opt-level=3 -C target-feature=+avx2,+fma -o a.out naive.rs

.PHONE: profile
profile:
	perf record ./a.out
	perf annotate
