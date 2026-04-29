# Mojo 학습 TODO

> 이 파일은 **mojo-orchestrator** agent가 관리한다. 사용자도 자유롭게 추가/편집 가능.
> 새 아이디어는 **Backlog**에 쌓고, 다음에 할 것을 **Next**로 옮기고, 진행 중인 것을 **In Progress**로, 끝난 것은 **Done**으로 옮긴다.
> 각 항목 끝 `(→ NNNN)` 표기는 해당 work의 로그 번호 — 완료 시 채운다.

## In Progress

(없음)

## Next

(없음 — Language Fundamentals 5건 모두 0007에서 처리됨)

## Backlog

### 언어 기본
- [ ] **(NEW from 0003)** `mojo build --emit llvm|asm`으로 `fn main(){print("hi")}`의 IR과 어셈블리 dump. optimization level 0/1/2/3 비교. (issue 미등재 — orchestrator가 다음 cycle에 등재할 후보)
- [ ] **(NEW from 0003)** `mojo build --emit shared-lib`로 만든 `.so`를 C++에서 `dlopen`/직접 링크해 호출. Mojo↔C++ 상호운용 첫 시도. (issue 미등재)
- [ ] **(NEW from 0003)** venv에서 Mojo 컴파일러만(MAX/transformers 제외) 분리 설치 가능한지 검증. 2.0 GB → ?? (issue 미등재)
- [ ] **(NEW from 0003)** `libNVPTX` 등 GPU 백엔드가 항상 동봉되는 이유와 회피 가능성 — GPU 없는 환경에서 stripped variant 존재? (issue 미등재)
- [ ] **(NEW from 0005)** `.mojopkg` 내부 포맷 — magic "MPKG\\x01" 이후 무엇이 들어 있나, KGEN module인가 MLIR bytecode인가 (`--emit=llvm`과 cross-check)
- [ ] **(NEW from 0005)** `import compiler` (compiler.mojopkg) 시도 — Mojo에 reflection/introspection API가 있는가
- [ ] **(NEW from 0005)** 자작 패키지 lifecycle 실험 — `__init__.mojo` 디렉토리 → `mojo package` → 다른 파일에서 `-I`로 import
- [ ] **(NEW from 0005)** Python에서 `mojo.importer` 등록 후 `.mojo` 디렉토리 직접 import + SHA 캐시(`/tmp/.modular_<uid>/mojo_pkg/`) 동작 관찰
- [ ] **(NEW from 0007)** `sizeof`/`bitwidthof`/`alignof` 정식 노출 위치 — 0.26 외부 API 미노출, std.mojopkg dump로 확인
- [ ] **(NEW from 0007)** `class` 키워드 등장 여부 (Python superset 비전과 연결) — 로드맵 확인
- [ ] **(NEW from 0007)** Lifetime parameter 표면 — Rust 식 `'a` 어노테이션이 Mojo에 있는가? `ref` 키워드 함께
- [ ] **(NEW from 0007)** `__moveinit__` 호출 시점 추적 — `^` transfer 시 print 삽입으로 검증
- [ ] **(NEW from 0007)** Trait 시스템 깊이 (T-10 영역) — Copyable/ImplicitlyCopyable 분리에서 본 dispatch 모델
- [x] `struct` vs Python `class` (→ 0007, T-6)
- [x] 정수/부동소수 타입과 C++ stdint 비교 (→ 0007, T-7)
- [x] `var` vs `let` — let은 0.26에서 폐기 확인 (→ 0007, T-8)
- [x] 소유권/borrow checker — read/mut/var + ^ transfer (→ 0007, T-9)
- [x] Trait/parametric polymorphism — C++ template/concept과 비교 (→ 0008, T-10)
- [ ] **(NEW from 0008)** Mojo의 dynamic dispatch / trait object (`dyn Trait`이나 vtable 기반) 표면 검증
- [ ] **(NEW from 0008)** trait의 default method 가능 여부
- [ ] **(NEW from 0008)** Mojo native auto-vectorize 정도 — XOR 루프가 0.18 ns/elem로 SIMD 추정. `vectorize` 명시 vs 자동 적용 비교 → T-11과 자연스럽게 연결

### 성능/SIMD
- [x] `SIMD[DType.float32, N]` 벡터 add — C++ intrinsics(AVX2/AVX-512)와 어셈블리 비교. (→ 0009, T-11)
- [ ] **(NEW from 0009)** `vectorize` decorator 0.26 정확한 시그니처 확정 + autovec 결과 비교
- [ ] **(NEW from 0009)** `parallelize` 적용 — multi-core로 memory bandwidth × cores 끌어올리기
- [ ] **(NEW from 0009)** 메모리 정렬 강제 — 64-byte aligned alloc + `vmovaps` 사용 가능 여부
- [ ] **(NEW from 0009)** FMA — `a*b+c` 패턴이 단일 `vfmadd*ps`로 컴파일되는지
- [x] 단순 벡터 합 벤치: Python list / NumPy / C++ / Mojo 4종 비교 (→ 0011, T-12)
- [x] Naive matmul 4종 비교 + Mojo의 `vectorize`/`parallelize` 적용 효과 (→ 0012, T-13)
- [x] 캐시 친화적 matmul (블로킹) — Mojo에서 직접 (→ 0013, T-14)
- [ ] **(NEW from 0012/0013)** `vectorize` 시그니처 정복 — 0.26에서 [body, W](n) / [W](body, n) 모두 실패, 정확한 형태 추적
- [ ] **(NEW from 0013)** Register tiling matmul — MKL 격차(6-8×) 좁히기 위한 micro-kernel 8×8 또는 6×16 tile 설계
- [ ] **(NEW from 0013)** prefetch hint Mojo 표면 (`prefetcht0/t1/t2`)
- [ ] **(NEW from 0013)** MAX `linalg.matmul` 호출 — Mojo stack에 BLAS-class kernel 있는지 (직접 짜는 대신 활용)

### Python 상호운용
- [x] Mojo에서 NumPy 호출 — 객체 변환 비용 측정. (→ 0006, T-15)
- [x] Python 모듈을 import해서 쓰는 vs Mojo native 구현의 비용 차. (→ 0008, T-16, Python pure 100× / NumPy ~1×)
- [ ] **(NEW from 0006)** 예외 타입별 discriminate — Mojo에서 `except KeyError as e: ... except ValueError as e:` 식의 타입별 분기 가능한가
- [ ] **(NEW from 0006)** GIL 거동 — Mojo 멀티스레드에서 Python 호출 + `parallelize`와의 호환성
- [ ] **(NEW from 0006)** NumPy ndarray ↔ Mojo Tensor zero-copy 가능성 — buffer protocol 활용
- [ ] **(NEW from 0006)** `Python.evaluate("...")` 동적 코드 실행 표면 매핑 — 표현식 / 문장 / 함수 정의까지 가능한지

### MAX / AI
- [x] MAX 엔진 설치 및 모델 로드 — Qwen3-4B/Gemma4-E2B CPU 부정 결과 (→ 0014, T-17)
- [~] distilbert 추론 — **cancelled** (T-18)
- [x] `~/models/` 기존 모델 MAX 사용 가능성 — Qwen3/Gemma4 모두 차단 (→ 0014, T-19)
- [ ] **(NEW from 0014)** `max compile` / `max warm-cache` 양자화 워크플로우 — bfloat16 → float32/float8 변환 가능성
- [ ] **(NEW from 0014)** 호환 작은 모델 (`google/gemma-3-1b-it`) HF download → MAX CPU 추론 — path 검증 목적
- [ ] **(NEW from 0014)** Mojo `max.engine` Python API 직접 사용 — CLI보다 유연한 옵션
- [ ] **(NEW from 0014)** llama.cpp baseline — Qwen3-4B Q4_K_M GGUF 추론 token/s 측정 (MAX 미사용 비교군)

## Done

- 워크스페이스 셋업 (agents, skill, 디렉토리 구조) (→ 0001)
- Mojo 설치 (venv + `pip install modular`, 2.0 GB) + hello world AOT 검증 (→ 0003)
- Mojo 패키지/모듈 구조 추적 (실행 없이 fs 탐사) — Python wrapper→ELF 흐름, 25개 `.mojopkg` stdlib, prelude 컴파일러 내장, `__init__.mojo`, `importer.py` (→ 0005)
- Python interop 표면 + 비용 측정 — lifecycle(cold 17~39 ms / warm sub-μs), NumPy 변환 16~22 ns/elem, 타입변환 비대칭(Mojo→Py 자동, Py→Mojo `py=` 키워드 only), 예외 통합. (→ 0006)
- Language Fundamentals 5건 — fn/def(0.26부터 둘 다 raises 명시 필수), struct(value, .copy() 명시 필요), numeric types(C++ stdint 매핑, wrap overflow), var only(let 폐기), ownership(read/mut/var + `^`, Rust 모델 단순화). (→ 0007)
- Trait/parametric polymorphism + Python interop vs Mojo native cost — trait API(0.26: T: A & B, trait inheritance), Python pure ↔ Mojo native 100× 차, NumPy ↔ Mojo native 1~9×. (→ 0008)
- SIMD vector add — Mojo `(c+i).store(a.load[width=16](i)+b.load[width=16](i))` ↔ C++ AVX-512 동일 `vaddps %zmm` 명령(ASM 검증). 캐시 영역 1.2~1.5× 느림(런타임 오버헤드), DRAM 동률 26 GB/s. Default scalar는 elementwise pattern에서 autovec 안 됨. (→ 0009, T-11)
- vector add 4-way 비교 — Python pure 21.97 / NumPy 0.087 / C++ 0.072 / Mojo JIT 0.074 / Mojo AOT 0.084 ns/elem (1M 기준). JIT vs AOT inner loop 동일, wall에서 280ms 차 (JIT 컴파일). (→ 0010, T-25)
- sum reduction 4-way — Mojo SIMD16 acc.reduce_add() = C++ _mm512_reduce_add_ps (둘 다 0.023 ns/elem @ 1M). NumPy 4× 차, Python pure 333× 차. (→ 0011, T-12)
- matmul 7-way 비교 (naive/SIMD/parallelize/BLAS) — Mojo SIMD+par 437 GFLOPS @ N=512, NumPy MKL 1356 GFLOPS, single-thread C++ AVX-512 61 GFLOPS. parallelize 시그니처 정복(`parallelize[task](n)`), vectorize는 미정복. (→ 0012, T-13)
- blocked matmul cache tiling — N=2048에서 Mojo 236 / C++ 193 / MKL 1540 GFLOPS. blocked가 unblocked 추월하는 교차점 N≥1024. MKL 격차 6-8×는 register tiling 부재. (→ 0013, T-14)
- MAX CPU 적용 가능성 조사 — Qwen3-4B(bfloat16↔CPU 비호환) / Gemma4-E2B(architecture 미지원) 둘 다 MAX 0.26 CPU 사용 불가. 본 머신에선 llama.cpp+GGUF 권장. (→ 0014, T-17/T-19 closed; T-18 cancelled)

---

## TODO 작성 가이드

- **항목은 work으로 변환 가능한 단위**. 너무 크면 하위로 쪼갠다 ("Mojo 마스터" ❌, "`SIMD` 타입의 `__add__` 동작 확인" ✅).
- **결과를 보고 떠오른 아이디어는 즉시 Backlog에**. 잊지 않게.
- **우선순위 변경은 Next 섹션 순서로 표현**. 위에 있을수록 먼저.
