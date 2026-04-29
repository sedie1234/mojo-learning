# 0005 — Mojo 패키지/모듈 구조 추적

**무엇을 하는 폴더인가**: Mojo 컴파일러/stdlib/Python interop이 파일시스템 어디에 어떤 형태로 있는지를 *코드 실행 없이* `ls`/`file`/`cat`/`grep`/`find`/`xxd`만으로 추적한 결과.

## 따라 하기

```bash
bash run.sh        # 12단계 전부 차례로
bash run.sh 5      # STEP 5만 (lib/mojo/의 25개 .mojopkg 보기)
```

각 step은 명령 + 출력 + 한 줄 결론이 함께 나온다. trace.log에 누적된 원본 캡처도 있음.

## 12단계 개요

| # | 무엇을 보는가 | 핵심 결론 |
|---|---|---|
| 1 | `.venv/bin/mojo` | 201바이트 Python 스크립트 (wrapper) |
| 2 | `modular/` 톱레벨 | bin/(293M) + lib/(835M)만 |
| 3 | `modular/bin/` | mojo(135M ELF), lld(110M), lldb-*, llvm-symbolizer 등 |
| 4 | `modular/lib/` | 10개 .so 런타임 + 디렉토리들 |
| 5 | `modular/lib/mojo/` | **25개 .mojopkg = stdlib 전부 (소스 0개)** |
| 6 | .mojopkg 매직 | ASCII "MPKG" + 0x01 |
| 7 | `mojo/_entrypoints.py` | os.execve로 ELF에 process replacement |
| 8 | `mojo/run.py` | 4개 env 주입 (DRIVER_PATH, IMPORT_PATH, ...) |
| 9 | `mojo/_package_root.py` | wheel/conda/venv 검색 알고리즘 |
| 10 | `mojo build/package --help` | `-I <PATH>` import 경로, `__init__.mojo` 패키지 마커 |
| 11 | `mojo/importer.py` | Python에서 .mojo 폴더 import 시 동적 컴파일 |
| 12 | `strings modular/bin/mojo` | prelude/builtin은 컴파일러 ELF 내장 |

## 산출물

- `run.sh` — 재실행 가능한 12단계 추적 스크립트
- `trace.log` — 본 work 진행 시 캡처된 원본 stdout (참고용)

자세한 5섹션 분석은 `../../log/0005-package-structure.md`.
