# Mojo 학습 최종 평가 (학습자 의견)

- **일자**: 2026-05-11
- **버전**: Mojo 1.0.0b1 / MAX 26.3 (CPU 환경)
- **학습 범위**: work 0001 ~ 0035 (3 cycle, 35 work, ~40개 코드 파일, 2 cycle log + 종합 보고서)
- **본 문서 성격**: *학습자 본인의 결론*. Modular 마케팅·외부 평가와 무관한 *직접 검증 기반 평가*.

---

## 1. 한 줄 결론

> **Mojo는 현재 *사용할 만한 가치가 없음***. 문법 진입장벽이 낮다는 작은 장점이 *새 언어/환경/철학 학습 비용*을 상쇄하지 못하며, **Python + PyTorch + NumPy 대비 *return이 없음***. Python (및 C++/Rust)의 **superset 의도**는 인지하나 *1.0.0b1 시점*에선 **subset에 가까움**.

---

## 2. 평가 근거 (직접 검증 기반)

### 2.1 *반환되는 가치* 영역별 비교 표

| 차원 | Mojo 가치 | Python/PyTorch/NumPy 비교 | 결론 |
|------|-----|---------|------|
| **문법 진입장벽** | ✅ 낮음 (Python-like) | Python 이미 익숙 | **Tie** |
| **새 언어 학습 비용** | ⚠️ 있음 (소유권, comptime, trait, MLIR 개념 등) | 0 (이미 알고 있음) | **Mojo 손해** |
| **인프라/생태계** | ❌ 매우 작음 (1.0.0b1) | 압도적 (PyPI 50만+ 패키지) | **Mojo 압도적 패배** |
| **편의성** | △ kernel 작성은 깔끔 (`(c+i).store(...)`) | 일반 작업은 Python이 더 편함 | **Python 우세** |
| **성능 (kernel)** | ✅ C++ AVX-512와 ISA 동등 (work 0009/0021) | NumPy/PyTorch backend도 C++/CUDA | **Tie** (둘 다 동등) |
| **성능 (production)** | △ MAX serve | vLLM/TGI/TensorRT-LLM 압도 | **PyTorch 진영 우세** |
| **확장성 — custom dialect** | ❌ 불가능 (work 0035) | MLIR/IREE 직접: 자유 | **IREE 압도적** |
| **확장성 — custom NPU** | ❌ 등록 메커니즘 없음 (`--target-accelerator` hardcoded list) | LLVM target registration 표준 | **LLVM 압도적** |
| **확장성 — custom pass** | ❌ closed compiler | MLIR pass 자유, TorchDynamo plugin 등 | **다른 도구 우세** |
| **Python 코드 직접 실행** | ❌ Python interop만 가능 (CPython 그대로 호출) | CPython이 *원본* | **Python 압도적** |
| **GPU kernel ergonomic** | △ CUDA보다 깔끔 | Triton (오픈, Python embed) | **Triton 동등 또는 우세** |
| **MAX = Mojo 패키지?** | ❌ MAX는 *Python 패키지* (work 0034 crash로 분리성 증명) | — | **MAX와 Mojo 분리** |

→ **거의 모든 차원에서 *Mojo가 *유일하게 우세*한 영역 없음***. *동등하거나 손해*가 대다수.

### 2.2 superset 의도 vs subset 현실

| Modular vision | 1.0.0b1 실측 |
|---------------|---------|
| **"Python superset"** | ❌ Python 코드 *직접 실행 안 됨*. `import some.py` X. interop 시 `Python.import_module(...)`로 *외부* 호출만 |
| **"C++의 성능"** | ✅ work 0009/0011 — kernel은 동등 |
| **"Rust의 안전성"** | △ ownership 일부 (read/mut/var), borrow checker는 *덜 엄격* |
| **"하나의 언어로 CPU+GPU+NPU"** | △ NVIDIA/AMD/Apple만, *사용자 NPU 추가 불가* |
| **"AI infra 통합"** | ⚠️ Mojo + MAX 같은 프로세스 공존 시 *crash* (work 0034) |

→ Modular의 *superset vision*은 *2-3년 후 미래*에 약속된 것. 현재는 *subset*에 가까움.

- **Python subset**: 표준 Python 코드 실행 불가, *Python의 syntax 일부 모방*만 가능
- **C++ subset**: SIMD intrinsics + ergonomic 일부, *템플릿/생태계/exception 깊이*는 부족
- **Rust subset**: ownership 일부, *lifetime/borrow checker 엄격성/cargo*는 부족

### 2.3 *고유 가치* 영역의 좁음

본 학습 자료에서 *Mojo가 유일하게 마진을 갖는* 영역:

```mojo
# SIMD vector add — C++ 대비 *문법적* 우위
(c + i).store(a.load[width=16](i) + b.load[width=16](i))
```

→ **유일한 *진정한 가치*는 *CPU SIMD intrinsics 작성 시 syntax ergonomic***. 그러나:
- 이건 *얼마 자주 작성하는 작업인가?* — 대다수 사용자는 NumPy/PyTorch backend가 처리 → **드물게 직접 작성**
- 직접 작성 시에도 *Highway/xsimd/SIMDe* 같은 *오픈* C++ wrapper가 *충분히 깔끔*

→ **마진의 절대값과 사용 빈도 모두 작음**. *학습 비용 회수 어려움*.

---

## 3. 학습자가 *원래 기대한 가치* vs *실측*

학습 시작 시 본 학습자가 기대했던 *Mojo의 두 핵심 가치*:

### 3.1 기대 1: **Custom dialect/pass 작성 가능성**

- **기대**: 자체 NPU/이론용 dialect을 backend로 등록해서 Mojo로 표현
- **실측**: ❌ 완전 불가 (work 0035 + 추가 검증)
  - `--target-accelerator` enum이 컴파일러 ELF에 hardcoded
  - MLIR dialect registration API는 *내부 사용 only*, 외부 노출 X
  - Mojo 컴파일러 closed source, 직접 수정 불가
  - Modular 공식 입장: "aspirational goal, no roadmap"
- **권장 대체재**: IREE / MLIR 직접 / Triton custom backend

### 3.2 기대 2: **Python 코드 그대로 사용**

- **기대**: `.py` 파일을 Mojo runtime에서 더 빠르게 실행
- **실측**: ❌ 완전 불가
  - `mojo run foo.py` 안 됨
  - Mojo는 *interop만* 제공 (`Python.import_module(...)`) — *CPython 그대로 호출*하는 wrapper
  - Mojo의 syntax는 Python-like일 뿐 *Python 코드 그 자체*는 아님
- **권장 대체재**: PyPy / numba / Cython / `torch.compile` (이미 *오픈 + 성숙*)

→ **두 핵심 기대 모두 불만족**. 학습자가 *Mojo에 진입한 *근본 동기*가 *부재*한 상태*.

---

## 4. 그래도 학습한 *부수 가치*

본 학습 cycle (work 0001-0035)에서 *Mojo 자체와 무관하게* 모은 *영구 지식*:

| 영역 | 가치 (Mojo 도태와 무관히 살아남음) |
|------|---------------------------------|
| AVX-512 SIMD ISA (vaddps %zmm 등) | 영구 — 모든 컴파일러/언어 무관 |
| Roofline 모델 / ops-per-byte 분석 (work 0027) | 영구 — 모든 HW에서 유효 |
| Cache hierarchy + matmul blocking (work 0013) | 영구 — 알고리즘 측면 |
| MAX/onnxruntime/vLLM/llama.cpp의 *시장 위치* | 영구 — 도구 선택 시 직접 활용 |
| MLIR의 *닫힌 시스템 한계* (Stef 발언 + work 0034) | 영구 — 향후 *다른 MLIR-based 도구* 평가 시 동일 잣대 |
| CUDA ↔ Mojo SIMT 매핑 표 (work 0028) | △ — CUDA 자체는 유효, Mojo 표는 *Mojo가 도태되면 무효* |

→ **학습 *시간 투자의 70%는 *Mojo 외 영역에서* 회수***. *Mojo 자체*의 학습 가치는 *얇음*.

---

## 5. 권장 행동

### 5.1 학습자 본인의 향후 행동

1. **Mojo cycle 영구 종결**. 추가 work 없음.
2. *Modular release notes만 quarterly 모니터링*. 1.x stable 또는 *open-source 발표* 시 재진입 검토.
3. **시간 투자 재배분**:
   - GPU kernel → **Triton** 학습
   - Custom HW dialect → **IREE** + MLIR 직접
   - LLM inference → **vLLM / llama.cpp / onnxruntime** (이미 검증됨)
   - 시스템 언어 ergonomic → **Rust** (오픈, 성숙, 압도적 ecosystem)
4. *본 학습 워크스페이스의 *영구 지식 part*는 NAS 지식 베이스에 이미 전이됨* (`~/NAS/__MyNeuron/`). 활용 가능.

### 5.2 다른 학습자에게의 권장 (Mojo 진입 검토 중인 경우)

- **Modular와 공식 파트너십 / 대형 production 도입 결정권자**가 아닌 한 **Mojo 학습 권장하지 않음**
- 시간이 있다면 **release notes 정기 모니터링 + 1.0 stable 또는 open-source 시점 재평가** 권장
- *대학원생 / 연구자*가 *언어 디자인 호기심*으로 보는 건 OK (본 학습자 케이스) — 단 *실용 도구 도입은 별개*

---

## 6. 본 평가의 *제한 조건*

본 평가가 *향후 무효화될 조건*:

| 조건 | Mojo 재평가 사유 |
|------|---------------|
| Modular가 *Mojo 컴파일러 open-source* 발표 | custom dialect/pass 추가 가능해짐 → 결정적 reversal |
| Mojo가 *진정한 Python superset* 달성 (`.py` 직접 실행) | *new language 학습 비용 = 0*이 됨 |
| MAX가 *Mojo와 한 프로세스 공존* 가능 (work 0034 crash 해소) | "통합 stack" vision 현실화 |
| `--target-accelerator`에 *사용자 plugin 등록* 추가 | custom NPU 진입 가능 |
| Apple Silicon 환경에서 *Metal 4.0 진영의 결정적 advantage* 입증 | Apple HW 사용자 한정 우위 |

→ 위 *어느 하나라도 발생 시* 본 평가는 *revision*. **2026-05-11 시점에는 모두 *부정***.

---

## 7. 종합

> **"새 언어를 배운다는 사실 자체"의 비용을 *압도적으로* 능가하는 *return*이 없음**.
>
> Python/PyTorch/NumPy/Rust/Triton/IREE의 *기존 도구로 *모두* 대체 가능*하고, 일부는 *Mojo보다 우세*. *Mojo의 유일한 마진* (CPU SIMD ergonomic)은 *너무 좁음*.
>
> **결론: 현 시점 Mojo는 *사용할 만한 가치가 없음***. 학습 투자 회수는 *주변 지식*으로만 이뤄짐 — 그것은 *별도 stack 학습으로도 가능*했던 영역.
>
> *2-3년 후 Modular vision이 실현되면 재평가*. 그 전까지는 *관심 모니터링* 외 추가 시간 투자 *없음*.
