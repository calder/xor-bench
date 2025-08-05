use std::hint::black_box;
use std::ops::BitXorAssign;
use std::time::SystemTime;

use bitvec::prelude::*;

fn bitvec_xor(a: &BitSlice, b: &BitSlice) -> BitVec {
    assert_eq!(a.len(), b.len());
    let mut out = a.to_bitvec();
    out.bitxor_assign(b);

    out
}

fn main() {
    const SAMPLES: usize = 10;
    const ITERS: usize = 10000;
    const LEN: usize = 4096;

    let a = bitvec![0; LEN];
    let b = bitvec![0; LEN];

    for _ in 0..SAMPLES {
        let start = SystemTime::now();
        for _ in 0..ITERS {
            black_box(bitvec_xor(black_box(&a), black_box(&b)));
        }
        let time_us = 1e6 * start.elapsed().unwrap().as_secs_f32() / ITERS as f32;
        println!("bitvec: {:8.2} us", time_us);
    }
}
