// work 0010 — C++ AVX-512 explicit vector add (vs Mojo JIT/AOT)

#include <immintrin.h>
#include <chrono>
#include <vector>
#include <algorithm>
#include <cstdio>

using ns_t = long long;

static void add_avx512(const float* a, const float* b, float* c, int n) {
    int i = 0;
    for (; i + 16 <= n; i += 16) {
        __m512 va = _mm512_loadu_ps(a + i);
        __m512 vb = _mm512_loadu_ps(b + i);
        _mm512_storeu_ps(c + i, _mm512_add_ps(va, vb));
    }
    for (; i < n; ++i) c[i] = a[i] + b[i];
}

template <typename F>
ns_t measure(F&& f) {
    using clk = std::chrono::high_resolution_clock;
    for (int w = 0; w < 3; ++w) f();
    std::vector<ns_t> ts;
    ts.reserve(10);
    for (int r = 0; r < 10; ++r) {
        auto t0 = clk::now();
        f();
        auto t1 = clk::now();
        ts.push_back(std::chrono::duration_cast<std::chrono::nanoseconds>(t1 - t0).count());
    }
    std::sort(ts.begin(), ts.end());
    return ts[ts.size() / 2];
}

int main() {
    const int sizes[] = {1024, 65536, 1048576, 16777216};
    printf("=== C++ AVX-512 explicit ===\n");
    for (int n : sizes) {
        std::vector<float> a(n), b(n), c(n);
        for (int i = 0; i < n; ++i) {
            a[i] = 1.0f + (i % 1000) * 0.01f;
            b[i] = 2.0f + (i % 1000) * 0.01f;
        }
        ns_t t = measure([&]() { add_avx512(a.data(), b.data(), c.data(), n); });
        double bw = double(3LL * 4 * n) / double(t + 1);
        printf("N=%10d  median=%14lld ns  ns/elem=%.4f  bw=%.1f GB/s\n", n, t, double(t)/n, bw);
    }
    return 0;
}
