---
id: 0012
title: Matmul 다구현 비교 — naive / SIMD / Mojo parallelize / NumPy BLAS
status: done
date: 2026-04-29
tags: [simd, performance, benchmark, matmul, parallelize, multi-thread]
related_code: experiments/0012-matmul-naive-vec-par/
---

# 0012. Matmul 다구현 비교 — naive / SIMD / Mojo parallelize / NumPy BLAS

## 1. 무엇을 하고자 하는지

T-13 정의: matmul C=A@B를 6 구현으로 비교 + Mojo `vectorize`/`parallelize` 효과 측정. 0009(vector add)는 memory-bound라 ops/byte = 1/12로 DRAM 천장(27 GB/s)에 막혔지만, **matmul은 ops/byte = N/8** (N=512에서 64) → compute-bound 영역. 진짜 SIMD/parallelize 효과가 보이는 첫 work.

`vectorize`는 0.26 시그니처 정복 어려워 *명시 SIMD*로 대체 (probe에서 `vectorize[W](closure, n)` 등 시도 모두 실패).

## 2. 수행한 일

알고리즘 (모두 naive triple loop 기반, 일부에 SIMD/parallelize 적용):

```
for i in range(M):
    for k in range(K):                  # k 외부, j 내부 (B 연속 접근)
        broadcast = A[i, k]
        for j in range(N) by W=16:
            C[i, j..j+W] += broadcast * B[k, j..j+W]
```

6 구현:
- (1) Python pure naive (N=128만)
- (2) NumPy `@` (BLAS — 멀티 스레드 + 캐시 블로킹)
- (3) C++ naive (`-O3` autovec)
- (4) C++ 명시 AVX-512 (FMA + outer i, k)
- (5) Mojo naive
- (6) Mojo 명시 SIMD16
- (7) Mojo SIMD16 + `parallelize[row](M)` — outer i 병렬

크기: 128, 256, 512, 1024 (Python pure는 128, Mojo naive는 256까지).

API 정복:
- `parallelize[task](n)` 동작 ✓ (probe 출력에서 task interleave 확인)
- `vectorize` 시그니처 추적 실패 — `[body, W](n)` / `[W](body, n)` / `[simd_width=W]` 모두 거부
- `UnsafePointer`를 함수 인자로 넘기면 mut 추론 실패 → **모두 인라인 + `@parameter fn` 안에서 캡처**로 우회

## 3. 예상되는 결과

- **Python pure**: O(N³) 트리플 루프 → 매우 느림. N=128에서 분 단위 가능.
- **Mojo naive ≈ C++ naive**: 둘 다 -O3 같은 LLVM 백엔드. 컴파일러 autovec 수준에 따라.
- **Mojo SIMD16 ≈ C++ AVX-512 explicit**: 0009/0010/0011에서 본 패턴, ~60 GFLOPS plateau.
- **Mojo parallelize**: 16 코어 × 단일 스레드 GFLOPS — 이론 ~960 GFLOPS, 실측은 메모리/캐시 제약으로 줄어듦.
- **NumPy BLAS**: 캐시 블로킹 + 멀티 스레드. 단순 SIMD+parallelize보다 빠를 것 (T-14 동기 부여).

## 4. 실제 결과

GFLOPS (높을수록 좋음):

| N | Python pure | NumPy BLAS | C++ naive(O3) | C++ AVX-512 | Mojo naive | Mojo SIMD16 | **Mojo SIMD+par** |
|---|--:|--:|--:|--:|--:|--:|--:|
| 128 | 0.107 | 358 | 6.35 | 36.5 | 4.25 | 51.1 | **315** |
| 256 | — | 829 | 3.44 | 53.7 | 3.36 | 61.6 | **265** |
| 512 | — | **1356** | 2.27 | 61.3 | (skip) | 78.3 | **437** |
| 1024 | — | 1189 | 0.78 | 62.5 | (skip) | 73.9 | **358** |

ns wall time (낮을수록 좋음) — N=512:

| 구현 | ns | 비율 vs NumPy |
|------|--:|--:|
| Python pure (N=128 only) | 39.3 ms (N=128) | — |
| C++ naive(O3) | 118 ms | 596× |
| Mojo SIMD16 | 3.43 ms | 17× |
| C++ AVX-512 | 4.38 ms | 22× |
| Mojo SIMD+par | 614 μs | **3.1×** |
| **NumPy BLAS** | **198 μs** | 1.0× (기준) |

### 4.1 핵심 관찰

1. **Mojo naive ≈ C++ naive (4 vs 6 GFLOPS @ N=128)** — 둘 다 -O3 LLVM autovec 적용 비슷. C++ 약간 우세.
2. **Mojo 명시 SIMD16 > C++ AVX-512 (78 vs 61 GFLOPS @ N=512)** — Mojo 1.27× 빠름! 코드는 동일 패턴이지만 LLVM 입장에서 Mojo의 명시 SIMD가 더 깨끗한 IR로 나와 최적화 기회 더 잡은 것으로 추정.
3. **Mojo parallelize: SIMD16 단일 thread × ~5-6× 가속** (N=512에서 78 → 437 GFLOPS, 5.6× = 16 코어 약 35% 효율). 메모리 대역폭 + 캐시 contention이 한계.
4. **NumPy BLAS 압도적** (N=512에서 1356 GFLOPS, Mojo+par의 3.1×). BLAS는 캐시 블로킹 + 명시 SIMD + 멀티 스레드 + register tiling 모두. 본 work이 다음 단계(T-14 = 0013) 동기.

## 5. 결론

### 5.1 SIMD vs parallelize 효과 (분리 측정)

| N | naive | × SIMD | × parallelize | 종합 |
|---|--:|--:|--:|--:|
| 128 | 4.25 | × 12 (51) | × 6.2 (315) | **× 74** |
| 256 | 3.36 | × 18 (62) | × 4.3 (265) | × 79 |
| 512 | — | (78) | × 5.6 (437) | (× 100+) |

→ **SIMD는 12-18×, parallelize는 그 위에 5-6× 추가**. 두 차원이 거의 곱해짐 (16 lanes × 16 cores theoretical = 256×, 실측 80~100×는 메모리/캐시 제약).

### 5.2 Mojo의 자리매김

```
Python naive ──── 1 GFLOPS 미만 (실용 불가)
C++ -O3 autovec ─ 1-7 GFLOPS (작은 N에서만 의미, 캐시 빠지면 추락)
Mojo/C++ 명시 SIMD ── 60-78 GFLOPS plateau (단일 thread compute 한계)
Mojo SIMD + parallelize ─ 250-437 GFLOPS (16 코어, 캐시 비효율)
NumPy BLAS / cuBLAS급 ─── 1000-1400+ GFLOPS (cache blocking 필수)
```

→ Mojo의 *단순 명시 SIMD + parallelize*는 **C++의 명시 AVX-512 + OpenMP**와 사실상 동등. NumPy/BLAS급은 *추가로 cache blocking* 필요 → T-14 (0013).

### 5.3 학습자 평가

- **Mojo `parallelize` 정복** — `parallelize[task](n)` 시그니처. 16 코어에서 5-6× 가속, OpenMP `#pragma omp parallel for`와 등가 표현력. C++ 진영의 OpenMP 보일러플레이트 없이 한 줄로.
- **Mojo `vectorize`는 다음 work으로 미룸** — 0.26 시그니처가 외부 문서와 모두 다름. 명시 SIMD가 결과적으로 더 명확한 코드(SIMD 폭 의도 명시)이므로 `vectorize` 정복은 우선순위 낮음.
- **NumPy BLAS 격차**가 분명히 보임 — 명시 SIMD + parallelize도 캐시 블로킹 안 한 코드는 N≥512에서 BLAS 대비 3× 손해. 0013(blocked matmul)이 그 격차 좁히기 동기.

### 5.4 후속 work 후보

- **(0013) Cache-friendly blocked matmul** — T-14. 본 work 다음 단계.
- **`vectorize` 시그니처 정복** (재시도) — 다음 cycle.
- **`fma` intrinsic** Mojo 표면 — 본 work에선 `va * vb + vc` 식으로 표현, FMA 명령 emit 여부는 ASM 미확인.
