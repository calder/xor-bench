#include <benchmark/benchmark.h>

float dot(float *a, float *b, size_t len) {
    #pragma clang fp reassociate(on)
    float sum = 0.0;
    for (size_t i = 0; i < len; ++i) {
        sum += a[i] * b[i];
    }
    return sum;
}

void BM_dot_4k(benchmark::State& state) {
    alignas(32) float a[4000] = {};
    alignas(32) float b[4000] = {};
    for (auto _ : state) {
        benchmark::DoNotOptimize(dot(a, b, 4000));
    }
}

void BM_dot_8k(benchmark::State& state) {
    alignas(32) float a[8000] = {};
    alignas(32) float b[8000] = {};
    for (auto _ : state) {
        benchmark::DoNotOptimize(dot(a, b, 8000));
    }
}

void BM_dot_100k(benchmark::State& state) {
    alignas(32) float a[100000] = {};
    alignas(32) float b[100000] = {};
    for (auto _ : state) {
        benchmark::DoNotOptimize(dot(a, b, 100000));
    }
}

BENCHMARK(BM_dot_4k);
BENCHMARK(BM_dot_8k);
BENCHMARK(BM_dot_100k);
BENCHMARK_MAIN();
