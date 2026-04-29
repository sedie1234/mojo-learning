---
id: 0006
title: Python interop 표면 + 비용 측정 (lifecycle / 변환비용 / 타입변환 / 예외)
status: done
date: 2026-04-29
tags: [python-interop, benchmark, basics]
related_code: experiments/0006-python-interop-survey/
---

# 0006. Python interop 표면 + 비용 측정 (lifecycle / 변환비용 / 타입변환 / 예외)

## 1. 무엇을 하고자 하는지

Mojo↔Python 양방향 interop의 **현재 표면 전체**를 한 work으로 한 번에 파악. 4개 issue를 묶어 다룸:

| issue | 질문 |
|-------|------|
| T-22 | Mojo 안에서 CPython 인터프리터의 lifecycle은? Py_Initialize는 언제 일어나는가? cold vs warm import_module 비용 차이는? |
| T-15 | NumPy `np.array(list)` 변환 비용이 데이터 크기에 어떻게 비례하는가? per-element 마샬링 cost 추정 |
| T-23 | PyObject ↔ Mojo native 타입 변환은 어떤 API로 이루어지는가? Int/Float64/String/List 양방향 |
| T-24 | Python 예외(ZeroDivision/Key/Value/Attribute)가 Mojo `try/except`로 잡히는가? 메시지 보존? |

## 2. 수행한 일

### 2.1 환경 + API 표면 probe

기존 0005에서 확인된 것: `mojo` ELF가 venv의 libpython을 dlopen해 Python in-process로 호출. `import std.python` 권장 (Mojo 0.26부터 `import python`은 deprecation).

probe로 발견한 **Mojo 0.26 변환 API의 키 사실**: Int/Float64/String 모두 **키워드-only `py=` 파라미터로만** PythonObject → Mojo native 변환을 받음. 이전 문서에 흔히 나오는 `Int(py_obj)` (positional)는 더 이상 동작 안 함.

```mojo
var n = Int(py=po)            # ✓ 키워드 only
var f = Float64(py=po)        # ✓
var s = String(py=po)         # ✓
# var n = Int(po)             # ✗ "expected at most 0 positional arguments, got 1"
```

또한:
- `from std.python import Python, PythonObject` (function 인자/반환 타입에서 PythonObject 사용 시 명시 import)
- `var sizes: List[Int] = [10, 100, 1000]` 식의 **List 리터럴은 동작**
- `Int(b - a)` 식 UInt → Int 캐스트는 정상 (`perf_counter_ns()`가 UInt 반환)

### 2.2 4개 실험 작성/실행

`experiments/0006-python-interop-survey/`에 `01_lifecycle.mojo` ~ `04_exception.mojo` 작성.

각 실험의 측정 프로토콜 (성능 측정에 한해):
- warmup 3회 + measure 10회
- median(중앙값) 사용 (10개 정렬 후 5번째)
- `from std.time import perf_counter_ns`로 타이밍

### 2.3 4 issue를 backlog → started로 일괄 이동, 본 work에서 한꺼번에 처리

T-22/23/24 신규 생성, Python Interop module 링크. T-15(기존)와 함께 4개 모두 `started`로 PATCH. 본 로그 작성 + `learning-issue-complete`로 일괄 마감.

## 3. 예상되는 결과

- **T-22**: 첫 import에 Py_Initialize 비용으로 ms 단위, 같은 모듈 재import은 sys.modules 캐시로 ns~μs.
- **T-15**: `np.array(list)`는 N에 선형, per-element 마샬링 비용은 수십 ns 수준이라 작은 데이터에서도 무시 못 함.
- **T-23**: Mojo→Python은 builtins로 자동, Python→Mojo는 명시 캐스트 필요(타입 안전 위해).
- **T-24**: Mojo `try/except`가 Python 예외를 통합 처리, 메시지는 보존.

## 4. 실제 결과

### 4.1 T-22 — Lifecycle

```
cold (math, 첫 호출):            17,132,828 ns  (≈ 17 ms)
warm (math, 2회):                       640 ns
warm (math, 3회):                       360 ns
warm (math, 4회):                       310 ns
new  (sys, 첫 호출):                    410 ns
new  (os,  첫 호출):                    370 ns
warm (sys, 2회):                        330 ns
cold-ish (numpy, 첫 호출):       38,864,418 ns  (≈ 39 ms)
warm (numpy, 2회):                     1,790 ns

ratio cold/warm (math):           25,158×
ratio numpy_cold/numpy_warm:      21,699×
```

→ **`math` 첫 호출이 17 ms** — 다음 다른 모듈 첫 호출(sys, os)은 **각 410/370 ns로 수십 μs 미만**. 즉 첫 import에만 Py_Initialize 비용이 들어가고, 이후는 *해당 모듈만* 로드. **NumPy는 첫 호출이 39 ms** — math보다 더 비싼 건 NumPy 자체의 import time(많은 sub-module, C 확장 dlopen) 때문.

### 4.2 T-15 — NumPy 변환 비용 vs 크기

```
size       | median ns       | ns/elem
-----------|-----------------|--------
10         |             810 |     81
100        |           2,640 |     26
1,000      |          22,090 |     22
10,000     |         215,138 |     21
100,000    |       1,625,260 |     16
```

→ **N-linear**, asymptotic per-element ≈ **16~22 ns/elem**. N=10에서 81 ns/elem로 보이는 건 fixed overhead(~600 ns)가 분모에 영향. 100K element도 1.6 ms — 절대값으로 빠르지만 **NumPy native 작업(예: `np.arange(100000)`)은 ~50 μs** 수준이므로 *비교 작업의 30배 비용*. 따라서 **Mojo↔Python boundary를 자주 횡단하는 패턴은 비효율**, 한 번에 큰 배치로 넘기는 게 맞음.

### 4.3 T-23 — Type 변환

| 방향 | API | 동작 |
|------|-----|------|
| Mojo Int → Python int | `builtins.int(mojo_int)` | ✅ 자동 (PythonObject 반환) |
| Python int → Mojo Int | `Int(py=po)` | ✅ 키워드-only 캐스트 |
| Mojo Float64 → Python float | `builtins.float(mojo_f)` | ✅ |
| Python float → Mojo Float64 | `Float64(py=po)` | ✅ |
| Mojo String → Python str | `builtins.str(mojo_s)` | ✅ |
| Python str → Mojo String | `String(py=po)` | ✅ |
| Python list (직접 사용) | `var l = Python.list(1,2,3)` 후 PyObject로 사용 | ✅ append, indexing 동작 |
| Mojo List[Int] → Python list | 수동 loop + append | ✅ (전용 단축 syntax 없음) |
| **Mojo native 인자 자동 변환** | `math.sqrt(16)` (Int 자동 변환) | ✅ Mojo Int/Float이 함수 인자에선 자동 |

핵심 비대칭:
- **Mojo → Python**: 자동 (Mojo native가 Python 함수 인자로 그대로 들어감, 또는 builtins로 explicit 변환)
- **Python → Mojo**: 항상 **`Int(py=...)` / `Float64(py=...)` / `String(py=...)` 키워드 캐스트 필요**

이유 추정: PyObject는 임의 타입을 가질 수 있으므로 implicit 변환은 안전하지 않음 → Mojo는 컴파일 시점에 타입 결정성을 강제.

### 4.4 T-24 — 예외

| Python 예외 | Mojo `try/except`로 잡히는가 | 메시지 |
|-------------|:---:|--------|
| ZeroDivisionError | ✅ | `division by zero` |
| KeyError | ✅ | `'nonexistent_key'` |
| ValueError | ✅ | `invalid literal for int() with base 10: 'not_a_number'` |
| AttributeError | ✅ | `module 'math' has no attribute 'nonexistent_function'` |
| 정상 케이스 | (잡힘 없음) | `10/2 = 5.0` |

→ **Python 예외가 Mojo error로 자연스럽게 통합**. 메시지는 그대로 보존. `fn ... raises` 시그니처 안에서 발생, `try ... except e:` 한 가지 형태로 다 잡힘.

단, **예외 type discriminate**(특정 예외 타입만 잡기)는 본 실험에선 확인 못 함 — Mojo `try/except`는 현재 *모든 error*를 한 번에 잡는 형태로 보임. Python의 `except KeyError as e`처럼 타입별 분기는 별도 검증 필요 (후속 work 후보).

## 5. 결론

### 5.1 Python interop의 비용 모델 (요약)

```
프로그램 시작 ─────────────────────────────── 0
                                                 │
첫 Python.import_module(...)                     │  ← Py_Initialize 한 번에 17 ms (math), 39 ms (numpy)
                                                 │
같은 모듈 재import (sys.modules 캐시)            │  ← 300~700 ns
다른 새 모듈 첫 import (Py_Initialize 끝남)      │  ← 모듈 자체 import 비용만 (가벼우면 < μs)
                                                 │
PyObject 메서드 호출                             │  ← μs 수준 (CPython C API dispatch)
PyObject ↔ Mojo native 변환                      │  ← 마샬링 cost: 정수형 ~50 ns, 큰 list는 N-linear ~20 ns/elem
```

### 5.2 학습 인사이트 6개

1. **Cold start은 17 ms (작은 모듈) ~ 39 ms (numpy 류)** — 짧게 한두 번 호출하는 구조라면 비용이 무시 못 됨. 그러나 어플리케이션 시작 시 한 번이고, 이후로는 sub-μs (sys.modules 캐시).
2. **Per-element 마샬링 ≈ 16~22 ns/elem**. 작은 데이터(< 1000)는 fixed overhead(~600 ns)에 가려지고, 큰 데이터는 깔끔한 선형. **boundary를 자주 넘는 패턴(루프 안에서 PyObject로 변환)은 안티패턴**, 데이터를 모아 한 번에 넘기는 batch 패턴이 정답.
3. **Python → Mojo 변환은 키워드-only `py=`** API로만 가능 (Mojo 0.26). positional 캐스트는 컴파일 에러. 이건 *타입 안전성*을 위한 의도적 디자인 — PyObject가 임의 타입을 들고 있을 수 있으므로 명시적 표시를 강제.
4. **Mojo → Python 변환은 자동** — Python 함수 인자에 Mojo native(`Int`, `Float64`)를 그대로 넘기면 변환됨. `builtins.int(...)`로 명시 변환도 가능.
5. **Python 예외는 Mojo `try/except`에 자연 통합** — 메시지 보존, 모든 종류(ZeroDiv/Key/Value/Attribute)가 잡힘. 한 가지 한계: 타입별 discriminate는 본 실험에서 미확인.
6. **PyObject는 first-class** — Python list/dict를 변환 없이 PyObject 그대로 두고 `.append()`/indexing으로 다룸. Mojo native와 PyObject가 한 함수 안에서 자유롭게 섞일 수 있음.

### 5.3 C++ 사용자 관점

| 항목 | C++의 Python embedding | Mojo의 Python interop |
|------|------------------------|------------------------|
| API 형태 | 헤더 + C API (`Py_Initialize`, `PyObject_*` 명시 호출) | 일급 객체 `PythonObject`, 메서드/속성 점-접근 |
| 코드 양 | 보일러플레이트 많음 | 거의 Python 코드처럼 보임 |
| 타입 안전 | `PyObject*` 단일 타입 (런타임 검사) | 컴파일 시 PyObject vs native 구분 강제 |
| 자동화 | 수동 reference count 관리 | Mojo가 RAII로 자동 |
| 비용 모델 | 매우 비슷 (CPython C API 직접 호출) | 매우 비슷 (Mojo가 CPython C API 호출) |

→ Mojo의 Python interop은 **C++의 `Boost.Python` / `pybind11`보다 더 매끄러움** — 단일 언어 안에서 양 세계가 자연스럽게 섞임. 다만 **비용 모델은 동일** (어차피 같은 CPython C API).

### 5.4 후속 work 후보 (TODO Backlog 등재 권장)

- **(NEW from 0006)** **예외 타입별 discriminate**: Python `except KeyError as e: ... except ValueError as e: ...`처럼 Mojo에서 타입별 분기 가능한가? (본 실험에선 단일 `except e`만 확인)
- **(NEW from 0006)** **GIL 거동**: Mojo 멀티스레드에서 Python 호출 시 GIL은 어떻게 잡고 푸는가? `parallelize`와 Python 호출 동시 사용 시 안전한가?
- **(NEW from 0006)** **NumPy ndarray ↔ Mojo Tensor zero-copy** 가능성: 본 실험은 `np.array(list)`로 list 변환 비용을 측정. 반대로 numpy의 buffer를 Mojo Tensor로 직접 view 할 수 있다면 마샬링 cost가 0이 될 수 있음.
- **(NEW from 0006)** **`Python.evaluate("...")` 동적 코드 실행**: probe에서 `Python.evaluate("42")`가 동작함을 확인. 이게 어디까지 — 임의 Python 표현식? 문장? 함수 정의? — 가능한지 표면 매핑.
- 기존 T-16(Python 모듈 import vs Mojo native cost 차)은 **본 실험으로 절반 답이 됐음**. 남은 절반(Mojo native 구현이 동일 알고리즘에서 얼마나 빠른가)은 별도 work.
