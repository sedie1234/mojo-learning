# 0011 — sum reduction 4-way (T-12)

`sum(arr)` over float32 array. 4 구현 비교:

| 파일 | 구현 |
|------|------|
| `python_bench.py` | Python pure for-loop + `np.sum()` |
| `cpp_bench.cpp` | C++ AVX-512 + `_mm512_reduce_add_ps` |
| `mojo_bench.mojo` | Mojo SIMD16 acc + `.reduce_add()` |

```bash
g++ -O3 -march=native -mavx512f cpp_bench.cpp -o cpp_bench
mojo build mojo_bench.mojo -o mojo_bench_aot
python python_bench.py && ./cpp_bench && ./mojo_bench_aot
```

상세는 `../../log/0011-sum-reduction-4way.md`.
