#include <chrono>
#include <cstdio>
#include <type_traits>

using namespace std::literals::chrono_literals;

template<typename T> inline __attribute__((always_inline))
void black_box(T &&value) noexcept {
    if constexpr(std::is_pointer_v<T>) {
        asm volatile("":"+m"(value)::"memory");
    } else {
        asm volatile("":"+r"(value)::);
    }
}

float dot(float *a, float *b, size_t len) {
    #pragma clang fp reassociate(on)
    float sum = 0.0;
    for (size_t i = 0; i < len; ++i) {
        sum += a[i] * b[i];
    }
    return sum;
}

int main() {
    constexpr size_t SAMPLES = 10;
    constexpr size_t ITERS = 10000;
    constexpr size_t LEN = 100000;

    alignas(32) float a[LEN] = {};
    alignas(32) float b[LEN] = {};

    for (size_t s = 0; s < SAMPLES; ++s) {
        auto start = std::chrono::system_clock::now();
        for (size_t i = 0; i < ITERS; ++i) {
            black_box(dot(a, b, LEN));
        }
        float time_us = (std::chrono::system_clock::now() - start) / 1ns / 1e3 / ITERS;
        printf("%8.2f us\n", time_us);
    }
}
