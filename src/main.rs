use std::hint::black_box;
use std::ops::BitXorAssign;
use std::time::SystemTime;

use bitvec::prelude::*;

fn bitvec_xor1(a: &BitSlice, b: &BitSlice) -> BitVec {
    assert_eq!(a.len(), b.len());
    let mut c = a.to_bitvec();
    c.bitxor_assign(b);
    c
}

fn bitvec_xor2(a: &BitSlice, b: &BitSlice, c: &mut BitSlice) {
    assert_eq!(a.len(), b.len());
    assert_eq!(a.len(), c.len());
    c.bitxor_assign(b);
}

fn bitvec_xor3(a: &BitSlice, b: &BitSlice, c: &mut BitSlice) {
    assert_eq!(a.len(), b.len());
    assert_eq!(a.len(), c.len());
    for i in 0..a.len() {
        c.set(i, a[i] ^ b[i]);
    }
}

fn main() {
    const SAMPLES: usize = 10;
    const ITERS: usize = 10000;
    const LEN: usize = 4096;

    let a = bitvec![0; LEN];
    let b = bitvec![0; LEN];
    let mut c = bitvec![0; LEN];

    println!("bitvec_xor1:");
    for _ in 0..SAMPLES {
        let start = SystemTime::now();
        for _ in 0..ITERS {
            black_box(bitvec_xor1(black_box(&a), black_box(&b)));
        }
        let time_us = 1e6 * start.elapsed().unwrap().as_secs_f32() / ITERS as f32;
        println!("{:8.2} us", time_us);
    }

    println!("bitvec_xor2:");
    for _ in 0..SAMPLES {
        let start = SystemTime::now();
        for _ in 0..ITERS {
            black_box(bitvec_xor2(black_box(&a), black_box(&b), black_box(&mut c)));
        }
        let time_us = 1e6 * start.elapsed().unwrap().as_secs_f32() / ITERS as f32;
        println!("{:8.2} us", time_us);
    }

    println!("bitvec_xor3:");
    for _ in 0..SAMPLES {
        let start = SystemTime::now();
        for _ in 0..ITERS {
            black_box(bitvec_xor3(black_box(&a), black_box(&b), black_box(&mut c)));
        }
        let time_us = 1e6 * start.elapsed().unwrap().as_secs_f32() / ITERS as f32;
        println!("{:8.2} us", time_us);
    }
}
