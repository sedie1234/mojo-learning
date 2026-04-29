// work 0012 — C++ matmul: naive scalar (-O3 autovec) + explicit AVX-512 inner

#include <immintrin.h>
#include <chrono>
#include <vector>
#include <algorithm>
#include <cstdio>
#include <cstdlib>

using ns_t = long long;

// Naive: 컴파일러 -O3 autovec에 맡김
static void matmul_naive(const float* a, const float* b, float* c, int M, int K, int N) {
    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            float s = 0;
            for (int k = 0; k < K; ++k) s += a[i*K + k] * b[k*N + j];
            c[i*N + j] = s;
        }
    }
}

// Explicit AVX-512: i, k 외부, j 내부 (B 연속 접근), 16 lanes 단위로 j 처리
// C[i,j..j+15] = sum_k A[i,k] * B[k,j..j+15]
static void matmul_avx512(const float* a, const float* b, float* c, int M, int K, int N) {
    for (int i = 0; i < M; ++i) {
        // 0으로 초기화
        for (int j = 0; j < N; ++j) c[i*N + j] = 0;
        for (int k = 0; k < K; ++k) {
            __m512 va = _mm512_set1_ps(a[i*K + k]);
            int j = 0;
            for (; j + 16 <= N; j += 16) {
                __m512 vb = _mm512_loadu_ps(b + k*N + j);
                __m512 vc = _mm512_loadu_ps(c + i*N + j);
                vc = _mm512_fmadd_ps(va, vb, vc);
                _mm512_storeu_ps(c + i*N + j, vc);
            }
            for (; j < N; ++j) c[i*N + j] += a[i*K + k] * b[k*N + j];
        }
    }
}

template <typename F>
ns_t measure(F&& f, int reps=10, int warmup=3) {
    using clk = std::chrono::high_resolution_clock;
    for (int w = 0; w < warmup; ++w) f();
    std::vector<ns_t> ts;
    for (int r = 0; r < reps; ++r) {
        auto t0 = clk::now(); f(); auto t1 = clk::now();
        ts.push_back(std::chrono::duration_cast<std::chrono::nanoseconds>(t1 - t0).count());
    }
    std::sort(ts.begin(), ts.end());
    return ts[ts.size() / 2];
}

int main() {
    const int sizes[] = {128, 256, 512, 1024};
    printf("=== C++ matmul ===\n");
    for (int n : sizes) {
        std::vector<float> a(n*n), b(n*n), c(n*n);
        for (int i = 0; i < n*n; ++i) { a[i] = 1.0f + i*0.001f; b[i] = 2.0f + i*0.001f; }

        ns_t t1 = measure([&]() { matmul_naive(a.data(), b.data(), c.data(), n, n, n); });
        ns_t t2 = measure([&]() { matmul_avx512(a.data(), b.data(), c.data(), n, n, n); });

        double flops = 2.0 * n * n * n;
        double g1 = flops / (t1 + 1);
        double g2 = flops / (t2 + 1);
        printf("N=%5d  naive(O3): %12lld ns (%6.2f GFLOPS)   avx512: %12lld ns (%6.2f GFLOPS)\n",
               n, t1, g1, t2, g2);
    }
    return 0;
}
