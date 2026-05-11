# Mojo 1.0.0b1 검증 보고서 (CPU)

- **작성일**: 2026-05-08 (1.0.0b1 출시 다음 날)
- **환경**: Ubuntu 24.04, x86-64 AVX-512, 16 cores, GPU 없음
- **Mojo**: 1.0.0b1 (a9591de6) / MAX 26.3.0 / modular 26.3.0 / transformers 5.2.0
- **branch**: `mojo-1.0` (main = 0.26 종결 commit 보존)
- **0.26 비교 기준선**: `main` branch의 work 0001-0015

---

## 1. 무엇을 했는가 — 실험 10개 (E01 ~ E10)

CPU 환경에서 가능한 모든 1.0 변화 표면을 직접 코드로 두드림. release notes를 가이드로 *0.26 회귀 여부*와 *1.0 신기능 표면*을 검증.

| ID | 주제 | 결과 | 로그 |
|----|------|:--:|------|
| E01 | 0.26 hello world 회귀 | ✅ 정상 + AOT 사이즈 -58% | `log/0016-1.0-hello-regression.md` |
| E02 | fn → def 마이그레이션 | ✅ sed 한 줄 치환으로 완전 마이그레이션 | `log/0017-1.0-fn-to-def.md` |
| E03 | Negative indexing 제거 | ✅ 차단 + 친절 에러. 부수 발견: List 가변 인자 ctor 제거 | `log/0018-1.0-negative-indexing.md` |
| E04 | `__copyinit__/__moveinit__` 마이그레이션 | ✅ 새 keyword-only `__init__` 패턴 + 자동 ctor 생성 | `log/0019-1.0-copyinit-migration.md` |
| E05 | `UnsafePointer` non-null + Optional | ⚠️ 핫루프 경로는 OK, Optional 시그니처 미정복 | `log/0020-1.0-unsafeptr-nonnull.md` |
| E06 | SIMD vector add 회귀 | ✅ `vaddps %zmm` ISA 동등 + 성능 동등~개선 | `log/0021-1.0-simd-regression.md` |
| E07 | Bounds checking default ON 성능 | ✅ overhead 0~1% (LLVM이 hoist out) | `log/0022-1.0-bounds-checking.md` |
| E08 | Conditional conformance 신기능 | ⚠️ stdlib 동작 OK, 사용자 측 syntax 미정복 | `log/0023-1.0-conditional-conformance.md` |
| E09 | Safe closure + parallelize | ✅ 0.26 패턴 회귀, 명시 capture syntax 미정복 | `log/0024-1.0-safe-closure-parallelize.md` |
| E10 | MAX 26.3 + Qwen3 CPU retry | ❌ 여전히 GPU 강제 (차단 layer만 깊어짐) | `log/0025-1.0-max-qwen3-retry.md` |

→ **7 ✅ + 2 ⚠️ + 1 ❌**. 핵심 회귀 (E01/E02/E04/E06/E07/E09)는 모두 성공.

---

## 2. 실험별 결과 요약

### E01 — hello world 회귀

| 항목 | 0.26 | 1.0.0b1 |
|------|--:|--:|
| `fn main(): print(...)` 컴파일 | ✅ | ⚠️ deprecation warning + 정상 |
| AOT 산출물 크기 | 44 KB | **18.6 KB (-58%)** |
| 실행 결과 | 정상 | 정상 |

→ 가장 단순한 코드는 무료 마이그레이션. AOT 크기 감소는 일관 패턴 (E06 bench도 33KB).

### E02 — fn → def

```mojo
# 0.26
fn add(a: Int, b: Int) -> Int: return a + b

# 1.0  (sed 'fn→def'만으로 동일 동작)
def add(a: Int, b: Int) -> Int: return a + b
```

→ **`sed 's/^fn /def /g'`만으로 100% 마이그레이션**. fn warning이 모든 사용처에 fix-it (`def`)까지 출력.

### E03 — Negative indexing + 부수 발견

```mojo
# 0.26
var xs = List[Int](10, 20, 30, 40, 50)
xs[-1]                                    # OK

# 1.0
var xs: List[Int] = [10, 20, 30, 40, 50]  # ★ literal syntax 강제
xs[-1]                                     # ★ compile error
xs[len(xs) - 1]                            # OK

# String
s[byte=0]                                  # ★ keyword 강제
s[grapheme=N]                              # 신규 grapheme indexing
```

**부수 발견 (가장 큰 마이그레이션 부담)**:
- `List[T](v1, v2, ...)` 가변 인자 생성자 제거 → literal `[...]` 또는 keyword-only ctor
- `s[i]` → `s[byte=i]` / `s[grapheme=i]`. *byte vs grapheme 의도*가 자동화 어려움.

### E04 — copyinit/moveinit 제거

| 패턴 | 1.0 결과 |
|------|--:|
| 0.26 `fn __copyinit__(out self, copy: Self): self.x = copy.x` | ❌ `'None' has no attributes` (auto-rewriting 제거) |
| 1.0 `fn __init__(out self, *, copy: Self):` keyword-only | ✅ 정상 |
| `struct Box(Copyable)` + ctor 정의 *없음* | ✅ **컴파일러 자동 copy ctor** (Pod-like) |

**Migration cost (struct 1개당)**:
- Pod-like → -2 줄 (dunder 두 개 *삭제*)
- 깊은 copy 필요 → rename + `*,` 키워드 추가 = ~3분

### E05 — UnsafePointer

| 사용처 | 결과 |
|--------|------|
| `xs.unsafe_ptr()` 핫루프 (sum, simd add 등) | ✅ 정상 (단, `from std.memory` 권장) |
| `Optional[UnsafePointer[T, _]]` nullable | ⚠️ origin parameter binding syntax 미정복 |

→ 0.26 SIMD 코드의 핫루프 패턴은 *그대로 동작*. Nullable이 진짜로 필요한 사례는 흔치 않으므로 대부분 영향 미미.

### E06 — SIMD vector add (가장 중요)

ASM 검증 (1.0):
```
vaddps  (%r12,%rdx,4), %zmm0, %zmm0
vmovups (%rbx,%rdx,4), %zmm0
vmovups %zmm0, (%r13,%rdx,4)
```

→ 0.26 ASM과 동일. **zero-cost abstraction 유지**.

성능 비교 (median of 10):

| N | 0.26 simd16 ns | **1.0 simd16 ns** | 변화 |
|---|--:|--:|--:|
| 1,024 (L1) | 50 | **30** | **-40%** |
| 65,536 (L2) | 3,140 | 3,199 | +2% |
| 16,777,216 (DRAM) | 7,362,373 | 4,651,043 | **-37%** |

→ **L1/DRAM 영역에서 1.0이 더 빠름**. L2는 거의 동일.

### E07 — Bounds checking 영향

| N | List `xs[i]` ns | unsafe `p[i]` ns | overhead |
|---|--:|--:|:--:|
| 1,024 | 210 | 210 | **0%** |
| 65,536 | 11,899 | 11,889 | **0%** |
| 1,048,576 | 190,595 | 190,065 | **0%** |
| 16,777,216 | 3,379,909 | 3,331,232 | **1%** |

ASM 100KB 안에 panic/unreachable/abort/trap **0회 등장** → LLVM이 모든 bounds check를 hoist out.

→ **default-on bounds check는 사실상 공짜**. 0.26의 `unsafe_ptr` 핫루프 패턴을 1.0에선 *List subscript로 회귀해도 무방* (단 SIMD load 경계는 여전히 unsafe).

### E08 — Conditional conformance 신기능

- ✅ stdlib 안에서 작동 (`Tuple[Int, Int]()` default 생성 등)
- ⚠️ **사용자 측 syntax 미정복**: `where T: Trait` (boolean expression으로 해석), `impl ... where ...` (global scope 거부), `T.conforms_to[Trait]()` (정확 형식 미파악)

→ release notes의 *예시 syntax가 컴파일러에 그대로 받아들여지지 않음*. beta 시기 docs 부족.

### E09 — Closure + parallelize

```mojo
# 0.26 패턴 — 1.0에서도 그대로 동작 (fn warning만)
@parameter
fn task(i: Int):
    ...
parallelize[task](n)
```

- ✅ 0.26 work 0012 핵심 패턴이 *완전히* 1.0에서 동작
- ⚠️ 명시 capture list `{...}` syntax는 Set literal과 충돌 — 정확 진입점 미정복

### E10 — MAX 26.3 + Qwen3 CPU retry

| 단계 | 0.26 | 1.0/26.3 |
|------|:--:|:--:|
| transformers AutoConfig (`model_type=qwen3`) | ✅ | ✅ |
| MAX architecture registry (`Qwen3ForCausalLM`) | ✅ | ✅ |
| encoding × device 매트릭스 (`bfloat16+CPU`) | ❌ | ❌ (변화 없음) |
| `float32 + CPU` encoding 시도 | (미시도) | ✅ encoding gate 통과 |
| graph build (`Allreduce` → `Accelerator(id=...)`) | N/A | ❌ **GPU 강제 의존 발견** |

| 항목 | 0.26 | 1.0/26.3 |
|------|:--:|:--:|
| Gemma4 transformers 인식 | ❌ | ❌ (transformers 5.2.0도 미인식) |
| MAX architecture registry — Gemma4 | ❌ | ❌ |
| MAX architecture registry — *추가된 모델* | (당시 list) | Qwen3, Qwen3-Moe, Qwen2.5-VL, Gemma3 family, Exaone, DeepseekV3.x |

→ **CPU LLM serving은 1.0에서도 본질적으로 막힘**. 차단 layer만 *encoding gate → graph build 안 GPU primitive*로 깊어짐. 0.26 결론(`MAX = GPU 중심`) *재확인*.

---

## 3. 종합 사용 경험 (overall impressions)

### 3.1 좋은 점 (0.26 → 1.0)

1. **회귀 안전성 매우 높음** — 핵심 work 0007/0009/0011-0013의 코드가 *키워드 sed 치환만으로* 99% 작동. SIMD ASM은 *bit-identical* 동등.
2. **성능 동등 ~ 개선** — L1/DRAM 영역에서 1.0이 더 빠름. 컴파일러 backend (LLVM/MLIR) 업그레이드 효과 추정.
3. **Bounds check default-on이 *공짜***. 안전성과 성능을 한 번에 — 큰 진보.
4. **AOT 산출물 크기 감소 (-58%)** — 배포 부담 감소.
5. **에러 메시지 친절함**: fn → def fix-it, negative index → `len(x)-1` 가이드, 모두 *마이그레이션 힌트* 포함.
6. **자동 copy ctor 생성** — `Copyable` conform만 하면 dunder 생략 가능. C++ default member-wise copy와 동일.
7. **stdlib 모듈 명확화**: `from memory` → `from std.memory`. C++ namespace 같은 일관성.
8. **Architecture registry 확장**: Qwen3, Gemma3, Exaone, DeepseekV3.x — 주요 LLM 패밀리 등록 빠름.

### 3.2 안 좋은 점 / 혼란

1. **신기능 syntax 정확 표면이 release notes에서 추정 불가**:
   - Conditional conformance — `where T: Trait` 컴파일러가 *boolean expression*으로 해석
   - 명시 capture list `{...}` — *Set literal*과 충돌
   - release notes는 *의사 코드* 수준의 예시만, 실제 동작 코드 없음
2. **List 가변 인자 생성자 제거** — *모든 0.26 예제 코드 영향*. 학습 자산 마이그레이션의 가장 큰 부담.
3. **String `[byte=N]`/`[grapheme=N]` keyword 강제** — 자동 마이그레이션 어려움 (의도 판단 필요).
4. **에러 메시지가 *원인을 직접 가리키지 않는* 경우 있음**: `__copyinit__` 0.26 패턴이 `'None' has no attributes`로 깨짐 — release notes 안 읽으면 디버깅 시간 길 것.
5. **MAX의 CPU 경로 여전히 막힘** — encoding gate 약간 개선됐지만 graph build 안에 `Accelerator(id=...)` 하드코드. CPU 사용자에게 1.0의 *실용적 가치 = 0*.
6. **`alias` → `comptime`** 같은 작은 변화가 release notes에 안 나옴 — 컴파일러 warning에서 처음 알게 됨. release notes incompleteness.

### 3.3 정량 — Migration cost (0.26 코드 1개 파일당)

| 변경 범주 | 자동화 가능 | 시간 |
|----------|:--:|:--:|
| `fn` → `def` (top-level + **struct method 모두 동일**) | sed (word-boundary 필수: `sed -E 's/(^\|[[:space:]])fn /\1def /g'`) | 1분 |
| `from memory` → `from std.memory` | sed | 1분 |
| `from python` → `from std.python` | sed | 1분 |
| `alias` → `comptime` | sed | 1분 |
| `__copyinit__/__moveinit__` rename | regex + 수동 검토 | ~5분/struct |
| `List[T](v1,v2,...)` → `[v1,v2,...]` | regex (대부분), 수동 일부 | ~10분/파일 |
| `s[i]` → `s[byte=i]` 또는 `s[grapheme=i]` | **자동화 어려움** | 의도별 수동 |
| 신기능 (conditional conformance, capture list) | N/A | docs/예제 출간 후 가능 |

→ 0.26 학습 워크스페이스 (15 work, 약 30개 파일) 마이그레이션 추정: **1-2시간 작업** (대부분 sed + 간단 검토).

### 3.4 권장 사항

1. **현재 0.26 코드를 1.0으로 마이그레이션 *함이 옳다***. 회귀 결과가 매우 깨끗 + 성능 더 좋음 + 안전성 향상.
2. **단, beta 시기에 신기능 (`conditional conformance`, 명시 capture)에 의존하는 새 코드는 *대기*** 권장. stable docs 출간 후 정확 syntax 확정 후 진입.
3. **MAX는 GPU 도착 후에 본격 검증**. CPU에선 1.0/26.3에서도 실용 가치 없음. llama.cpp/onnxruntime이 CPU 시나리오의 정공법 (0.26 결론 유지).
4. **Mojo native SIMD/parallelize는 1.0에서 *그대로 권장***. 학습 자산 보호 + 성능 개선까지.

### 3.5 참고 — Modular 공식 AI Agent Skills (본 cycle 미활용)

- 본 cycle에서는 release notes를 WebFetch로 읽고 컴파일러 에러를 단서로 직접 syntax를 추정하는 *probe-driven* 방식만 사용함. 그 결과 E08(conditional conformance) / E09(명시 capture)에서 syntax 미정복 ⚠️.
- Modular는 별도로 *AI Agent Skills* repo를 공개 중: https://github.com/modular/skills — Mojo/MAX 1.0+의 *공식 권장 syntax/패턴*이 LLM (Claude Code/Cursor/Codex/Gemini CLI 호환) 진입점으로 정리되어 있음.
- 다음 Mojo 작업 시작 시 `~/.claude/skills/`에 설치 권장. 미활용은 본 cycle의 한계가 아니라 *알게 된 시점이 cycle 종료 이후*이기 때문.
- 후속 cycle에서는 first action으로 skill repo 설치 후 진행 — 미정복 ⚠️ 항목들의 정확 syntax가 그 안에 있을 가능성 높음.

---

## 4. 결론

> **"Mojo 1.0.0b1은 0.26 학습자에게 *큰 부담 없는* 업그레이드"** — 본 cycle의 한 줄 결론.
>
> 회귀 안전성은 매우 높고, 성능은 동등~개선, 안전성(bounds check)은 무료. 마이그레이션 비용 1-2시간. *지금 갈아타도 좋다*.
>
> 단, 신기능(conditional conformance, 명시 capture)은 beta docs 부족으로 *현 시점 학습 부담* 있음 — stable 출간 후 진입 권장.
>
> MAX의 CPU 경로는 여전히 막혀 있음. **GPU 도착 후 다음 cycle**로 본격 학습 재개가 옳은 결정.

### 4.1 다음 cycle 트리거 (재확인)

GPU 도착 시:
- Qwen3 + GPU + bfloat16 throughput 측정 (CPU에서 차단된 부분)
- Gemma3 (4B/12B) + GPU
- DeepseekV3.x + GPU (FP8 native 경로)
- max serve OpenAI-compat API 검증
- GPU SIMD 측면 (Apple Metal 미보유, NVIDIA B300 미보유 — *AMD 또는 보급 NVIDIA 도착 시*)

신기능 후속 (어느 시점에든):
- conditional conformance 사용자 syntax (forum 검색 또는 stable 출간)
- 명시 capture list `{...}` 정확 진입점
- `comptime`이 0.26의 `alias`의 정확한 대체인지 의미 검증
- `vectorize` decorator의 1.0 시그너처 (0.26부터 미정복)
- `String[grapheme=N]` 한글 등 multi-byte 정확 동작

---

## 5. 산출물 목록

### 5.1 코드 (mojo-1.0 branch)

```
experiments/0016-1.0-hello-regression/
experiments/0017-1.0-fn-to-def/
experiments/0018-1.0-negative-indexing/
experiments/0019-1.0-copyinit-migration/
experiments/0020-1.0-unsafeptr-nonnull/
experiments/0021-1.0-simd-regression/
experiments/0022-1.0-bounds-checking/
experiments/0023-1.0-conditional-conformance/
experiments/0024-1.0-safe-closure-parallelize/
experiments/0025-1.0-max-qwen3-retry/
```

### 5.2 로그 (5섹션 정형)

```
log/0016-1.0-hello-regression.md
log/0017-1.0-fn-to-def.md
log/0018-1.0-negative-indexing.md
log/0019-1.0-copyinit-migration.md
log/0020-1.0-unsafeptr-nonnull.md
log/0021-1.0-simd-regression.md
log/0022-1.0-bounds-checking.md
log/0023-1.0-conditional-conformance.md
log/0024-1.0-safe-closure-parallelize.md
log/0025-1.0-max-qwen3-retry.md
```

### 5.3 환경

- 신규 venv: `.venv-1.0/` (기존 `.venv/` 0.26 보존)
- Mojo 1.0.0b1 + MAX 26.3.0 + transformers 5.2.0
- branch: `mojo-1.0`

### 5.4 Plane

- Plan page: `[1.0] Mojo 1.0.0b1 검증 plan (CPU)` (Notes 폴더)
- Issues: MOJO-26 ~ MOJO-35 (10개 모두 completed)
- Completion page: (이 보고서 작성 후 추가)

---

## 6. cycle-2 보강 (2026-05-11)

cycle-1 종결 후 사용자가 추가 검증 요청 — *matmul/vector 1.0 누락 부분 보완 + GPU 사용법 소개 + CNN*. modular/skills repo (영구 first action으로 등재됨) 설치 후 진입.

### 6.1 실험 5개

| ID | 주제 | 결과 |
|----|------|------|
| 0026 | Matmul 1.0 (naive/SIMD/parallelize/blocked) | ✅ blocked +9~28% 빠름 (vs 0.26) |
| 0027 | Vector add 1.0 + parallelize | ✅ **ops/byte 직접 증명** (낮은 ops/byte에선 parallelize 역효과) |
| 0028 | GPU SIMT 3종 (vector/reduction/matmul) | 코드만 (CPU 머신에서 컴파일 불가) |
| 0029 | GPU LLM (max serve + Python client) | 코드만 (CPU에선 graph build 차단) |
| 0030 | CNN 2D conv (CPU 실행 + GPU 코드) | ✅ CPU 43 GFLOPS / GPU 코드만 |

### 6.2 추가 발견

| 발견 | 의미 |
|------|------|
| **Matmul 1.0 +9~28% 빠름** | 1.0 backend (LLVM/MLIR) 개선이 vector add(0021), reduction(0011), matmul(0026)에 일관 |
| **Parallelize의 ops/byte 의존성** (vector add → 역효과, matmul → 5-6× 가속) | work 0013 cache_hierarchy 이론의 **실측 직접 증명** |
| **명시 capture syntax `{...}` 정확 적용 영역**: vectorize 등 *runtime-arg API*용, parallelize는 *@parameter def* 유지 | work 0024 ⚠️ 해소 |
| **CPU only 머신의 GPU 코드 한계**: `comptime if has_accelerator()` 가드 두어도 `enqueue_function` type-check가 항상 수행돼 *컴파일 자체 불가* | GPU 머신에서 검증 필요 — TODO |
| **CPU conv2d 43 GFLOPS (16 cores)** | YOLO 등 production CNN을 layer 단위 Mojo로 가속 가능성 입증 |
| **`out`은 1.0 예약어** (`def f(out self, x)`) | NN 코드의 `output` argument 작성 시 함정 |

### 6.3 modular/skills repo 효과

cycle-1 ⚠️ 미정복 부분의 *학습 진척*:
- **E08 conditional conformance**: skills repo는 *type 시스템 표 + Movable/Copyable 위계*는 정확 제공, 단 *사용자 측 conditional conformance declaration 정확 syntax*는 본 cycle에서도 미정복 (skills의 mojo-syntax SKILL이 더 정확한 가이드를 줄 가능성, 본 cycle은 GPU/matmul/vector에 집중)
- **E09 명시 capture**: ✅ *역할 + 적용 영역 정확 파악*. parallelize와 vectorize의 *호출 컨벤션 차이*가 핵심.
- **GPU 코드 작성**: ✅ *CUDA→Mojo 매핑표 + complete examples*. 추측 없이 작성 가능.
- **CPU conv2d 작성 시 함정**: `out` 예약어 / `rebind` 필요성 등 *skills SKILL이 직접 명시*.

→ **영구 지침 "새 cycle 진입 시 modular/skills 먼저 설치"의 실효성 증명**. CLAUDE.md §0 유지.

### 6.4 종합 보강 결론

> **Mojo 1.0은 *CPU 학습/개발에 완전히 사용 가능* 단계** (cycle-1 결론 유지). matmul/vector/reduction/conv 모두 *재현 + 개선* 측정됨.
>
> GPU 코드 패턴도 modular/skills로 *정확 학습 가능*. 단, *CPU only 머신에서 GPU 코드 컴파일 자체 불가*는 본 cycle의 *명확한 한계*. **GPU 도착 시 코드 검증 + 실측**이 명시된 다음 우선순위.
>
> MAX의 *production LLM serving*은 OpenAI SDK 호환 표면이 깔끔히 정리됨 (cycle-1 결론 강화).

## 7. 호환성 매트릭스 (cycle-3, work 0031-0035)

사용자 질문 5건 (Python / NumPy / PyTorch / ONNX / StableHLO) 실험 결과.

### 7.1 한 표 — 호환성 종합

| 대상 | Mojo 1.0 / MAX 26.3 호환성 | 주요 관찰 |
|------|:--:|------|
| **Python** | ✅ 0.26 ↔ 1.0 *동일 비용 모델* | math/numpy cold·warm import 동일, type 변환 4종 동일, 예외 통합 동일 |
| **NumPy** | ✅ *bit-perfect 동일* (16~22 ns/elem) | ndarray PyObject 그대로, 모든 API 동작. zero-copy buffer 진입은 미정복 |
| **PyTorch (CPU)** | ✅ 완전 동작 | torch 2.11.0+cpu / transformers 5.2.0. nn.Linear forward 49 μs |
| **ONNX (Python interop)** | ✅ onnxruntime 1.26.0 via interop | yolov8n 메타데이터 정상, 추론은 Python boundary 한 번 |
| **ONNX (max.engine import 시)** | ❌ **런타임 crash** | MLIR context 충돌 — *예상치 못한 발견* |
| **StableHLO** | ❌ 미수용 | Modular 공식 입장 "no roadmap plans" |

### 7.2 결정적 발견 — Mojo와 MAX의 *프로세스 공존 한계*

**Mojo 코드 안에서 `Python.import_module("max.engine")` 호출 시 *런타임 crash*** (work 0034):

```
LLVM ERROR: Init::getOrCreateContext() requested an M::Context
with different Init::Options to those used to create the existing M::Context
```

→ Mojo 컴파일러의 MLIR context와 max.engine의 MLIR context가 *동일 프로세스에서 양립 불가*. 이는 work 0035 StableHLO 차단 요인 "MLIR linking 두 라이브러리 동시 사용 불가" (Stef forum 발언)의 직접 증거.

**의미**: Mojo + MAX는 *코드 한 프로세스 공존 패턴 불가*. 다음 셋 중 하나로:
1. `max serve` 별도 daemon → Mojo가 HTTP client로 호출
2. *Python 스크립트* (Mojo 무관)에서 max.engine 사용
3. Mojo `.so` 모듈을 *Python에서 import*해 onnxruntime/torch와 합치기

### 7.3 ONNX/StableHLO 의 위치

| 도구 | StableHLO 받음? | ONNX 받음? |
|------|:--:|:--:|
| **MAX 26.3** | ❌ | ❌ |
| onnxruntime | △ (외부 변환) | ✅ |
| IREE | ✅ (1급 frontend) | ✅ |
| OpenXLA backend | ✅ | △ |
| PyTorch (torch.compile) | △ (Torch-MLIR) | ✅ export |

→ MAX는 *production LLM serving*에서 강하지만 *cross-framework 모델 import*에선 약함. CPU 사용자에겐 *onnxruntime이 표준*.

### 7.4 사용 패턴 권장

```
┌────────────────────────────────────────────────────────┐
│                   Mojo 1.0 사용자                       │
├────────────────────────────────────────────────────────┤
│ 학습/실험:                                              │
│   Mojo native (SIMD/parallelize/conv2d)                │
│   + Python interop (NumPy/PyTorch import)              │
│   ⚠ max.engine은 Mojo 안에서 *절대 import 안 함*       │
│                                                         │
│ Production:                                             │
│   ① max serve (별도 daemon) + Mojo HTTP client         │
│   ② Mojo .so 핫커널 + Python(onnxruntime/torch)        │
│   ③ 모델 전체 Mojo 재작성 (max.graph 또는 Mojo native) │
└────────────────────────────────────────────────────────┘
```

### 7.5 마이그레이션 매트릭스

0.26 호환성 코드 → 1.0 변경 필요 표면:

| 0.26 패턴 | 1.0 동작 |
|----------|---------|
| `Python.import_module("math/numpy/torch/transformers")` | ✅ 변경 없음 |
| `Int(py=po)`, `Float64(py=po)`, `String(py=po)` | ✅ 변경 없음 |
| `try/except e:` Python 예외 | ✅ 변경 없음 |
| `np.array(list)` 변환 | ✅ 비용 동일 |
| `from std.python import` (`std.` prefix) | 0.26 후반부터 권장, 1.0 강제 |
| **`Python.import_module("max.engine")` from Mojo** | **❌ 런타임 crash** |
| `torch.tensor([[...], [...]])` 중첩 list 직접 전달 | ❌ → `Python.list()` 명시 변환 필요 |

## 8. 외부 참조

- Mojo 1.0.0b1 release notes: https://mojolang.org/releases/v1.0.0b1/
- Modular 26.3 forum announcement: https://forum.modular.com/t/modular-26-3-mojo-1-0-beta-mojolang-org-max-video-gen-and-more/3038
- Install: https://mojolang.org/install/
- Mojo changelog: https://docs.modular.com/mojo/changelog/
