// work 0013 — C++ blocked matmul + AVX-512 + OpenMP

#include <immintrin.h>
#include <chrono>
#include <vector>
#include <algorithm>
#include <cstdio>
#include <omp.h>

using ns_t = long long;

// Blocked + AVX-512 + OpenMP
template <int BM, int BK, int BN>
static void matmul_blocked(const float* a, const float* b, float* c, int M, int K, int N) {
    // C 0 초기화
    for (int i = 0; i < M*N; ++i) c[i] = 0.0f;

    #pragma omp parallel for collapse(2) schedule(static)
    for (int ii = 0; ii < M; ii += BM) {
        for (int jj = 0; jj < N; jj += BN) {
            for (int kk = 0; kk < K; kk += BK) {
                // 마이크로 커널: BM×BN 타일을 BK 만큼 누적
                int iend = std::min(ii + BM, M);
                int jend = std::min(jj + BN, N);
                int kend = std::min(kk + BK, K);
                for (int i = ii; i < iend; ++i) {
                    for (int k = kk; k < kend; ++k) {
                        __m512 va = _mm512_set1_ps(a[i*K + k]);
                        int j = jj;
                        for (; j + 16 <= jend; j += 16) {
                            __m512 vb = _mm512_loadu_ps(b + k*N + j);
                            __m512 vc = _mm512_loadu_ps(c + i*N + j);
                            vc = _mm512_fmadd_ps(va, vb, vc);
                            _mm512_storeu_ps(c + i*N + j, vc);
                        }
                        for (; j < jend; ++j) c[i*N + j] += a[i*K + k] * b[k*N + j];
                    }
                }
            }
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
    const int sizes[] = {512, 1024, 2048};
    printf("=== C++ blocked matmul (BM=64 BK=64 BN=128) + AVX-512 + OpenMP ===\n");
    printf("threads = %d\n", omp_get_max_threads());
    for (int n : sizes) {
        std::vector<float> a(n*n), b(n*n), c(n*n);
        for (int i = 0; i < n*n; ++i) { a[i] = 1.0f + i*0.001f; b[i] = 2.0f + i*0.001f; }
        ns_t t = measure([&]() { matmul_blocked<64, 64, 128>(a.data(), b.data(), c.data(), n, n, n); });
        double flops = 2.0 * n * n * n;
        double g = flops / (t + 1);
        printf("N=%5d  median=%14lld ns  GFLOPS=%6.2f\n", n, t, g);
    }
    return 0;
}
