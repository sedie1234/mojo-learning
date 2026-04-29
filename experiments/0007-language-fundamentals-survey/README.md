# 0007 — Language Fundamentals 5건 묶음

work 0007의 코드. T-5/6/7/8/9 5개 issue를 한 번에.

| 파일 | issue | 다루는 것 |
|------|:-----:|----------|
| `01_fn_vs_def.mojo` | T-5 | fn vs def — 타입 강제, raises, 시맨틱 |
| `02_struct_vs_class.mojo` | T-6 | Mojo struct(value) vs Python class(reference) |
| `03_numeric_types.mojo` | T-7 | Int/Int8~64, UInt*, Float16/32/64, overflow |
| `04_var_let.mojo` | T-8 | var (let은 0.26에서 제거) |
| `04b_let_compile_error.mojo` | T-8 | `let` 사용 시 컴파일 에러 직접 검증 (의도된 실패) |
| `05_ownership.mojo` | T-9 | read(default) / mut / var + `^` transfer |
| `05b_no_transfer.mojo` | T-9 | `^` 없이 var 호출 시 거부 (의도된 실패) |

## 재현

```bash
cd /home/hwan/workspace/mojo
source .venv/bin/activate
cd experiments/0007-language-fundamentals-survey

# 정상 실행 5개
for f in 0[1235]_*.mojo 04_*.mojo; do echo "== $f =="; mojo run $f; done

# 의도된 컴파일 에러 2개 (메시지만 보면 됨)
mojo run 04b_let_compile_error.mojo
mojo run 05b_no_transfer.mojo
```

상세는 `../../log/0007-language-fundamentals-survey.md`.
