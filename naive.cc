#include <chrono>
#include <cstdint>
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

void vxor(uint32_t *a, uint32_t *b, uint32_t *out, size_t len) {
    for (size_t i = 0; i < len; ++i) {
        out[i] = a[i] ^ b[i];
    }
}

int main() {
    constexpr size_t SAMPLES = 10;
    constexpr size_t ITERS = 10000;

    alignas(32) uint32_t a[4096] = {};
    alignas(32) uint32_t b[4096] = {};
    alignas(32) uint32_t c[4096] = {};

    for (size_t s = 0; s < SAMPLES; ++s) {
        auto start = std::chrono::system_clock::now();
        for (size_t i = 0; i < ITERS; ++i) {
            vxor(a, b, c, 4096);
        }
        float time_us = (std::chrono::system_clock::now() - start) / 1ns / 1e3 / ITERS;
        for (size_t i = 0; i < ITERS; ++i) {
            black_box(c[i]);
        }
        printf("%8.2f us\n", time_us);
    }
}
