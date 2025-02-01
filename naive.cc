#include <benchmark/benchmark.h>

float dot(float *a, float *b, size_t len) {
    #pragma clang fp reassociate(on)
    float sum = 0.0;
    for (size_t i = 0; i < len; ++i) {
        sum += a[i] * b[i];
    }
    return sum;
}

void BM_dot(benchmark::State& state) {
    constexpr size_t len = 100000;
    float a[len], b[len];
    for (auto _ : state) {
        benchmark::DoNotOptimize(dot(a, b, len));
    }
}

BENCHMARK(BM_dot);
BENCHMARK_MAIN();
