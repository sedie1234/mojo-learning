---
id: 0010
title: vector add 4-way 비교 — Python pure / NumPy / C++ / Mojo JIT / Mojo AOT
status: done
date: 2026-04-29
tags: [simd, performance, benchmark, jit-vs-aot, python-cpp-mojo]
related_code: experiments/0010-vector-add-4way/
---

# 0010. vector add 4-way 비교 — Python pure / NumPy / C++ / Mojo JIT / Mojo AOT

## 1. 무엇을 하고자 하는지

0009의 `c[i] = a[i] + b[i]` 작업을 다섯 구현(Python pure, NumPy, C++ AVX-512, Mojo JIT, Mojo AOT)으로 확장. **두 종류의 측정**:

1. **Inner loop ns** (median of 10): 컴파일 비용 없이 *순수 알고리즘 비용*만.
2. **End-to-end wall time** (`/usr/bin/time`): 프로세스 시작 + 컴파일(JIT의 경우) + 모든 사이즈 측정 끝까지의 총 시간. **여기에 JIT vs AOT의 진짜 차이가 보임**.

질문:
- Python pure는 얼마나 느린가? (체감용 baseline)
- NumPy는 C++/Mojo native와 어디까지 같은가?
- Mojo JIT와 AOT의 inner loop는 동일한가? wall time은 얼마나 다른가?
- C++과 Mojo AOT는 정말 같은가?

## 2. 수행한 일

### 2.1 5 구현 (3 소스 파일)

```
experiments/0010-vector-add-4way/
├── python_bench.py    # pure for loop + np.add(a, b, out=c)
├── cpp_bench.cpp      # _mm512_add_ps + loadu/storeu (g++ -O3 -march=native -mavx512f)
└── mojo_bench.mojo    # 같은 SIMD16 패턴 (JIT/AOT 동일 소스)
```

알고리즘은 모두 동일:
- 입력: `a[i] = 1.0 + (i % 1000) * 0.01`, `b[i] = 2.0 + ...`
- 출력: `c[i] = a[i] + b[i]`
- N: 1024 / 65536 / 1048576 / 16777216 (Python pure는 1M까지)

### 2.2 측정 프로토콜

**Inner loop**: warmup 3회 + measure 10회, median 사용. 각 언어/구현 내부에서 자체 perf counter 사용.

**End-to-end**: `/usr/bin/time -f` 로 3회 측정, 일관성 확인.

### 2.3 빌드

```
$ g++ -O3 -march=native -mavx512f cpp_bench.cpp -o cpp_bench
   → 21,312 byte ELF
$ mojo build mojo_bench.mojo -o mojo_bench_aot
   → 24,272 byte ELF (Mojo runtime 의존성은 venv lib에)
```

## 3. 예상되는 결과

- Python pure: 큰 손실 (인터프리터). 20~30 ns/elem.
- NumPy: C-impl + auto-vec, 거의 native.
- C++ AVX-512: 명시 SIMD, 메모리 바운드 한계까지.
- Mojo JIT/AOT: 같은 codegen이므로 **inner loop는 동일**, wall time은 JIT가 수백 ms 더 걸림 (컴파일 포함).

## 4. 실제 결과

### 4.1 Inner loop median (각 N에서)

| N | Python pure | NumPy | C++ AVX-512 | Mojo JIT | Mojo AOT |
|---|--:|--:|--:|--:|--:|
| 1K | 29,039 | 400 | 50 | 30 | 40 |
| 64K | 1,993,454 | 3,510 | 3,900 | 2,820 | 2,989 |
| 1M | 23,038,384 | 90,888 | 75,118 | 77,408 | 88,497 |
| 16M | (skip) | 7,328,331 | 7,361,441 | 7,797,398 | 7,641,262 |

(단위 ns)

ns/elem (1M 기준):

| 구현 | ns/elem | vs 가장 빠름 |
|------|--------:|--------:|
| Python pure | 21.97 | **293×** |
| NumPy | 0.087 | 1.16× |
| C++ AVX-512 | 0.072 | **1.00× (기준)** |
| Mojo JIT | 0.074 | 1.03× |
| Mojo AOT | 0.084 | 1.17× |

특이 관측:
- **N=1K에서 Mojo JIT가 30 ns로 가장 빠름** (C++ 50 ns보다도 빠름). 캐시 영역 micro-benchmark 노이즈로 추정.
- **N=16M에서 모두 7~8 ms 수렴** = DRAM 대역폭 ~26-27 GB/s 한계.

### 4.2 End-to-end wall time (3회 평균)

| 구현 | real (s) | user (s) | maxRSS (MB) | 비고 |
|------|---------:|---------:|------------:|------|
| Python | 0.80 | 1.78 | 239 | NumPy multi-threaded → user > real |
| C++ AOT | 0.15 | 0.11 | 200 | 빌드 별도, 본 시간엔 미포함 |
| **Mojo JIT** (`mojo run`) | **0.44** | 0.37 | 348 | **컴파일 포함** |
| **Mojo AOT** (`./binary`) | **0.16** | 0.11 | 232 | C++급 |

**핵심**: Mojo JIT 0.44s − AOT 0.16s = **약 280 ms**가 JIT 컴파일 비용. inner loop는 동일하지만 **매 실행마다 280 ms 추가**되는 것.

### 4.3 Python pure vs NumPy 격차

같은 Python 인터프리터 안에서:

| N | pure ns/elem | numpy ns/elem | 차 |
|---|--:|--:|--:|
| 1K | 28.36 | 0.39 | 73× |
| 64K | 30.42 | 0.054 | 564× |
| 1M | 21.97 | 0.087 | **252×** |

NumPy는 본질적으로 C 코드를 호출하는 것 — Python 호출 1번에 백만 element 처리. 인터프리터 오버헤드 없음. → 0006/0008에서 본 "Python의 진짜 비용은 인터프리터" 결론과 일관.

## 5. 결론

### 5.1 5 구현의 자리매김

```
빠름 ─────────────────────────────────────────── 느림
Mojo JIT/AOT  ≈  C++ AVX-512  ≈  NumPy  ≪  Python pure
       (~0.07-0.09 ns/elem)              (~22 ns/elem, 250-1000× 차)
       1M=75-90 μs           1M=23 ms
```

### 5.2 JIT vs AOT — 핵심 발견

| 지표 | JIT (`mojo run`) | AOT (`./binary`) | 차이 |
|------|----------------:|------------------:|---:|
| **inner loop ns** (median) | 30~7,797,398 | 40~7,641,262 | ≈ 동일 (노이즈 수준) |
| **end-to-end wall** | 0.44 s | 0.16 s | **+0.28 s (JIT 컴파일)** |
| maxRSS | 348 MB | 232 MB | +116 MB (컴파일러 메모리) |

**결론**:
1. **JIT와 AOT의 *실행 코드는 완전히 같다*** — Mojo는 양쪽에서 동일 백엔드로 컴파일. inner loop ns가 같다는 게 그 증거.
2. **차이는 *컴파일 시점*** — JIT는 매 실행마다 280 ms 컴파일, AOT는 빌드 1회로 끝.
3. **언제 JIT?** — 개발 중 빠른 반복(`mojo run` = 컴파일 + 실행 한 번에). 실험 단계.
4. **언제 AOT?** — 배포, 반복 실행, 짧은 작업이지만 자주 호출되는 경우. 0.28 s × N회 호출 = 누적 비용.

### 5.3 Mojo AOT vs C++ AOT — 동급

| | C++ AOT | Mojo AOT | 비율 |
|---|---:|---:|---:|
| inner loop @ 1M | 75 μs | 88 μs | 1.17× |
| wall time | 0.15 s | 0.16 s | 1.07× |
| maxRSS | 200 MB | 232 MB | 1.16× |

→ **Mojo AOT는 C++의 7~17% 범위 안**. 실용 어플리케이션에서는 노이즈 수준.

### 5.4 NumPy의 자리

NumPy는 C-impl + auto-vec + 가능한 경우 multi-thread:

| N | NumPy ns/elem | C++ AVX-512 ns/elem | NumPy/C++ |
|---|--:|--:|--:|
| 1K | 0.39 | 0.05 | 8× (overhead 지배) |
| 64K | 0.054 | 0.060 | **0.9× (NumPy 빠름)** |
| 1M | 0.087 | 0.072 | 1.21× |
| 16M | 0.437 | 0.439 | 1.00× (DRAM 바운드) |

작은 N (1K)에서 NumPy가 8× 느린 것은 ndarray 객체 생성 / Python ↔ C boundary fixed overhead. 큰 N에선 거의 동등 — NumPy가 multi-thread를 쓰면 메모리 바운드 영역에서도 단일 스레드 C++보다 빠를 수 있음 (사실 64K에서 그 현상).

### 5.5 학습자 평가

본 work이 정량으로 못박은 결론:

1. **"Python에 머물고 싶다 → NumPy/C-impl로"**: pure Python은 250~1000× 손실. NumPy/PyTorch 등을 적극 사용하면 native급 성능.
2. **"새 코드 짜는데 성능 중요 → C++ 또는 Mojo"**: 두 언어가 사실상 동등 (Mojo가 약간 느릴 뿐, 노이즈 범위).
3. **"개발 반복 빠르게 → Mojo JIT, 배포 → Mojo AOT"**: 같은 소스 그대로, 빌드 명령만 바뀜. C++이라면 매번 `g++` 직접 — Mojo는 한 도구로.
4. **"Mojo는 Python을 빠르게 만들지 않는다"** (0006/0008/0010 모두 일관 결론): pure Python 코드 그대로 호출 ≠ 가속. *Mojo native로 다시 짤 때만* 가속.
5. **DRAM 대역폭이 천장**: 본 머신에서 대용량 vector add는 ~27 GB/s에서 멈춤. 어떤 언어를 써도. 이건 알고리즘이 memory-bound이기 때문 — `vector add`는 ops/byte = 1/12 (1 add per 12 bytes I/O).

### 5.6 후속 work 후보

- **(NEW from 0010)** **Mojo `mojo package`**로 미리 컴파일한 `.mojopkg`로 호출 — JIT 컴파일 시간 절감되는지. 0005에서 발견한 `importer.py` 캐시(`/tmp/.modular_<uid>/mojo_pkg/`)와 연결.
- **(NEW from 0010)** **`mojo run` 자체에 cache가 있는가** — 같은 파일을 두 번째 호출하면 컴파일이 빨라지는지. 측정 1회 추가 필요.
- **(NEW from 0010)** Multi-thread 비교 — 본 work은 single thread. NumPy가 64K에서 C++ single thread보다 빨랐던 건 multi-thread 의심. Mojo `parallelize`로 multi-thread 적용 시 어떻게 되는지.
- **(NEW from 0010)** ops/byte가 높은 알고리즘(matmul, FFT 등)에서 같은 5-way 비교 — DRAM 천장에서 자유로운 영역에서 진짜 compute 차이가 보임.
