// MOJO-11 비교용: C++ vector add 벤치
// 컴파일: g++ -O3 -march=native -mavx512f 02_avx_bench.cpp -o 02_avx_bench

#include <immintrin.h>
#include <chrono>
#include <vector>
#include <algorithm>
#include <cstdio>
#include <cstdlib>

using ns_t = long long;

// (a) Scalar — 컴파일러 힌트로 vectorize 금지
__attribute__((optimize("no-tree-vectorize")))
void add_scalar(const float* a, const float* b, float* c, int n) {
    for (int i = 0; i < n; ++i) c[i] = a[i] + b[i];
}

// (b) Scalar — 컴파일러 자동 vectorize 허용
void add_autovec(const float* a, const float* b, float* c, int n) {
    for (int i = 0; i < n; ++i) c[i] = a[i] + b[i];
}

// (c) 명시 AVX-512
void add_avx512(const float* a, const float* b, float* c, int n) {
    int i = 0;
    for (; i + 16 <= n; i += 16) {
        __m512 va = _mm512_loadu_ps(a + i);
        __m512 vb = _mm512_loadu_ps(b + i);
        _mm512_storeu_ps(c + i, _mm512_add_ps(va, vb));
    }
    for (; i < n; ++i) c[i] = a[i] + b[i];
}

template<typename F>
ns_t measure(F&& f, const float* a, const float* b, float* c, int n) {
    using clk = std::chrono::high_resolution_clock;
    for (int w = 0; w < 3; ++w) f(a, b, c, n);
    std::vector<ns_t> ts;
    for (int r = 0; r < 10; ++r) {
        auto t0 = clk::now();
        f(a, b, c, n);
        auto t1 = clk::now();
        ts.push_back(std::chrono::duration_cast<std::chrono::nanoseconds>(t1 - t0).count());
    }
    std::sort(ts.begin(), ts.end());
    return ts[5];
}

int main() {
    int sizes[] = {1024, 65536, 1048576, 16777216};
    printf("=== MOJO-11 비교: C++ vector add ===\n");
    printf("N              scalar(no-vec)  scalar(O3)      AVX-512         scalar/avx  auto/avx\n");
    for (int n : sizes) {
        std::vector<float> a(n), b(n), c(n);
        for (int i = 0; i < n; ++i) { a[i] = 1.0f + (i % 1000) * 0.01f; b[i] = 2.0f + (i % 1000) * 0.01f; }

        auto t_s = measure(add_scalar, a.data(), b.data(), c.data(), n);
        auto t_v = measure(add_autovec, a.data(), b.data(), c.data(), n);
        auto t_x = measure(add_avx512, a.data(), b.data(), c.data(), n);

        printf("%-14d %-15lld %-15lld %-15lld %-12lld %-8lld\n",
               n, t_s, t_v, t_x, t_s / (t_x + 1), t_v / (t_x + 1));
        printf("    [avx512 bandwidth] %lld GB/s (effective)\n",
               (long long)(3LL * 4 * n) / (t_x + 1));
    }
    return 0;
}
