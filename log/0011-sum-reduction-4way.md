---
id: 0011
title: sum reduction 4-way — Python pure / NumPy / C++ AVX-512 / Mojo SIMD16
status: done
date: 2026-04-29
tags: [simd, performance, benchmark, reduction]
related_code: experiments/0011-sum-reduction-4way/
---

# 0011. sum reduction 4-way — Python pure / NumPy / C++ AVX-512 / Mojo SIMD16

## 1. 무엇을 하고자 하는지

T-12 원래 정의("같은 task=1e7 float32 sum을 4구현으로 측정")를 정확히 수행. 0008(XOR reduction, 3구현)/0010(elementwise add, 5구현)에서 빠진 *sum reduction × C++ 명시*를 채움. Mojo `SIMD.reduce_add()`와 C++ `_mm512_reduce_add_ps`의 horizontal reduction codegen 비교.

## 2. 수행한 일

3 소스 파일 (`python_bench.py`, `cpp_bench.cpp`, `mojo_bench.mojo`). 알고리즘은 동일:

```python/cpp/mojo
acc = 0     # SIMD acc 16 lanes for cpp/mojo
for chunk in array:
    acc += chunk
return horizontal_reduce(acc) + tail_scalar
```

크기: 64K / 1M / 16M (Python pure는 16M 생략).

## 3. 예상되는 결과

- Python pure: 단일 변수 누적 → vector add(0010)보다 빠를 것 (1 buffer만 읽음, scalar 누적 비용은 동일).
- NumPy: C-impl, native급.
- C++ AVX-512 horizontal reduce: vector accumulator + `vextractf*`/`vshufps` 트리 reduction 명령.
- Mojo SIMD16: `.reduce_add()`가 같은 패턴으로 컴파일될 것.

## 4. 실제 결과

| N | Python pure | NumPy | C++ AVX-512 | Mojo SIMD16 |
|---|--:|--:|--:|--:|
| 64K | 746,088 | 7,010 | 1,500 | **1,500** |
| 1M | 8,072,012 | 101,670 | 24,180 | **24,330** |
| 16M | (skip) | 2,090,153 | 1,413,145 | **1,382,755** |

(단위 ns)

ns/elem (1M):

| 구현 | ns/elem | vs C++ |
|------|--:|--:|
| Python pure | 7.70 | 333× |
| NumPy | 0.097 | 4.2× |
| **C++ AVX-512** | **0.023** | 1.0× (기준) |
| **Mojo SIMD16** | **0.023** | **1.005×** |

bandwidth (read 1 buffer × 4 byte/elem):
- 64K~1M (캐시 거주): ~175 GB/s — Mojo와 C++ 동일
- 16M (DRAM): ~48 GB/s — 단일 buffer라 0010(3 buffer 27 GB/s) 대비 더 높음

## 5. 결론

### 5.1 핵심 결과

- **Mojo SIMD16 sum = C++ AVX-512 sum (1.005× 차)** — `acc.reduce_add()`의 codegen이 C++ `_mm512_reduce_add_ps`와 사실상 동일. horizontal reduction 트리 명령(vextractf*, vshufps, vaddps) 패턴이 같음.
- **NumPy는 단일 buffer 처리에서도 native보다 4× 느림** — N=1M에서 NumPy 0.097 vs C++ 0.023. NumPy는 generic ndarray 처리 + boundary check.
- **Python pure 333×** — vector add(293×)보다 약간 큼. 단일 누적 변수라 store 자체는 적지만, PyObject 부동소수 연산 비용이 드러남.

### 5.2 0008 vs 0011 비교 (reduction 패턴)

|  | 0008 (XOR) | 0011 (sum) |
|---|---|---|
| 알고리즘 | XOR over 0..N-1 | sum over float32[N] |
| 입력 | 컴파일타임 range | 메모리 array |
| Mojo native ns/elem (10M/16M) | 0.18 | 0.084 |
| Python pure 비율 | 100× | 333× |

→ sum이 XOR보다 **2× 빠름** (0.084 vs 0.18 ns/elem). 이유: XOR loop는 데이터 의존성(매 iter total 갱신) 직렬화, sum SIMD acc는 16 lane이 *독립* 누적 → ILP/SIMD 효율 더 높음.

### 5.3 학습자 평가

- **horizontal reduce가 native** — Mojo `reduce_add()`가 컴파일러 intrinsic 수준으로 lowering됨. C++ 인라인 어셈블리 수준 표현력.
- **단일 buffer reduction에서 NumPy의 약점** — generic ndarray overhead 4× 차이가 보임. 큰 데이터에선 절대값 절반(numpy 2.1ms vs C++/Mojo 1.4ms @16M). 학습 메시지: NumPy는 *큰 데이터의 elementwise/matmul*에서 좋고, *작거나 단순한 reduction*은 native가 4×.

### 5.4 후속 work 후보

- **Mojo `Float32.sum()` 등 stdlib reduce가 따로 존재하는지** (`acc.reduce_add()`보다 ergonomic할 수 있음)
- **Tree reduction 정확도** — IEEE 754 add는 비결합. 16 lane 별도 누적 후 horizontal sum vs 직선 누적의 round-off 차이.
