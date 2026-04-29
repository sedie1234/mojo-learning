# 0008 — Trait + Python interop vs Mojo native cost

work 0008 코드. T-10 + T-16 동시 진행.

| 파일 | issue | 다루는 것 |
|------|:-----:|----------|
| `01_trait.mojo` | T-10 | trait 정의, 다중 conform, generic fn 단일/다중 bound, trait 상속 |
| `02_native_vs_interop_sum.mojo` | T-16 | 동일 알고리즘(XOR over 0..N-1)을 Mojo native / Python pure / NumPy 3구현으로 비교 |

## 02 알고리즘 변경 메모

처음엔 sum(0..N-1)이었으나 Mojo 컴파일러가 가우스 합 공식 n*(n-1)/2로 closed-form 축약 → 모든 N에서 native 20 ns 고정 (의미 없는 측정).

→ XOR로 교체. XOR도 4-주기 closed-form이 있지만 LLVM은 인식하지 않음. + 결과를 외부 `mut sink` 파라미터로 흘려 dead-code 제거 방지.

## 재현

```bash
cd /home/hwan/workspace/mojo
source .venv/bin/activate
cd experiments/0008-trait-and-native-vs-interop

mojo run 01_trait.mojo
mojo run 02_native_vs_interop_sum.mojo
```

자세한 5섹션은 `../../log/0008-trait-and-native-vs-interop.md`.
