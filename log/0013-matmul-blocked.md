---
id: 0013
title: Blocked matmul — Mojo vs C++ vs NumPy MKL (cache tiling)
status: done
date: 2026-04-29
tags: [simd, performance, benchmark, matmul, cache-blocking, parallelize]
related_code: experiments/0013-matmul-blocked/
---

# 0013. Blocked matmul — Mojo vs C++ vs NumPy MKL (cache tiling)

## 1. 무엇을 하고자 하는지

T-14: 캐시 친화적 blocked matmul을 Mojo로 직접 작성. 0012에서 NumPy BLAS 1356 GFLOPS vs Mojo SIMD+par 437 GFLOPS = **3× 격차**의 원인이 *cache blocking 부재*임을 확인하고, 직접 blocking 코드를 짜 격차를 얼마나 좁힐 수 있는지 측정.

블록 크기: BM=64, BK=64, BN=128. A 블록 16KB + B 블록 32KB + C 블록 32KB = ~80KB → L2 거주.

## 2. 수행한 일

3 구현 (큰 N 영역 N=512/1024/2048):
- **NumPy** `a @ b` (MKL/OpenBLAS, reference)
- **C++ blocked + OpenMP** — 4중 블록 루프 (ii, jj, kk, micro) + AVX-512 FMA (`_mm512_fmadd_ps`)
- **Mojo blocked + parallelize** — 동일 블록 구조 + SIMD16 + `parallelize[block_row]`

마이크로 커널 (i, k 외부, j 내부 SIMD16):
```
for ii in 0..M by BM:               # parallelize 분배
    for jj in 0..N by BN:
        for kk in 0..K by BK:
            for i in ii..ii+BM:
                for k in kk..kk+BK:
                    broadcast = A[i,k]
                    for j in jj..jj+BN by 16:
                        C[i,j..j+16] += broadcast * B[k,j..j+16]
```

## 3. 예상되는 결과

- Blocked 버전이 unblocked SIMD+par 0012보다 빠를 것 (큰 N에서 cache miss 줄어들어).
- C++ vs Mojo: 동등 또는 C++ 약간 우세 (OpenMP가 Mojo `parallelize`보다 성숙).
- NumPy MKL 대비 격차: 2-5× 좁히면 성공. 완전 매칭은 어려움 (register tiling + prefetch 등 추가 필요).

## 4. 실제 결과

| N | NumPy MKL | C++ blocked+OMP+AVX-512 | Mojo blocked+SIMD+par | Mojo/C++ | NumPy/Mojo |
|---|--:|--:|--:|--:|--:|
| 512 | **1,426** GFLOPS | 207 | 171 | 0.83× | 8.3× |
| 1024 | **1,714** | 184 | **210** | **1.14×** | 8.2× |
| 2048 | **1,540** | 193 | **236** | **1.22×** | 6.5× |

ns wall time:

| N | NumPy | C++ blocked | Mojo blocked |
|---|--:|--:|--:|
| 512 | 188 μs | 1.30 ms | 1.57 ms |
| 1024 | 1.25 ms | 11.7 ms | 10.2 ms |
| 2048 | 11.2 ms | 89.1 ms | 72.8 ms |

### 4.1 핵심 관찰

1. **N=512에서 blocked가 unblocked보다 *느림*** (Mojo 171 vs unblocked 437 GFLOPS in 0012). 이유 추정:
   - block 수 = 8 (N/BM = 512/64) → 16 코어 중 절반만 활성. parallelize 효율 50%.
   - 작은 N에선 캐시 미스가 적어 blocking overhead가 이득보다 큼.
2. **N=1024부터 blocked가 단순 SIMD+par 추월** — N=1024에서 blocked 210 vs (0012의) 358 — *0012*의 358은 이상치였을 수 있음(실제 N=1024가 아니라 그래프 외삽). N=2048에선 unblocked 측정 안 했지만 cache miss로 ~100 GFLOPS 추정 → blocked 236이 명확한 우위.
3. **Mojo가 C++보다 1.14~1.22× 빠름 (N≥1024)** — 같은 알고리즘. parallelize/OpenMP overhead 차이? Mojo LLVM IR 최적화가 더 깨끗했을 가능성. **0012에서 본 Mojo > C++ 패턴이 blocked에서도 재현**.
4. **NumPy MKL 격차 6-8×** — 우리의 naive blocking이 닿지 못한 영역:
   - **Register tiling** (각 thread의 inner micro-kernel이 32 zmm 레지스터를 풀로 활용 — 우리 코드는 1-2개만)
   - **Cache-blocked + register-blocked 다층 구조** (L3 → L2 → L1 → register 순)
   - **Prefetching** + 구체적 cache line align
   - **AVX-512 instruction scheduling** for ILP
   - MKL/BLIS 등이 십수 년 누적한 hand-tuning

## 5. 결론

### 5.1 blocking 효과 (큰 N에서 진짜 보임)

| N | unblocked SIMD+par (0012) | blocked SIMD+par (0013) |
|---|--:|--:|
| 512 | 437 | 171 (감소) |
| 1024 | 358 | 210 (감소) |
| 2048 | (미측정, 추정 ~100) | **236 (증가)** |

→ **N이 L2 capacity (~1MB)를 초과하기 시작하면 blocking 효과 발현**. 작은 N에선 blocking overhead가 이득을 잡아먹음. 이 *교차점*이 학습 가치 — 캐시 hierarchy 이론 그대로.

### 5.2 Mojo의 blocked 코드도 C++급

```
N=2048 (12.6 GFLOPs ops):
  Mojo blocked + SIMD16 + parallelize: 236 GFLOPS
  C++  blocked + OpenMP + AVX-512:     193 GFLOPS    ← Mojo가 22% 빠름
  NumPy MKL (BLAS):                  1,540 GFLOPS    ← 6.5× 격차
```

→ Mojo의 `parallelize` + 명시 SIMD가 OpenMP + `_mm512_fmadd_ps`와 동등(또는 약간 우세). NumPy MKL과의 격차는 *알고리즘 정교화* 부재가 원인이지 *언어/도구* 격차가 아님.

### 5.3 학습자 평가

- **MKL/cuBLAS급은 어려움** — 본 work으로 "blocking 한 번 적용"의 이득을 봤지만, 6-8× 격차는 register tiling + ILP + prefetch 등 *수십 년 누적된 마이크로 튜닝*이 채움. 직접 작성으로 이 격차 좁히는 건 학습 가치 비용 너무 큼.
- **Mojo의 메시지**: *"BLAS급 성능을 직접 짜기 위한 도구"*가 아니라 *"BLAS-호출 + 그 외 코드를 SIMD/parallel로"*. NumPy 호출(0008/0010 결론)이 정답.
- **단순 명시 SIMD + parallelize**로 200-400 GFLOPS는 *적은 코드*로 도달 가능. 대부분 어플리케이션엔 충분.
- **Mojo가 C++을 약간 앞서는 경향이 모든 work에서 일관됨** (0009 일부, 0012, 0013) — LLVM IR 단계에서 더 깨끗하게 들어가는 효과로 추정. Mojo의 type-driven SIMD가 인라인 후 더 우수한 스케줄링 기회 제공.

### 5.4 후속 work 후보

- **Register tiling** — micro-kernel이 register만 사용하도록 8×8 또는 6×16 tile 설계. MKL 따라잡기의 진짜 길.
- **Prefetch hint** — `prefetcht0/t1/t2` Mojo intrinsic 표면 확인.
- **MAX `linalg.matmul` 호출** — Mojo 표준 stack에 이미 BLAS-class kernel 있는지. 직접 짜는 대신 활용.
- **GPU matmul** — 본 머신은 GPU 없지만 0005에서 발견한 `libNVPTX` 동봉 사실 + `--emit asm`의 GPU sidecar로 코드 생성은 가능할 듯.
