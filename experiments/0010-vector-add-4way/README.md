# 0010 — vector add 4-way 비교

work 0010 코드. 같은 알고리즘(`c[i] = a[i] + b[i]`)을 다섯 구현으로:

| 파일 | 구현 |
|------|------|
| `python_bench.py` | Python 순수 루프 + NumPy (`np.add`) |
| `cpp_bench.cpp` | C++ AVX-512 explicit (`_mm512_add_ps`) |
| `mojo_bench.mojo` | Mojo SIMD16 (W=16, AVX-512) — JIT/AOT 동일 소스 |

## 빌드/재현

```bash
cd /home/hwan/workspace/mojo
source .venv/bin/activate
cd experiments/0010-vector-add-4way

# 빌드
g++ -O3 -march=native -mavx512f cpp_bench.cpp -o cpp_bench
mojo build mojo_bench.mojo -o mojo_bench_aot

# 실행 (inner loop 측정 — 각 구현이 직접 print)
python python_bench.py
./cpp_bench
mojo run mojo_bench.mojo          # JIT — 매 실행마다 컴파일
./mojo_bench_aot                  # AOT — 사전 컴파일된 binary

# end-to-end wall time
/usr/bin/time -v python python_bench.py
/usr/bin/time -v ./cpp_bench
/usr/bin/time -v mojo run mojo_bench.mojo
/usr/bin/time -v ./mojo_bench_aot
```

자세한 결과/분석은 `../../log/0010-vector-add-4way.md`.
