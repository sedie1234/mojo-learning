# 0009 — SIMD vector add (Mojo vs C++ AVX-512)

work 0009 코드. T-11 — Mojo의 `SIMD[DType.float32, N]` 타입으로 vector add 작성, C++ AVX-512 intrinsics와 ASM/벤치 비교.

## 환경

- CPU: AVX-512 지원 (`avx avx2 avx512f avx512bw ...`)
- → **native float32 SIMD width = 16 lanes (512-bit)**

## 파일

| 파일 | 역할 |
|------|------|
| `01_simd_kernel.mojo` | Mojo 최소 SIMD add 커널 (add8 = 256-bit, add16 = 512-bit) |
| `01_avx_kernel.cpp` | C++ 동일 커널 (`_mm256_add_ps`, `_mm512_add_ps`) |
| `02_simd_bench.mojo` | Mojo 벡터 add 벤치 (scalar / 명시 SIMD16) |
| `02_avx_bench.cpp` | C++ 벤치 (no-vec scalar / -O3 autovec / 명시 AVX-512) |
| `*.s` | `--emit asm`/`g++ -S` 산출 |
| `results.log` | 실행 캡처 |

## 빌드/재현

```bash
cd /home/hwan/workspace/mojo
source .venv/bin/activate
cd experiments/0009-simd-vector-add

# 1. 최소 커널 (정합성)
mojo run 01_simd_kernel.mojo
g++ -O3 -march=native -mavx512f 01_avx_kernel.cpp -o 01_avx_kernel && ./01_avx_kernel

# 2. 벤치
mojo run 02_simd_bench.mojo
g++ -O3 -march=native -mavx512f 02_avx_bench.cpp -o 02_avx_bench && ./02_avx_bench

# 3. ASM dump (vaddps 직접 비교)
mojo build --emit asm 02_simd_bench.mojo -o 02_simd_bench.s
g++ -S -O3 -march=native -mavx512f 02_avx_bench.cpp -o 02_avx_bench.s
grep -c vaddps 02_simd_bench.s 02_avx_bench.s
```

## API drift 메모 (Mojo 0.26)

이번 work에서 부딪힌 API 변경:
- `simdwidthof[T]()` 외부 노출 안 됨 (사용 X)
- `vectorize` 시그니처 drift — 본 work에서는 제외 (autovec 비교는 C++만)
- `UnsafePointer[T]` → **`UnsafePointer[T, _]`** (origin 명시)
- `c.store(idx, val)` ✗ → **`(c + idx).store(val)`** (offset은 포인터 산술로)
- `init_pointee_copy` 는 *uninit* 메모리 전용. 이미 init된 List에는 **`c[i] = val`** 단순 subscript

자세한 결과/분석은 `../../log/0009-simd-vector-add.md`.
