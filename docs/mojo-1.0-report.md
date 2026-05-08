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
| `fn` → `def` | sed | 1분 |
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

## 6. 외부 참조

- Mojo 1.0.0b1 release notes: https://mojolang.org/releases/v1.0.0b1/
- Modular 26.3 forum announcement: https://forum.modular.com/t/modular-26-3-mojo-1-0-beta-mojolang-org-max-video-gen-and-more/3038
- Install: https://mojolang.org/install/
- Mojo changelog: https://docs.modular.com/mojo/changelog/
