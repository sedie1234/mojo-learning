"""work 0011 — sum reduction (Python pure / NumPy)"""
import time
import numpy as np


def bench_pure(n, reps=10, warmup=3):
    a = [1.0 + (i % 1000) * 0.01 for i in range(n)]
    def go():
        s = 0.0
        for x in a:
            s += x
        return s
    for _ in range(warmup): go()
    ts = []
    for _ in range(reps):
        t0 = time.perf_counter_ns(); go(); t1 = time.perf_counter_ns()
        ts.append(t1 - t0)
    return sorted(ts)[len(ts) // 2]


def bench_numpy(n, reps=10, warmup=3):
    a = (np.arange(n, dtype=np.float32) % 1000) * np.float32(0.01) + np.float32(1.0)
    for _ in range(warmup): a.sum()
    ts = []
    for _ in range(reps):
        t0 = time.perf_counter_ns(); a.sum(); t1 = time.perf_counter_ns()
        ts.append(t1 - t0)
    return sorted(ts)[len(ts) // 2]


SIZES = [65536, 1048576, 16777216]
SIZES_PURE = [65536, 1048576]   # 16M은 pure 너무 느림

print("=== Python pure ===")
for n in SIZES_PURE:
    t = bench_pure(n)
    print(f"N={n:>10d}  median={t:>14d} ns  ns/elem={t/n:.4f}")

print("\n=== NumPy a.sum() ===")
for n in SIZES:
    t = bench_numpy(n)
    bw = (4 * n) / (t + 1)   # read 1 buffer × 4 byte/elem
    print(f"N={n:>10d}  median={t:>14d} ns  ns/elem={t/n:.4f}  bw={bw:.1f} GB/s")
