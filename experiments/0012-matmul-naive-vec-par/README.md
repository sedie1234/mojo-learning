# 0012 — Matmul naive / SIMD / parallelize (T-13)

C = A @ B (정사각, float32). 6 구현 비교:

| 파일 | 구현 |
|------|------|
| `python_bench.py` | pure naive (N=128) + NumPy `@` (BLAS) |
| `cpp_bench.cpp` | naive(`-O3` autovec) + 명시 AVX-512 |
| `mojo_bench.mojo` | naive + 명시 SIMD16 + SIMD16+`parallelize` |

```bash
g++ -O3 -march=native -mavx512f cpp_bench.cpp -o cpp_bench
mojo build mojo_bench.mojo -o mojo_bench_aot
python python_bench.py && ./cpp_bench && ./mojo_bench_aot
```

상세는 `../../log/0012-matmul-naive-vec-par.md`.
