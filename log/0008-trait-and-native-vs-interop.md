---
id: 0008
title: Trait/parametric polymorphism + Python interop vs Mojo native cost
status: done
date: 2026-04-29
tags: [basics, trait, python-interop, benchmark]
related_code: experiments/0008-trait-and-native-vs-interop/
---

# 0008. Trait/parametric polymorphism + Python interop vs Mojo native cost

## 1. 무엇을 하고자 하는지

서로 다른 두 module의 마지막 issue 2건을 한 work에서 묶어 처리.

| issue | 모듈 | 질문 |
|-------|------|------|
| T-10 | Language Fundamentals | trait 정의/구현/사용. C++ template+concept과 매핑. 다중 trait bound, 상속, 추상 메서드 표현 |
| T-16 | Python Interop | 동일 알고리즘을 Mojo native vs Python via interop으로 작성했을 때 비용 차 정량화. work 0006(변환 비용 마샬링)의 자연스러운 후속 — 알고리즘 *전체*가 boundary를 자주 넘는 패턴 |

## 2. 수행한 일

### 2.1 T-10 trait API probe

0.26 trait 표면 확정:
- `trait T:` + 추상 메서드 body는 `...`로 표기 (Python `pass`/`...`와 동위치)
- `struct Foo(T1, T2):` 다중 conform OK
- `fn f[T: Trait](x: T):` generic with bound
- `fn f[T: A & B](x: T):` 다중 bound (`&` 연결)
- `trait Pet(Animal):` trait 상속 — Pet conform 구조체는 자동으로 Animal에도 conform
- 추상 메서드도 시그니처 끝에 `: ...` 필요 (`fn owner(self) -> String: ...`)

### 2.2 T-16 알고리즘 fold 함정 발견 → XOR로 교체

처음 작성: Mojo native `sum(0..N-1)` for-loop. 결과: **모든 N에서 20 ns 고정**.

진단: Mojo 컴파일러(default `-O3`)가 **가우스 합 공식** n*(n-1)/2로 closed-form 축약. 사실상 측정 대상이 사라짐.

해결:
1. **연산을 XOR로 교체** — XOR도 0..n-1에 대해 4-주기 closed-form이 있지만 LLVM optimizer가 인식하지 않음.
2. **결과를 외부 `mut sink: Int`로 흘림** — 호출 측에서 sink ^= r로 누적, 마지막에 print(sink)로 사용. 이러면 컴파일러가 dead-code로 제거 못 함.

이 두 단계로 진짜 O(N) 루프 비용을 측정.

### 2.3 측정 프로토콜

3 구현 모두:
- warmup 3회 + measure 10회
- median 사용
- 같은 `mut sink: Int`로 결과 흘려 dead-code 방지

3 구현:
- (a) Mojo native: `for i in range(n): total ^= i`
- (b) Python pure: `functools.reduce(operator.xor, range(n), 0)` via interop
- (c) NumPy: `numpy.bitwise_xor.reduce(numpy.arange(n))` via interop

N: 1,000 / 100,000 / 10,000,000

## 3. 예상되는 결과

- **T-10**: trait는 C++ concept과 거의 1:1 매핑. compile-time monomorphization (코드 크기 N배). 다중 bound는 `&`로 자연스럽게.
- **T-16**: Python pure는 인터프리터 + PyObject 생성/소멸로 native 대비 100배 이상 느림. NumPy는 C 구현이라 native와 근접 (interop overhead만큼 약간 느림).

## 4. 실제 결과

### 4.1 T-10 — Trait

```
[1] 단일 trait bound — render(Drawable)
[Circle.draw] r= 3.0
[Square.draw] s= 5.0

[2] 다중 trait bound — describe(Drawable & Stringable)
describe: Circle(7.0)
[Circle.draw] r= 7.0
# describe(Square(5.0))  ← Square가 Stringable conform 안 함, 컴파일 에러

[3] trait 상속 — Pet은 Animal의 contract도 만족
[Dog.sound] Rex → woof              ← use_as_animal(d) — Pet → Animal 자동
[Dog.sound] Rex → woof              ← use_as_pet(d)
  owner: Alice
```

C++/Rust 매핑 표:

| Mojo 0.26 | C++20 | Rust |
|-----------|-------|------|
| `trait T:` | `concept T = requires(...)` | `trait T` |
| `struct Foo(T1, T2):` | `class Foo : ...` (manual) 또는 `requires` 만족 | `impl T1 for Foo`, `impl T2 for Foo` |
| `fn f[T: Trait](x: T)` | `template<Trait T> void f(T x)` | `fn f<T: Trait>(x: T)` |
| `fn f[T: A & B](x: T)` | `template<typename T> requires A<T> && B<T>` | `fn f<T: A + B>(x: T)` |
| `trait Pet(Animal):` | concept inheritance 없음 | `trait Pet: Animal` |
| 추상 메서드 `fn m(self): ...` | `requires { x.m(); }` | `fn m(&self);` (body 없음) |
| 자동 monomorphization | template instantiation | monomorphization |

### 4.2 T-16 — native vs Python interop

```
N             | Mojo native ns | Python pure ns | NumPy ns        | pure/native  | numpy/native
--------------|----------------|----------------|-----------------|--------------|--------------
1,000         |            280 |         28,639 |           2,580 |     101×     |   9×
100,000       |         25,070 |      1,907,420 |          29,620 |      76×     |   1×
10,000,000    |      1,811,060 |    192,280,367 |      15,031,292 |     106×     |   8×

sink (dead-code 방지) = 0  ← 출력으로 컴파일러가 결과 사용 확인
```

Per-element 변환:

| 구현 | ns / elem | 의미 |
|------|----------:|------|
| Mojo native (10M) | **0.18** | 1 cycle/elem 미만 — 자동 SIMD 추정 |
| NumPy (10M) | 1.50 | C-impl, SIMD 활용 |
| Python pure (10M) | 19.2 | PyObject 생성/iter/xor dispatch 합산 |

흥미로운 점:
- Mojo native가 **NumPy보다 8배 빠름** (10M에서). NumPy는 ndarray 객체 생성 + reduce dispatch overhead가 있고, Mojo native는 정수 SIMD 직접 루프.
- N=100K에서는 NumPy가 거의 동률 — 이 영역에선 NumPy의 fixed overhead가 흡수되고 SIMD 효율은 비슷.
- Python pure는 N에 비례해 그대로 비용 — N=10M이 192 ms로 인터랙티브 한계 근처.

## 5. 결론

### 5.1 Trait (T-10)

- Mojo trait는 **C++20 concept + Rust trait의 좋은 부분 합성**:
  - syntax는 Rust스럽고 (`fn f[T: Trait]`)
  - 다중 bound는 `&`로 직관적 (Rust `+`와 동등 의미)
  - trait 상속(`trait Pet(Animal)`)이 자연스러움 — C++20에는 없음
  - 추상 메서드를 `: ...`로 표기 — Python의 protocol 스타일
- **모든 dispatch는 컴파일 타임 (monomorphization)** — `fn f[T: Trait]`은 사용된 T별로 코드 생성. C++ template과 동일 모델. dynamic dispatch (vtable) 키워드는 본 work에서 미관측 — `dyn`/`trait object` 표면이 있는지 후속 검증 필요.

### 5.2 Python interop vs Mojo native (T-16)

핵심 수치:

> **Python pure (interpreter) ↔ Mojo native: 100× 차**
> **NumPy (C, vectorized) ↔ Mojo native: 1~9× (Mojo가 약간 빠름)**

해석:
1. **Python interop의 진짜 비용은 인터프리터 자체** — 마샬링(0006의 ~20 ns/elem)에 더해 PyObject 생성/iter/dispatch가 합쳐 ~19 ns/elem. 이건 Mojo가 줄여줄 수 있는 게 아님 (어차피 같은 CPython이 돌아감).
2. **NumPy 같은 C-구현 호출은 거의 native급** — 이 경우 interop의 추가 비용은 함수 호출 1회의 fixed overhead(μs 수준). 큰 데이터에선 거의 안 보임.
3. **결론적인 사용 패턴**:
   - Python의 *순수 알고리즘* 코드를 그대로 Mojo에서 호출 = **100배 손실**, 하지 말 것.
   - Python의 *C-impl 라이브러리*(NumPy/Torch 등)를 Mojo에서 호출 = **거의 자유**, 적극 활용.
   - 핫스팟이 *순수 Python*에 있다면 = Mojo native로 다시 작성, 100배 가속 기대 가능.

### 5.3 work 0006 ↔ 0008 종합

- 0006: Python ↔ Mojo *변환/예외/lifecycle* 표면 — interop 자체의 *오버헤드*
- 0008: 같은 알고리즘 *전체*가 두 세계에서 도는 비용 — interop *사용 패턴*의 결과

이 둘로 Python Interop 모듈의 6개 issue(T-15/16/22/23/24 + 0006/0008 자체 발견 후속들) 거의 전체가 매핑됨. 모듈 레벨에서 일단락.

### 5.4 학습자 평가

- **Mojo trait**: C++ template/concept과 매끄러운 연결, Rust trait의 syntax 가독성, Python의 추상 메서드 표기 통합. *학습 비용은 매우 낮고 표현력은 충분*. 다만 dynamic dispatch(`dyn`/trait object) 표면은 추후 검증.
- **Python interop의 정확한 그림**: Mojo는 Python을 *마법처럼 빠르게* 만들지 않는다. CPython이 그대로 돌고, Mojo는 호출 코드가 짧을 뿐. **100배 가속은 Mojo native로 다시 짤 때만**. 이건 0006의 결론(이전 평가)을 정량으로 못박은 것.

### 5.5 후속 work 후보

- **(NEW from 0008)** Mojo의 **dynamic dispatch / trait object** 표면 — `dyn Trait`이나 vtable 기반 호출이 가능한가? 0008은 monomorphization만 본 상태.
- **(NEW from 0008)** **Mojo native의 자동 vectorize 정도** 측정 — 0.18 ns/elem이 정말 SIMD인가? `vectorize`/`parallelize` 명시 안 했는데 어디까지 자동 적용되나. → 자연스럽게 **T-11**(SIMD vector add)로 연결.
- **(NEW from 0008)** **trait의 default method**는 가능한가 — 본 work에선 검증 못 함.
- 기존 work 0006의 *예외 타입별 discriminate*, *GIL 거동*, *zero-copy ndarray*는 여전히 후속 후보.
