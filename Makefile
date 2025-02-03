CC := clang++
RUSTC := rustc
RUSTC_NIGHTLY := ~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
RUSTC_PATCHED := ~/Source/rust/build/x86_64-unknown-linux-gnu/stage2/bin/rustc


.PHONY: gbench-cc
gbench-cc: gbench.cc
	$(CC) gbench.cc -O2 -march=haswell -lbenchmark

.PHONY: naive-cc
naive-cc: naive.cc
	$(CC) naive.cc -O2 -march=haswell

.PHONY: naive-rs
naive-rs: naive.rs
	$(RUSTC) -C opt-level=3 -C target-feature=+avx2,+fma -o a.out naive.rs

.PHONY: mul-add-rs
mul-add-rs: mul-add.rs
	$(RUSTC) -C opt-level=3 -C target-feature=+avx2,+fma -o a.out mul-add.rs

.PHONY: map-rs
map-rs: map.rs
	$(RUSTC) -C opt-level=3 -C target-feature=+avx2,+fma -o a.out map.rs

.PHONY: fold-rs
fold-rs: fold.rs
	$(RUSTC) -C opt-level=3 -C target-feature=+avx2,+fma -o a.out fold.rs

.PHONY: algebraic-rs
algebraic-rs: algebraic.rs
	$(RUSTC_NIGHTLY) -C opt-level=3 -C target-feature=+avx2,+fma -o a.out algebraic.rs

.PHONY: fast-rs
fast-rs: fast.rs
	$(RUSTC_NIGHTLY) -C opt-level=3 -C target-feature=+avx2,+fma -o a.out fast.rs

.PHONY: algebraic-stable-rs
algebraic-stable-rs: algebraic-stable.rs
	$(RUSTC_PATCHED) -C opt-level=3 -C target-feature=+avx2,+fma -o a.out algebraic-stable.rs

.PHONE: profile
profile:
	perf record ./a.out
	perf annotate
