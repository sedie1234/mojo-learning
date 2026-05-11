# Mojo 학습 워크스페이스 — 1.0 branch (영구 종결)

> 🛑 **학습자 최종 평가: *사용 가치 없음*. 본 cycle 영구 종결.**
> 자세한 평가: [`docs/mojo-final-evaluation.md`](docs/mojo-final-evaluation.md)

C++ 사용자 관점에서 Mojo 0.26 → 1.0.0b1까지 직접 검증한 학습 기록. 모든 결론은 *마케팅·외부 평가 인용이 아닌 *직접 코드 실행과 ASM dump 기반*.

---

## 한 줄 결론 (학습자 인용)

> *"문법 진입장벽은 낮으나, 결국 새 언어를 배운다는 점은 변함이 없음. 새 언어/환경/철학에 적응해야 하는데 Python-PyTorch-NumPy 대비 인프라/편의성/성능/확장성 return이 없음. Python (및 C++/Rust)의 superset 의도는 알겠으나 1.0.0b1 시점 *subset*에 가까워 사용할 만한 가치 없음."*

---

## 학습 cycle 누적 (35 work, 약 3주)

| Cycle | 기간 | 범위 | work | 결과 핵심 |
|-------|------|------|------|----------|
| **cycle-1** | 2026-04-28 ~ 04-29 | 0.26 학습 (언어 + SIMD + interop + MAX) | 0001-0015 | Mojo SIMD = C++ AVX-512 ISA 동등 검증. MAX CPU 경로 차단 확인 |
| **cycle-2 (1.0)** | 2026-05-08 | 1.0.0b1 회귀 + GPU 코드 + CNN | 0016-0030 | 0.26 → 1.0 마이그레이션 비용 작음. matmul +9~28%, vector add L1/DRAM +30~40% |
| **cycle-3 (1.0)** | 2026-05-11 | 호환성 5건 (Python/NumPy/PyTorch/ONNX/StableHLO) | 0031-0035 | Mojo + MAX 같은 프로세스 *crash* 발견. StableHLO 미수용 |

---

## 실험 환경

| 항목 | 값 |
|------|-----|
| OS | Ubuntu 24.04.4 LTS, kernel 6.17.0-22-generic |
| CPU | x86-64 AVX-512, 16 cores |
| RAM | 14 GiB |
| GPU | **없음** (모든 결과 CPU 전용 — 1.0 GPU 코드는 코드만 작성) |
| Python | 3.12.3 |
| g++ | 13.3.0 |
| Mojo (cycle-1) | 0.26.2.0 (d627decc) in `.venv/` |
| **Mojo (cycle-2/3)** | **1.0.0b1 (a9591de6)** in `.venv-1.0/` |
| MAX (cycle-2/3) | 26.3.0 + transformers 5.2.0 |
| 추가 도구 | torch 2.11.0+cpu, onnxruntime 1.26.0, numpy 2.4.4 |

### 설치 재현

```bash
cd <repo>
# 1.0
python3 -m venv .venv-1.0
source .venv-1.0/bin/activate
pip install --upgrade pip
pip install --pre mojo modular
mojo --version          # → Mojo 1.0.0b1 (a9591de6)
```

---

## 디렉토리 구조

```
<repo>/
├── README.md                          ← 이 파일
├── CLAUDE.md                          ← Claude Code 운영 규칙 (§0: modular/skills 설치 first action)
├── TODO.md                            ← 학습 종결 상태 + 재진입 trigger
├── docs/
│   ├── mojo-final-evaluation.md       ← 🛑 학습자 최종 평가 (사용 가치 없음)
│   ├── mojo-1.0-report.md             ← cycle-1/2/3 종합 보고서 (8섹션)
│   └── performance-summary.md         ← 성능 측정 표
├── log/                               ← 35개 5섹션 정형 로그
│   ├── README.md
│   └── NNNN-<slug>.md
├── experiments/                       ← 실행 코드 (work별 폴더)
│   ├── 0001-* ~ 0015-*                ← cycle-1 (0.26)
│   ├── 0016-1.0-* ~ 0025-1.0-*        ← cycle-2 (1.0 회귀)
│   └── 0026-1.0-* ~ 0035-1.0-*        ← cycle-3 (호환성)
└── .claude/                           ← AI 페어 프로그래밍 sub-agent + skill
    ├── agents/                        ← orchestrator/experimenter/log-keeper
    └── skills/work-log/
```

---

## work 1줄 요약 (시간 역순, 35개)

### cycle-3 — 호환성 5건 (Python / NumPy / PyTorch / ONNX / StableHLO)
| # | 제목 | 핵심 |
|---|------|------|
| 0035 | StableHLO 호환성 | ❌ Modular 공식 입장 *미지원, no roadmap* |
| 0034 | ONNX 호환성 | ⚠️ onnxruntime ✅, **Mojo + max.engine = 런타임 crash** (MLIR context 충돌) |
| 0033 | PyTorch 호환성 (CPU) | ✅ torch 2.11.0+cpu 완전 동작. 중첩 list literal 함정 |
| 0032 | NumPy 호환성 | ✅ *bit-perfect 동일* (16~22 ns/elem 0.26 ↔ 1.0) |
| 0031 | Python 호환성 회귀 | ✅ 비용 모델 0.26 ↔ 1.0 동일 |

### cycle-2 — 1.0 회귀 + GPU 코드 + CNN
| # | 제목 | 핵심 |
|---|------|------|
| 0030 | CNN 2D conv (CPU + GPU 코드) | CPU 43 GFLOPS (16 cores). GPU 코드는 *문서 가치만* |
| 0029 | GPU LLM 코드 (max serve + Python client) | OpenAI SDK 호환 표면. CPU에서 graph build 차단 |
| 0028 | GPU SIMT 코드 (vector/reduction/matmul) | modular/skills 패턴. CPU 머신 컴파일 불가 |
| 0027 | Vector add + parallelize | **ops/byte 의존성 직접 증명**: 낮은 ops/byte = parallelize *역효과* |
| 0026 | Matmul 1.0 (naive/SIMD/parallelize/blocked) | blocked **+9~28% 빠름** (vs 0.26) |
| 0025 | MAX 26.3 + Qwen3 retry (CPU) | ❌ 여전히 차단. *Accelerator 하드코드* 발견 |
| 0024 | Safe closure + parallelize | 0.26 패턴 회귀 OK. 명시 capture는 vectorize용 |
| 0023 | Conditional conformance 신기능 | stdlib 동작 ✅, 사용자 측 syntax 미정복 |
| 0022 | Bounds checking default ON | ✅ **overhead 0~1%** (LLVM hoist out) |
| 0021 | SIMD vector add 회귀 | ✅ **vaddps %zmm 동등** + L1/DRAM +30~40% |
| 0020 | UnsafePointer non-null | 핫루프 OK. Optional 시그니처 미정복 |
| 0019 | `__copyinit__/__moveinit__` 마이그레이션 | 0.26 패턴 깨짐. keyword-only `__init__` 또는 자동 생성 |
| 0018 | Negative indexing 제거 | ✅ 차단. **부수 발견**: List 가변 인자 ctor 제거 |
| 0017 | fn → def 마이그레이션 | sed 한 줄로 100% |
| 0016 | hello world 회귀 | ✅ AOT 크기 -58% (44 KB → 18.6 KB) |

### cycle-1 — 0.26 학습
| # | 제목 | 핵심 |
|---|------|------|
| 0015 | YOLO ONNX → MAX | ❌ MAX는 ONNX 미수용 |
| 0014 | MAX CPU 적용성 (Qwen3 / Gemma4) | ❌ encoding × device 차단 |
| 0013 | Blocked matmul | N=2048 Mojo 236 / C++ 193 / NumPy MKL 1540 GFLOPS |
| 0012 | Matmul 4-way 비교 | Mojo SIMD+par 437 GFLOPS @ N=512 |
| 0011 | Sum reduction 4-way | Mojo `acc.reduce_add()` = C++ `_mm512_reduce_add_ps` *bit-identical* |
| 0010 | vector add 4-way (Python/NumPy/C++/Mojo) | Mojo ns/elem 0.074, C++ 0.072 — 동등 |
| 0009 | **SIMD vector add Mojo vs C++ AVX-512** | **`vaddps %zmm` ASM 동등** (work 0021에서 1.0 재확인) |
| 0008 | Trait + Python interop cost | Python pure ↔ Mojo native **100× 차** |
| 0007 | Language Fundamentals | 0.26 키워드 변경 표 (inout→mut, owned→var, ...) |
| 0006 | Python interop 비용 | cold 17-39ms / warm sub-μs / 변환 16-22 ns/elem |
| 0005 | 패키지/모듈 구조 fs 탐사 | `mojo` CLI = 201B Python wrapper → 135MB ELF |
| 0003 | Mojo 설치 + hello world AOT | venv + `pip install modular` (2.0 GB) |
| 0001 | 워크스페이스 셋업 | 3-agent + work-log skill |

---

## 핵심 인사이트 (검증된 영구 지식)

### Mojo 기술적 특성 (1.0.0b1 기준)

1. **SIMD ergonomic 우위**: `(c+i).store(a.load[width=16](i)+b.load[width=16](i))` → `vaddps %zmm` 직접 emit. C++ `_mm512_*` intrinsics와 *ISA 동등 + 문법은 깔끔* (work 0009/0021)
2. **`parallelize`는 *ops/byte 의존*** — matmul +5-6×, vector add 역효과. roofline 모델 *직접 증명* (work 0027)
3. **1.0 컴파일러 backend 개선 일관**: matmul +9~28%, vector add L1/DRAM +30~40%, AOT 크기 -58%
4. **Bounds check default ON은 *공짜에 가까움*** — LLVM이 hoist out. overhead 0~1% (work 0022)
5. **소유권 모델**: `read`/`mut`/`var` + `^` transfer. Rust borrow checker 학습 곡선 완만 버전

### 결정적 한계 (사용 가치 평가에 직접 영향)

1. **Custom dialect/backend 등록 메커니즘 *없음*** — `--target-accelerator` enum이 *컴파일러 ELF에 hardcoded* (work 0035 + 추가 검증)
2. **MAX와 Mojo *같은 프로세스 공존 불가*** — `Python.import_module("max.engine")` 호출 시 *런타임 crash* (MLIR context 충돌, work 0034). **본 cycle의 가장 결정적 발견**
3. **Python 코드 *직접 실행 불가*** — interop만 가능 (CPython wrapper). superset 의도는 미달성
4. **StableHLO/ONNX/PyTorch model 직접 import 불가** — HF safetensors + 등록 architecture만 (work 0015/0034/0035)
5. **컴파일러 closed-source** — 사용자 수정/plugin 불가

### Python interop 비용 (변화 없음)

- Cold import: math 17-26 ms, numpy 39-65 ms (Py_Initialize 포함, 1회만)
- Warm import: 300~640 ns
- `np.array(list)` 마샬링: 16~22 ns/elem (N≥1K), fixed overhead ~600 ns
- 타입 변환: `Int(py=po)` keyword-only (1.0도 동일)
- **0.26 ↔ 1.0 비용 모델 bit-identical**

---

## 학습자 평가 (인용)

```
"새 언어를 배운다는 사실 자체"의 비용을 압도적으로 능가하는 return이 없음.

Python/PyTorch/NumPy/Rust/Triton/IREE의 기존 도구로 모두 대체 가능하고,
일부는 Mojo보다 우세. Mojo의 유일한 마진(CPU SIMD ergonomic)은 너무 좁음.

결론: 현 시점 Mojo는 사용할 만한 가치가 없음.
```

상세 분석: [`docs/mojo-final-evaluation.md`](docs/mojo-final-evaluation.md) (8 섹션)

### 재진입 trigger (모두 부정 시 *재진입 안 함*)

| # | 트리거 | 2026-05-11 상태 |
|---|--------|:--:|
| 1 | Mojo 컴파일러 open-source 발표 | ❌ |
| 2 | 진정한 Python superset 달성 (`.py` 직접 실행) | ❌ |
| 3 | MAX/Mojo 한 프로세스 공존 가능 (work 0034 crash 해소) | ❌ |
| 4 | `--target-accelerator` 사용자 plugin 등록 | ❌ |
| 5 | 학습자 Modular 공식 파트너십 진입 | ❌ |

→ **모두 부정**. 모니터링만 유지.

---

## 권장 대체 stack (학습자 입장 → 다른 사용자에게)

| 원래 의도 | 권장 도구 |
|----------|----------|
| GPU kernel 빠르고 깔끔하게 | **Triton** (오픈, Python embed) |
| Custom HW dialect / NPU 등록 | **IREE** + MLIR 직접 |
| Python 코드 빠르게 | **PyPy / numba / Cython / torch.compile** |
| LLM serving production | **vLLM / TGI / llama.cpp / TensorRT-LLM** |
| CPU SIMD ergonomic | **Highway / xsimd / SIMDe** (C++ 오픈 wrapper) |
| 시스템 언어 ergonomic | **Rust** (오픈, 성숙, 압도적 ecosystem) |

---

## 영구 보존된 *Mojo 외* 학습 자산

본 cycle에서 *Mojo 도태와 무관히* 살아남는 지식 (NAS `~/NAS/__MyNeuron/`에 전이됨):

- AVX-512 SIMD ISA 매핑 (vaddps %zmm 등)
- Roofline 모델 + ops/byte 분석 (work 0027 직접 측정)
- Cache hierarchy + matmul blocking (work 0013)
- MAX/onnxruntime/vLLM/llama.cpp 시장 위치
- MLIR 닫힌 시스템의 한계 (work 0034 crash 증거)
- CUDA ↔ Mojo SIMT 매핑 (Mojo 도태되면 CUDA 부분만 유효)

학습 투자의 약 70%가 위 *주변 지식*에서 회수됨. 그것은 *별도 stack 학습으로도 가능*했던 영역이지만, *Mojo cycle 안에서* 자연스럽게 수집됨.

---

## 학습/실험 워크플로우 (참고용)

이 저장소는 **Claude Code(AI 페어 프로그래밍)**와 함께 만들어졌다. `.claude/` 안 3-agent 시스템:

- `mojo-orchestrator`: 사용자 목표 → work 분해 → experimenter 디스패치
- `mojo-experimenter`: 단일 work 실행 (코드 작성·실행·결과 캡처)
- `mojo-log-keeper`: `work-log` skill로 5섹션 정형 로그 작성

워크스페이스 운영 규칙은 `CLAUDE.md`. §0에 *Mojo 작업 시작 시 modular/skills 설치 first action* 등재 (재진입 트리거 발생 시 적용).

다른 사람이 이 저장소를 활용한다면:
- `log/`만 읽어도 학습 흐름 전체 파악 가능 (5섹션 self-contained)
- `experiments/NNNN-*/`의 코드는 `mojo run`으로 재현 가능 (적절한 venv 활성화 후)
- `docs/mojo-final-evaluation.md`는 *본 학습자 결론*. 다른 사용자의 판단은 별개

---

## 참고

- **Modular 공식 문서**: https://docs.modular.com/mojo
- **Mojo 1.0.0b1 release notes**: https://mojolang.org/releases/v1.0.0b1/
- **modular/skills repo**: https://github.com/modular/skills (재진입 시 first action)
- **GitHub** (이 저장소): https://github.com/sedie1234/mojo-learning (branch `mojo-1.0`)
- **MLIR dialect import 한계 (forum)**: https://forum.modular.com/t/mlir-dialect-import-for-mojo/774

## 라이선스

개인 학습용. 자유롭게 복제/수정.
