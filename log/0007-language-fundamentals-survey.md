---
id: 0007
title: Language Fundamentals 5건 (fn vs def, struct, numeric, var, ownership)
status: done
date: 2026-04-29
tags: [basics, language-fundamentals, ownership, types]
related_code: experiments/0007-language-fundamentals-survey/
---

# 0007. Language Fundamentals 5건 (fn vs def, struct, numeric, var, ownership)

## 1. 무엇을 하고자 하는지

Mojo 언어 본체의 5가지 기초 영역을 한 work으로 묶어 파악. C++ 사용자 관점에서 Mojo의 시스템 측면(타입·메모리·소유권)이 어떻게 모델링되는지 + Python 진영과의 차이.

| issue | 질문 |
|-------|------|
| T-5 | `fn`과 `def`의 차이 — 타입 강제, raises 처리, 컴파일/런타임 검사 시점 |
| T-6 | `struct`(Mojo) vs Python `class`의 시맨틱 차이 (value vs reference, copy/move 호출 시점) |
| T-7 | 수치 타입 표면 — `Int`, `Int8/16/32/64`, `UInt*`, `Float16/32/64`. C++ stdint와 매핑, overflow 거동 |
| T-8 | 가변성 모델 — `var` vs `let`(이전), 파라미터 modifier로 표현되는 immutability |
| T-9 | 소유권/borrow — `read`/`mut`/`var` 파라미터 modifier, `^` transfer, ImplicitlyCopyable trait |

## 2. 수행한 일

### 2.1 Mojo 0.26 ownership API 사전 probe

이전 문서(0.7~0.13 시절)와 다른 부분을 작은 probe들로 확정:

| 이전 문서 | 0.26 현재 |
|-----------|----------|
| `inout p: T` | `mut p: T` |
| `owned p: T` | `var p: T` |
| `borrowed p: T` 또는 default | `read p: T` 또는 default |
| `let x = 10` | **제거됨** — `var x = 10`만 |
| `__copyinit__(out self, other: Self)` | `__copyinit__(out self, copy: Self)` (이름 강제) |
| `var p2 = p1` (Copyable이면 자동) | **`p1.copy()` 명시** 필요 (ImplicitlyCopyable trait 별도) |
| `def f(...): raise ...` (묵시적 raises) | `def f(...) raises: ...` (명시 필수) |
| `Int(po)` (Python → Mojo) | `Int(py=po)` (키워드 only — work 0006에서 발견) |

### 2.2 5+2개 실험 (정상 5 + 의도된 컴파일 에러 2)

`experiments/0007-language-fundamentals-survey/`:
- 정상 실행: `01_fn_vs_def.mojo`, `02_struct_vs_class.mojo`, `03_numeric_types.mojo`, `04_var_let.mojo`, `05_ownership.mojo`
- 의도된 실패: `04b_let_compile_error.mojo`(let), `05b_no_transfer.mojo`(implicit copy 거부)

### 2.3 5 issue를 한 번에 started → completed로

본 work에서 5개 영역을 모두 다뤘으므로 한 번에 정리.

## 3. 예상되는 결과

- **T-5**: fn은 strict, def는 더 lenient — 타입 추론 또는 dynamic. raises 처리에 차이.
- **T-6**: Mojo struct = C++ struct value semantics, Python class = reference semantics. 대입 시 copy 발생 시점 정확히 보일 것.
- **T-7**: C++ stdint 그대로 매핑, overflow 동작도 같음 (wrap or UB).
- **T-8**: `let`은 일부 버전에 있었고 `var`로 통일됐는지 확인.
- **T-9**: borrowed/inout/owned 키워드 이름이 무엇인지, 컴파일 시점 use-after-move 거부 확인.

## 4. 실제 결과

### 4.1 T-5 — fn vs def

```
fn add_fn(3, 4) = 7
def add_def(3, 4) = 7
caught from fn:  div by zero (fn raises)
caught from def: div by zero (def + raises)
```

핵심 발견:
- **0.26에서 def도 `raises` 명시 필수**. 이전 버전의 "def는 묵시적 raises" 설명은 **현재 잘못됨**.
- 두 키워드의 차이는 좁아졌고, 본질은:
  - `fn`: **모든 인자/반환에 타입 명시 권장** (없으면 추론), "엄격" 모드
  - `def`: **타입 생략 가능** (Python-호환 위해), 이 경우 PythonObject로 처리되거나 동적
- 성능은 동일 (둘 다 같은 컴파일러로 AOT, 타입이 같으면 동일 codegen)

### 4.2 T-6 — struct vs class

```
[Mojo struct]
  p1 = Point(10, 20)
    [Point.__copyinit__ x= 10 y= 20]   ← .copy() 시 호출
  var p2 = p1.copy()
  p2.x = 999 후:
    p1.x = 10  (영향 없음 ← value)
    p2.x = 999

[Python class — interop]
  pp1 = PyPoint(10, 20)
  pp2 = pp1                             ← reference 복사
  pp2.x = 999 후:
    pp1.x = 999  (같이 바뀜 ← reference)
    pp2.x = 999
```

핵심 발견:
- **Mojo struct는 정확히 C++ struct + RAII 모델** — 대입 시 `__copyinit__` 호출, 별개 인스턴스.
- **0.26 변경**: `var p2 = p1`가 자동 copy 안 함. ImplicitlyCopyable trait 미준수 → **`p1.copy()` 명시** 또는 `^` transfer 강제. 이건 *의도된 안전성 강화* — 큰 객체 의도치 않은 copy 방지.
- Python class는 reference semantics — Mojo에서도 PyObject로 다룰 때 그 의미론을 그대로 받음. C++ 사용자가 `std::shared_ptr<Point>` 다루는 느낌.
- `__copyinit__(out self, copy: Self)` 인자 이름 **`copy` 강제** (`other` 쓰면 컴파일 에러).

### 4.3 T-7 — 수치 타입

```
Int8.MIN  = -128            MAX  = 127
Int16.MIN = -32768          MAX = 32767
Int32.MIN = -2147483648     MAX = 2147483647
Int64.MIN = -9223372036854775808  MAX = 9223372036854775807
UInt8.MIN = 0               MAX = 255
Int.MIN   = -9223372036854775808  MAX = 9223372036854775807    ← x86_64에서 64-bit

Int8(127) + Int8(1) = -128                 ← signed wrap (2의 보수)
UInt8(255) + UInt8(1) = 0                  ← unsigned wrap
1/3 in Float16 : 0.33325195
1/3 in Float32 : 0.33333334
1/3 in Float64 : 0.3333333333333333
```

핵심 발견:
- **C++ stdint와 1:1 매핑**: `Int32` ≈ `int32_t`, `Float64` ≈ `double` 등. 직관 그대로.
- **`Int`는 platform-dependent** — `intptr_t`/`ssize_t`와 같은 위상 (x86_64에서 64-bit).
- **Overflow는 정의된 wrap** (signed/unsigned 모두). C++23 이전의 signed UB와 다른 점이 학습 가치.
- **`sizeof`/`bitwidthof`는 0.26에서 외부 노출 안 됨** (probe 결과 `std.sys.info`/`std.sys`/`std.intrinsics` 어디에도 없음). 폭 확인은 `MIN/MAX`로 우회 가능. 향후 work 후보로 등재할 만함.

### 4.4 T-8 — var vs let

```
[var — 일반 가변 변수]
  var x = 10  → 10
  x = 20      → 20 (재할당 OK)

[let] ← 직접 검증 (04b_let_compile_error.mojo):
  error: use of unknown declaration 'let'
```

핵심 발견:
- **`let` 키워드는 0.26에서 완전 제거**. immutable 선언 문법은 **언어에서 빠짐**.
- immutability는 두 가지로 표현:
  1. `var`로 선언 후 *의도적으로 미재할당* (관습적, 컴파일러 강제 X)
  2. **함수 파라미터 modifier로 표현**: `fn f(p: T)` 또는 `fn f(read p: T)` → 함수 안에서 `p` 변경 불가
- 이 디자인은 **scope 단위 immutability를 변수 선언이 아닌 *호출 경계*에서 강제**하는 모델 — Rust의 `&T`/`&mut T` 분리에 가까움.
- 추가 발견: `[N: Int]` (대괄호) = 컴파일 타임 parameter, `(N: Int)` (소괄호) = 런타임 인자. C++ template parameter vs function arg 동일 분리.

### 4.5 T-9 — 소유권 / borrow checker

```
[1] read borrow]
  observe(b)        ← default = read, copy 안 일어남
  observe_explicit(b)  ← read 명시
  b는 여전히 살아있음, x = 7

[2] mut borrow]
  modify(b)         ← inout 키워드 폐기, mut가 새 이름
  b.x = 107

[3] var consume + ^ transfer]
  consume(b^)       ← 명시적 transfer. ^ 없으면 컴파일 거부
  consume took x = 107
  (b는 이후 사용 불가)

[4] 05b_no_transfer.mojo (의도된 실패):
  consume(b)        ← ^ 없음
  → error: value of type 'Box' cannot be implicitly copied,
           it does not conform to 'ImplicitlyCopyable'
  → note: consider transferring the value with '^'
  → note: you can copy it explicitly with '.copy()'
```

핵심 발견:
- **3개 modifier로 단순화**: `read` (default), `mut`, `var`. 이전 `borrowed/inout/owned` 3중 키워드보다 짧고 의미 명확.
- **`^` transfer 연산자**가 명시적 move를 표현 (= Rust `std::move`/암묵적 move 위치 결정).
- **컴파일 시점 use-after-move 거부**: var 파라미터 호출 후 원본 사용은 컴파일 에러. Rust borrow checker와 동일 위상.
- **ImplicitlyCopyable trait**: Copyable과 분리됨 — Copyable은 *명시적 `.copy()` 가능*, ImplicitlyCopyable은 *대입에서 자동 copy 허용*. 큰 객체에 ImplicitlyCopyable을 안 붙이면 의도치 않은 cloning 방지. 이건 **C++의 `= delete` 패턴이 자동 적용**되는 셈.

## 5. 결론

### 5.1 5개 영역 한눈 요약 (C++ 비교 매핑)

| 영역 | Mojo 0.26 | 가장 가까운 C++ 개념 |
|------|-----------|----------------------|
| 함수 키워드 | `fn`(strict types) / `def`(Python-compat, 타입 생략 가능) | `void f()` 정해진 시그니처 vs `auto` 추론 |
| 예외 | `raises` 명시 필수 (fn/def 모두) | `noexcept` 반대 (예외 던질 수 있음 명시) |
| struct | value semantics, `__copyinit__/__moveinit__` 호출 시점 명시 | C++ struct의 copy/move 생성자 |
| numeric | `Int8/16/32/64`, `UInt*`, `Float16/32/64`, `Int`(plat) | `<cstdint>` + `intptr_t` |
| overflow | wrap (정의됨) | C++23 이후 signed wrap 정의됨 |
| 변수 가변성 | `var`만 (let 폐기), 호출 경계에서 mod | `auto x` + 파라미터 `const T&`/`T&`/`T` |
| 소유권 | `read`/`mut`/`var` + `^` | `T const&`/`T&`/`T&&` + `std::move` |
| 자동 copy 차단 | ImplicitlyCopyable trait 미준수 | `= delete` 한 copy 생성자 |

### 5.2 학습 인사이트 7개

1. **Mojo 0.26은 이전 버전과 키워드 차이가 크다** — `inout`/`owned`/`borrowed`/`let`은 모두 제거 또는 rename. 인터넷 문서 그대로 따라하면 컴파일 에러. 본 work이 가장 중요하게 한 일은 **현재 시점의 정확한 키워드를 검증**.
2. **fn vs def 차이는 좁아짐** — 0.26에서 raises 처리가 통일됐고, 둘 다 같은 컴파일러로 처리. 차이는 *타입 명시 강제 강도*만 남음.
3. **struct는 정확히 C++ value-type model + Rust 안전성**. `__copyinit__` 호출 시점이 print로 추적 가능하므로 디버깅 쉬움.
4. **자동 copy 거절이 default**. ImplicitlyCopyable을 안 붙이면 큰 객체가 의도치 않게 깊은 복사 안 됨 → Rust 식 zero-cost abstraction 정신.
5. **소유권은 Rust 모델의 *좀 더 단순한* 버전**. lifetime 표기는 명시적이지 않고 컴파일러가 추론 (probe에서 lifetime 키워드 미관측). Rust보다 학습 곡선이 완만할 수 있다는 첫 인상.
6. **immutability 표현 위치 이동**: 변수 선언(`let`)에서 *호출 경계*(`fn f(p: T)`/`fn f(read p:)`)로. *언어 표면이 줄어든* 합리적 디자인 — 같은 의미를 두 곳에서 표현하던 중복 제거.
7. **Mojo overflow가 정의된 wrap**: C++23 이전의 signed UB와 다름 — 코드가 의도치 않은 최적화로 깨질 위험이 적음. 학습/실험에는 유리.

### 5.3 후속 work 후보 (TODO Backlog 등재 권장)

- **(NEW from 0007)** **`sizeof`/`bitwidthof` 정식 노출 위치 찾기** — 0.26에서 `std.sys.info`/`std.sys`/`std.intrinsics` 어디에도 없음. internal API에 있는지, mojopkg dump로 확인 필요.
- **(NEW from 0007)** **Mojo `class` 등장 여부** — 현재는 struct만, class가 향후 추가될 가능성? Python compat 측면에서 class도 필요할 텐데 로드맵 확인.
- **(NEW from 0007)** **lifetime parameter 표면** — Rust 식 `'a`가 Mojo에 있는가? `ref`/lifetime 어노테이션이 노출되는지.
- **(NEW from 0007)** **`__moveinit__` 거동 직접 추적** — `^` transfer 시 `__moveinit__`이 호출되는지 print로 확인. 0007에서 ImplicitlyCopyable 우회로 다 가지 못함.
- **(NEW from 0007)** **Trait 시스템 깊이** (T-10이 부분 다룸) — Copyable/ImplicitlyCopyable처럼 trait이 행동을 결정함이 본 work에서 부각됨. Trait 정의/구현/dispatch 메커니즘이 다음 work.
- 기존 T-10 (Trait/parametric polymorphism) — 이번 work에서 ImplicitlyCopyable 등을 만나며 자연스럽게 다음 work으로 부각됨.
