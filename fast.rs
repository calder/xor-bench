#![allow(internal_features)]
#![feature(core_intrinsics)]

use std::hint::black_box;
use std::time::SystemTime;
use std::intrinsics::{fadd_fast, fmul_fast};

fn dot(a: &[f32], b: &[f32]) -> f32 {
    assert_eq!(a.len(), b.len());

    let mut sum = 0.0;
    unsafe {
        for i in 0..a.len() {
            sum = fadd_fast(sum, fmul_fast(a[i], b[i]));
        }
    }

    sum
}

fn main() {
    const SAMPLES: usize = 10;
    const ITERS: usize = 10000;
    const LEN: usize = 100000;

    let a = [0.0; LEN];
    let b = [0.0; LEN];

    for _ in 0..SAMPLES {
        let start = SystemTime::now();
        for _ in 0..ITERS {
            black_box(dot(black_box(&a), black_box(&b)));
        }
        let time_us = 1e6 * start.elapsed().unwrap().as_secs_f32() / ITERS as f32;
        println!("{:8.2} us", time_us);
    }
}
