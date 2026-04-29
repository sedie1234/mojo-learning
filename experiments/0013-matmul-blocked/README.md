# 0013 — Cache-friendly blocked matmul (T-14)

블로킹(타일링) 적용 matmul:

| 파일 | 구현 |
|------|------|
| `cpp_bench.cpp` | C++ blocked + AVX-512 FMA + OpenMP (BM=64 BK=64 BN=128) |
| `mojo_bench.mojo` | Mojo blocked + SIMD16 + `parallelize` (동일 block 크기) |

NumPy(MKL)는 reference로 inline (`python3 -c`).

```bash
g++ -O3 -march=native -mavx512f -fopenmp cpp_bench.cpp -o cpp_bench
mojo build mojo_bench.mojo -o mojo_bench_aot
./cpp_bench && ./mojo_bench_aot
```

상세는 `../../log/0013-matmul-blocked.md`.
