"""work 0012 — Python pure / NumPy matmul"""
import time
import numpy as np


def bench_pure_naive(M, K, N, reps=3, warmup=1):
    a = [[1.0 + (i+j) * 0.001 for j in range(K)] for i in range(M)]
    b = [[2.0 + (i+j) * 0.001 for j in range(N)] for i in range(K)]
    c = [[0.0] * N for _ in range(M)]
    def go():
        for i in range(M):
            for j in range(N):
                s = 0.0
                for k in range(K):
                    s += a[i][k] * b[k][j]
                c[i][j] = s
    for _ in range(warmup): go()
    ts = []
    for _ in range(reps):
        t0 = time.perf_counter_ns(); go(); t1 = time.perf_counter_ns()
        ts.append(t1 - t0)
    return sorted(ts)[len(ts) // 2]


def bench_numpy(M, K, N, reps=10, warmup=3):
    a = np.random.rand(M, K).astype(np.float32)
    b = np.random.rand(K, N).astype(np.float32)
    for _ in range(warmup): _ = a @ b
    ts = []
    for _ in range(reps):
        t0 = time.perf_counter_ns(); _ = a @ b; t1 = time.perf_counter_ns()
        ts.append(t1 - t0)
    return sorted(ts)[len(ts) // 2]


# 정사각 matmul, 같은 N
SIZES_PURE = [128]                         # pure는 128^3 = 2M ops로 제한
SIZES = [128, 256, 512, 1024]

print("=== Python pure (naive triple loop) ===")
for n in SIZES_PURE:
    t = bench_pure_naive(n, n, n)
    flops = 2 * n**3
    gflops = flops / (t + 1)              # ns 분모이므로 결과는 GFLOPS
    print(f"N={n:>5d}  median={t:>14d} ns  GFLOPS={gflops:.3f}")

print("\n=== NumPy a @ b (typically uses BLAS, multi-thread) ===")
for n in SIZES:
    t = bench_numpy(n, n, n)
    flops = 2 * n**3
    gflops = flops / (t + 1)
    print(f"N={n:>5d}  median={t:>14d} ns  GFLOPS={gflops:.2f}")
