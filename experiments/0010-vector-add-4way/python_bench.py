"""work 0010 — Python pure / NumPy 벤치 (vector add)"""
import time
import statistics
import sys

import numpy as np


def bench_pure(n: int, reps: int = 10, warmup: int = 3) -> int:
    a = [1.0 + (i % 1000) * 0.01 for i in range(n)]
    b = [2.0 + (i % 1000) * 0.01 for i in range(n)]
    c = [0.0] * n

    def go():
        for i in range(n):
            c[i] = a[i] + b[i]

    for _ in range(warmup):
        go()
    times = []
    for _ in range(reps):
        t0 = time.perf_counter_ns()
        go()
        t1 = time.perf_counter_ns()
        times.append(t1 - t0)
    return sorted(times)[len(times) // 2]


def bench_numpy(n: int, reps: int = 10, warmup: int = 3) -> int:
    a = (np.arange(n, dtype=np.float32) % 1000) * np.float32(0.01) + np.float32(1.0)
    b = (np.arange(n, dtype=np.float32) % 1000) * np.float32(0.01) + np.float32(2.0)
    c = np.zeros(n, dtype=np.float32)

    for _ in range(warmup):
        np.add(a, b, out=c)
    times = []
    for _ in range(reps):
        t0 = time.perf_counter_ns()
        np.add(a, b, out=c)
        t1 = time.perf_counter_ns()
        times.append(t1 - t0)
    return sorted(times)[len(times) // 2]


def main():
    SIZES = [1024, 65536, 1048576, 16777216]
    SIZES_PURE = [1024, 65536, 1048576]  # 16M은 너무 느려 생략

    print("=== Python pure ===")
    for n in SIZES_PURE:
        t = bench_pure(n)
        print(f"N={n:>10d}  median={t:>14d} ns  ns/elem={t/n:.2f}")

    print()
    print("=== NumPy (np.add out=c) ===")
    for n in SIZES:
        t = bench_numpy(n)
        bw = (3 * 4 * n) / (t + 1)  # 3 buffer × 4 byte/elem / time_ns ≈ GB/s
        print(f"N={n:>10d}  median={t:>14d} ns  ns/elem={t/n:.4f}  bw={bw:.1f} GB/s")


if __name__ == "__main__":
    main()
