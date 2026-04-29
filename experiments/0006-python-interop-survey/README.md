# 0006 — Python interop 표면 + 비용 측정

work 0006의 코드. T-15/22/23/24 4개 issue를 한 번에 다룸.

| 파일 | 다루는 issue | 무엇을 보는가 |
|------|:-----------:|---------------|
| `01_lifecycle.mojo` | T-22 | cold-start vs warm import_module 비용 |
| `02_numpy_cost.mojo` | T-15 | `np.array(list)` 변환 비용 vs 크기 |
| `03_type_conv.mojo` | T-23 | PyObject ↔ Mojo Int/Float64/String/List 양방향 |
| `04_exception.mojo` | T-24 | ZeroDivision/Key/Value/Attribute Error의 Mojo try/except |

## 재현

```bash
cd /home/hwan/workspace/mojo
source .venv/bin/activate
cd experiments/0006-python-interop-survey

# 개별 실행
mojo run 01_lifecycle.mojo
mojo run 02_numpy_cost.mojo
mojo run 03_type_conv.mojo
mojo run 04_exception.mojo

# 또는 일괄 (원본 캡처 → results.log)
for f in 0?_*.mojo; do echo "=== $f ==="; mojo run $f; done
```

자세한 5섹션 분석은 `../../log/0006-python-interop-survey.md`.
