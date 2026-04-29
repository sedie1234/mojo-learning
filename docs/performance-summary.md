# Mojo 성능 비교 요약

work 0008~0013에서 측정한 모든 성능 결과를 *표만으로* 한 곳에. 각 표는 한 줄 설명만.

---

## 1. Vector add (elementwise) — 0009/0010 (`c[i] = a[i] + b[i]`)

5 구현, inner loop median (10회), warmup 3.

| N | Python pure | NumPy | C++ AVX-512 | Mojo JIT | Mojo AOT |
|---|--:|--:|--:|--:|--:|
| 1K | 29,039 | 400 | 50 | 30 | 40 |
| 64K | 1,993,454 | 3,510 | 3,900 | 2,820 | 2,989 |
| 1M | 23,038,384 | 90,888 | 75,118 | 77,408 | 88,497 |
| 16M | (skip) | 7,328,331 | 7,361,441 | 7,797,398 | 7,641,262 |

(단위 ns)

### 1.1 ns/elem (1M 기준)

| 구현 | ns/elem | vs C++ |
|------|--:|--:|
| Python pure | 21.97 | 305× |
| NumPy | 0.087 | 1.21× |
| C++ AVX-512 | **0.072** | 1.0× |
| Mojo JIT | 0.074 | 1.03× |
| Mojo AOT | 0.084 | 1.17× |

> **결론**: Mojo JIT/AOT inner loop는 C++ AVX-512와 동등. JIT/AOT 차이는 wall time에만 (JIT 컴파일 ~280 ms).

### 1.2 효과적 메모리 대역폭 (3 buffer × 4 byte/elem / time)

| N | bw (Mojo SIMD16) |
|---|--:|
| 1K (L1) | 173 GB/s |
| 64K (L2) | 170 |
| 1M (L3) | 171 |
| 16M (DRAM) | **26** |

> L1~L3에서 ~170 GB/s plateau, DRAM 진입 시 6× 추락. 전형적 메모리 hierarchy.

### 1.3 End-to-end wall time (`time` 측정)

| 구현 | real (s) | maxRSS | 비고 |
|------|--:|--:|------|
| Python | 0.80 | 239 MB | NumPy multi-thread |
| C++ AOT | 0.15 | 200 MB | 빌드 별도 |
| **Mojo JIT** | 0.44 | 348 MB | **+280 ms 컴파일** |
| **Mojo AOT** | 0.16 | 232 MB | C++급 |

> Mojo JIT vs AOT inner loop는 동일, **wall에서만 280 ms 차이**.

---

## 2. Sum reduction — 0011 (`acc = sum(arr)`)

| N | Python pure | NumPy | C++ AVX-512 | Mojo SIMD16 |
|---|--:|--:|--:|--:|
| 64K | 746,088 | 7,010 | 1,500 | **1,500** |
| 1M | 8,072,012 | 101,670 | 24,180 | **24,330** |
| 16M | (skip) | 2,090,153 | 1,413,145 | **1,382,755** |

(단위 ns)

### 2.1 ns/elem (1M)

| 구현 | ns/elem | vs C++ |
|------|--:|--:|
| Python pure | 7.70 | 333× |
| NumPy | 0.097 | 4.2× |
| C++ AVX-512 | **0.023** | 1.0× |
| Mojo SIMD16 | **0.023** | 1.005× |

> Mojo `acc.reduce_add()` = C++ `_mm512_reduce_add_ps` (사실상 bit-identical).

### 2.2 reduction은 단일 buffer라 bandwidth 더 높음

| Domain | bw (Mojo) |
|--------|--:|
| 캐시 (~1M 이하) | ~175 GB/s |
| DRAM (16M) | 48 GB/s |

> vector add 0010 16M 26 GB/s vs sum 0011 16M 48 GB/s — buffer 1개라 거의 2×.

---

## 3. XOR reduction — 0008 (`acc ^= arr[i]`, fold 회피용)

| N | Mojo native | Python pure | NumPy | pure/native | numpy/native |
|---|--:|--:|--:|--:|--:|
| 1K | 280 | 28,639 | 2,580 | 101× | 9× |
| 100K | 25,070 | 1,907,420 | 29,620 | 76× | 1× |
| 10M | 1,811,060 | 192,280,367 | 15,031,292 | 106× | 8× |

(단위 ns)

> Python pure ↔ Mojo native = ~100×, NumPy ↔ Mojo native = 1~9×. 단순 sum은 컴파일러 fold 위험 → 측정 시 XOR or `mut sink` 패턴.

---

## 4. Naive matmul (compute-bound) — 0012 (`C = A @ B`)

GFLOPS (높을수록 좋음). N×N×N 정사각.

| N | Python pure | NumPy BLAS | C++ naive(O3) | C++ AVX-512 | Mojo naive | Mojo SIMD16 | Mojo SIMD+par |
|---|--:|--:|--:|--:|--:|--:|--:|
| 128 | 0.107 | 358 | 6.35 | 36.5 | 4.25 | 51.1 | **315** |
| 256 | — | 829 | 3.44 | 53.7 | 3.36 | 61.6 | 265 |
| 512 | — | **1,356** | 2.27 | 61.3 | (skip) | 78.3 | **437** |
| 1024 | — | 1,189 | 0.78 | 62.5 | (skip) | 73.9 | 358 |

### 4.1 SIMD vs parallelize 분리 효과 (Mojo, N=128 기준)

| 단계 | GFLOPS | 누적 가속 |
|------|--:|--:|
| naive | 4.25 | 1× |
| + 명시 SIMD16 | 51.1 | 12× |
| + parallelize (16 cores) | 315 | **74×** |
| (NumPy BLAS) | 358 | 84× |

> SIMD 12-18×, parallelize 그 위에 5-6× 추가. 두 차원이 곱해짐.

### 4.2 N=512에서의 자리매김

| 구현 | GFLOPS | 비율 vs NumPy |
|------|--:|--:|
| Mojo SIMD+par | 437 | 0.32× |
| C++ AVX-512 (단일 thread) | 61 | 0.045× |
| **NumPy MKL** | **1,356** | **1.0×** |

> 단순 SIMD+parallelize로 NumPy의 32%까지 도달. 나머지 격차는 cache blocking 부재.

---

## 5. Blocked matmul (cache tiling) — 0013

GFLOPS, N×N×N. block: BM=64 BK=64 BN=128 (~80 KB → L2).

| N | NumPy MKL | C++ blocked+OMP+AVX-512 | Mojo blocked+SIMD+par | Mojo/C++ |
|---|--:|--:|--:|--:|
| 512 | 1,426 | 207 | 171 | 0.83× |
| 1024 | 1,714 | 184 | **210** | **1.14×** |
| 2048 | 1,540 | 193 | **236** | **1.22×** |

> N≥1024에서 Mojo가 C++ blocked보다 14-22% 빠름 (LLVM IR 효율). NumPy MKL은 여전히 6-8× 우위 (register tiling 부재).

### 5.1 unblocked vs blocked 교차점

| N | Mojo SIMD+par unblocked (0012) | Mojo blocked (0013) | 변화 |
|---|--:|--:|------|
| 512 | 437 | 171 | -61% (작은 N은 unblocked 우세) |
| 1024 | 358 | 210 | -41% |
| 2048 | (~100 추정) | 236 | **+136% (큰 N은 blocked 우세)** |

> N이 L2 (~1MB) 초과하면 blocking 효과 발현. 작은 N은 blocking overhead가 이득 잡아먹음.

---

## 6. Python interop 비용 — 0006/0008 (Mojo↔Python boundary)

### 6.1 Lifecycle (cold vs warm import_module)

| 케이스 | 시간 |
|--------|--:|
| math 첫 호출 (cold) | 17~18 ms |
| math 재호출 (warm) | 310~640 ns |
| numpy 첫 호출 (cold) | 39~64 ms |
| numpy 재호출 (warm) | 1.8 μs |
| ratio cold/warm | **~25,000×** |

> `Py_Initialize`는 첫 import_module()에 lazy. 이후 sub-μs.

### 6.2 NumPy `np.array(list)` 변환 비용 vs N

| N | median ns | ns/elem |
|---|--:|--:|
| 10 | 810 | 81 |
| 100 | 2,640 | 26 |
| 1,000 | 22,090 | 22 |
| 10,000 | 215,138 | 21 |
| 100,000 | 1,625,260 | **16** |

> N-linear, asymptotic ~16-22 ns/elem (PyObject 마샬링 cost).

### 6.3 타입 변환 API (Mojo 0.26)

| 방향 | 구문 |
|------|------|
| Mojo Int → Python int | `builtins.int(mojo_int)` 또는 함수 인자 자동 |
| Python int → Mojo Int | **`Int(py=po)` (키워드 only)** |
| Float64 | `Float64(py=po)` |
| String | `String(py=po)` |
| Python list/dict | PyObject로 직접 사용 |
| Mojo List → Python | 수동 loop append |

> Python → Mojo는 키워드 only (타입 안전 의도). Mojo → Python은 자동.

### 6.4 Python 예외 (모두 Mojo `try/except`로 잡힘)

| Python 예외 | Mojo 잡힘 | 메시지 보존 |
|-------------|:--:|:--:|
| ZeroDivisionError | ✅ | ✅ |
| KeyError | ✅ | ✅ |
| ValueError | ✅ | ✅ |
| AttributeError | ✅ | ✅ |

---

## 7. 0.26 키워드 변경 ↔ 이전 버전 (0007)

| 이전 | 0.26 현재 |
|------|-----------|
| `inout p: T` | `mut p: T` |
| `owned p: T` | `var p: T` |
| `borrowed p: T` 또는 default | `read p: T` 또는 default |
| `let x = 10` | **제거** — `var x = 10`만 |
| `__copyinit__(out self, other:)` | `__copyinit__(out self, copy:)` |
| `var p2 = p1` 자동 copy | **`p1.copy()` 명시** 필요 (ImplicitlyCopyable 별도) |
| `def f(): raise` 묵시 raises | `def f() raises:` 명시 필수 |
| `Int(po)` Python→Mojo | `Int(py=po)` 키워드 only |

> 외부 문서(0.7~0.13 시기)와 모두 다름. probe-driven 학습 필수.

---

## 8. 수치 타입 (0007) — C++ stdint 매핑

| Mojo | C++ 등가 | 비고 |
|------|----------|------|
| `Int` | `ssize_t`/`intptr_t` | 플랫폼 의존, x86_64 64-bit |
| `Int8` ~ `Int64` | `int8_t` ~ `int64_t` | 고정폭 |
| `UInt8` ~ `UInt64` | `uint8_t` ~ `uint64_t` | 고정폭 |
| `Float16/32/64` | `_Float16`/`float`/`double` | IEEE 754 |
| Overflow | wrap (정의됨, signed/unsigned 모두) | C++23 이전 signed UB와 다름 |

> `Int8.MAX + 1 = -128` (정의된 wrap-around).

---

## 9. 소유권 모델 (0007) — Rust/C++ 매핑

| Mojo 0.26 | Rust | C++ | 의미 |
|-----------|------|-----|------|
| `read p: T` (default) | `&T` | `T const&` | immutable borrow |
| `mut p: T` | `&mut T` | `T&` | mutable borrow |
| `var p: T` | `T` (move) | `T&&` + `std::move` | consume |
| `x^` | (auto move) | `std::move(x)` | transfer 명시 |
| ImplicitlyCopyable 미준수 | not `Copy` | `= delete` | 자동 copy 차단 |

---

## 10. Trait (0008) — C++ concept 매핑

| Mojo | C++20 | Rust |
|------|-------|------|
| `trait T: fn m(self): ...` | `concept T = requires(...)` | `trait T { fn m(&self); }` |
| `struct X(T1, T2):` | requires 만족 | `impl T1 for X`, `impl T2 for X` |
| `fn f[T: Trait](x: T)` | `template<Trait T> void f(T)` | `fn f<T: Trait>(x: T)` |
| `fn f[T: A & B](x: T)` | `requires A<T> && B<T>` | `fn f<T: A + B>(x: T)` |
| `trait Pet(Animal):` | (없음) | `trait Pet: Animal` |
| dispatch | template instantiation | monomorphization | 모두 compile-time monomorphization |

---

## 11. 한 줄 종합

| 영역 | 한 줄 결론 |
|------|----------|
| 명시 SIMD | Mojo = C++ AVX-512 동등 ISA 명령 (vaddps zmm 검증) |
| Reduction | Mojo `reduce_add()` = C++ `_mm512_reduce_add_ps` |
| Vector add (memory-bound) | DRAM 천장 ~27 GB/s에서 모두 수렴 |
| Matmul (compute-bound) | Mojo SIMD+parallelize ≈ C++ AVX-512+OpenMP, NumPy MKL 6-8× 우세 |
| Python interop | pure 100-300×, C-impl(NumPy) ~1×. 핫스팟은 Mojo native로 재작성 |
| JIT vs AOT | inner loop 동일, wall에서 ~280 ms 컴파일 차이 |
| 0.26 API | 외부 문서와 키워드 대부분 다름 (mut/var/read/^/copy 등) |
