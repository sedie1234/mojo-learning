// work 0011 — C++ AVX-512 horizontal sum reduction
#include <immintrin.h>
#include <chrono>
#include <vector>
#include <algorithm>
#include <cstdio>

using ns_t = long long;

static float sum_avx512(const float* a, int n) {
    __m512 acc = _mm512_setzero_ps();
    int i = 0;
    for (; i + 16 <= n; i += 16) {
        acc = _mm512_add_ps(acc, _mm512_loadu_ps(a + i));
    }
    float total = _mm512_reduce_add_ps(acc);   // horizontal reduce
    for (; i < n; ++i) total += a[i];
    return total;
}

template <typename F>
ns_t measure(F&& f) {
    using clk = std::chrono::high_resolution_clock;
    for (int w = 0; w < 3; ++w) f();
    std::vector<ns_t> ts;
    for (int r = 0; r < 10; ++r) {
        auto t0 = clk::now();
        volatile float s = f();   // sink
        (void)s;
        auto t1 = clk::now();
        ts.push_back(std::chrono::duration_cast<std::chrono::nanoseconds>(t1 - t0).count());
    }
    std::sort(ts.begin(), ts.end());
    return ts[ts.size() / 2];
}

int main() {
    const int sizes[] = {65536, 1048576, 16777216};
    printf("=== C++ AVX-512 sum reduction ===\n");
    for (int n : sizes) {
        std::vector<float> a(n);
        for (int i = 0; i < n; ++i) a[i] = 1.0f + (i % 1000) * 0.01f;
        ns_t t = measure([&]() { return sum_avx512(a.data(), n); });
        double bw = double(4LL * n) / double(t + 1);
        printf("N=%10d  median=%14lld ns  ns/elem=%.4f  bw=%.1f GB/s\n",
               n, t, double(t)/n, bw);
    }
    return 0;
}
