#![feature(float_algebraic)]

use std::hint::black_box;
use std::time::SystemTime;

const LEN: usize = 100000;

fn dot(a: &[f32], b: &[f32]) -> f32 {
    assert_eq!(a.len(), b.len());

    let mut sum: f32 = 0.0;
    for i in 0..a.len() {
        sum = sum.add_algebraic(a[i].mul_algebraic(b[i]));
    }

    sum
}

#[repr(align(32))]
struct V([f32; LEN]);

fn main() {
    let a = V([0.0; LEN]);
    let b = V([0.0; LEN]);

    const SAMPLES: usize = 10;
    const ITERS: usize = 10000;
    for _ in 0..SAMPLES {
        let start = SystemTime::now();
        for _ in 0..ITERS {
            black_box(dot(&a.0, &b.0));
        }
        let time_us = 1e6 * start.elapsed().unwrap().as_secs_f32() / ITERS as f32;
        println!("{:8.2} us", time_us);
    }
}
