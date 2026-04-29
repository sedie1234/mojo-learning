# Mojo 학습 워크스페이스

C++ 사용자 관점에서 Mojo 0.26을 직접 만져보며 정리한 개인 실험 공간. 모든 실험은 (1) 작은 코드, (2) 측정값 또는 컴파일 에러 캡처, (3) 5섹션 정형 로그로 영구화되도록 만들었다.

## 실험 환경

| 항목 | 값 |
|------|-----|
| OS | Ubuntu 24.04.4 LTS, kernel 6.17.0-22-generic |
| CPU | x86-64, 16 cores |
| RAM | 14 GiB |
| Python | 3.12.3 (`python3 -m venv` 사용) |
| g++ | 13.3.0 |
| **Mojo** | **0.26.2.0 (d627decc)** |
| **modular 패키지** | **26.2.0** (Mojo 컴파일러 + MAX 런타임 + transformers/numpy 등 ~80 의존성) |
| 설치 위치 | `<workspace>/.venv/` (격리, 약 2.0 GB) |

## 설치 (재현)

```bash
# 1. 프로젝트 루트에서
cd <repo>
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install modular            # Mojo + MAX + ~80 deps, 약 2.0 GB

# 2. 동작 확인
mojo --version                 # → Mojo 0.26.2.0 (d627decc)
which mojo                     # → <repo>/.venv/bin/mojo (201 byte Python wrapper)

# 3. hello world
cd experiments/0003-mojo-install
mojo run hello.mojo
mojo build hello.mojo -o hello && ./hello
```

설치 방식 비교 — magic(curl-pipe) 대신 venv를 채택한 이유는 `log/0003-mojo-install.md` 참고. 요약: 학습 단계에서는 venv의 격리성·투명성이 우위. MAX/GPU 단계에서 magic 재평가.

## 디렉토리 구조

```
<repo>/
├── README.md                  ← 이 파일
├── CLAUDE.md                  ← Claude Code(AI 페어 프로그래밍) 운영 규칙
├── TODO.md                    ← 진행/예정/Backlog/완료 work 목록
├── log/                       ← 모든 work의 영구 기록 (5섹션 정형)
│   ├── README.md              ← 인덱스 (시간 역순 표)
│   └── NNNN-<slug>.md         ← 개별 work 로그
├── experiments/               ← 실제 실행 코드 (work별 폴더)
│   └── NNNN-<slug>/
│       ├── README.md
│       ├── *.mojo / *.py      ← 실험 코드
│       ├── run.sh / results.log (선택)
│       └── trace.log          (선택, 캡처된 실행 출력)
├── docs/                      ← (정제된 개념 노트, 현재 비어있음)
└── .claude/                   ← AI 페어 프로그래밍용 sub-agent + skill 정의
    ├── agents/                ← orchestrator/experimenter/log-keeper 3-agent
    └── skills/work-log/       ← 5섹션 로그 작성 skill
```

## work 1줄 요약 (시간 역순)

| # | 제목 | 한 줄 핵심 |
|---|------|-----------|
| 0008 | Trait + Python interop vs Mojo native cost | trait API(0.26: `T: A & B`, trait 상속), Python pure ↔ Mojo native **100×** 차, NumPy ↔ native 1~9× |
| 0007 | Language Fundamentals 5건 | 0.26 키워드 변경 (`inout→mut`/`owned→var`/`borrowed→read`/`let` 폐기) + struct/numeric/ownership |
| 0006 | Python interop 표면 + 비용 측정 | cold start 17~39ms, warm sub-μs, NumPy 변환 16~22 ns/elem, 타입 변환 비대칭 |
| 0005 | 패키지/모듈 구조 — fs 탐사 | `mojo` CLI는 201B Python wrapper, `os.execve`로 135MB ELF로 점프, stdlib = 25개 `.mojopkg` |
| 0003 | Mojo 설치 + hello world AOT | venv + `pip install modular` (2.0 GB), AOT 산출물은 동적 링크 (44 KB), GPU 백엔드 항상 동봉 |
| 0001 | 워크스페이스 셋업 | 3-agent + work-log skill + 디렉토리 구조 정착 |

> **work 번호의 빈 칸** — 워크스페이스 인프라/외부 도구 통합 메타 work 일부는 본 공개 저장소에서 생략됨. 학습 콘텐츠 자체에는 영향 없음.

각 work의 자세한 5섹션 분석은 `log/NNNN-*.md`. 실행 코드는 `experiments/NNNN-*/`.

## 모든 work에서 발견된 핵심 인사이트 (10개)

### Mojo 컴파일러/런타임 구조
1. **`mojo` CLI는 201바이트 Python wrapper** — `os.execve`로 `modular/bin/mojo` (135MB ELF)에 process replacement. fork 없음.
2. **stdlib = 25개 `.mojopkg`** (pre-compiled binary, magic = `MPKG\x01...`). `.mojo` 소스는 0개.
3. **모듈 검색 경로** = `MODULAR_MOJO_MAX_IMPORT_PATH` env + `mojo build -I <PATH>` (C++과 같은 옵션명). `__init__.mojo` = Python `__init__.py` 동일 컨벤션.
4. **prelude/builtin은 컴파일러 ELF에 내장** — 별도 .mojopkg 없음. `--disable-builtins` 옵션 존재.
5. **GPU 백엔드(`libNVPTX.so`)가 항상 동봉** — CPU-only 머신에서도. "단일 컴파일러 / 다중 타깃" 철학.

### 언어 (0.26 시점)
6. **소유권 키워드 단순화**: `read`/`mut`/`var` + `^` transfer. 이전 `borrowed`/`inout`/`owned`는 모두 폐기. `let`도 폐기.
7. **자동 copy 거절 default** — ImplicitlyCopyable trait 미준수 시 `var p2 = p1`이 컴파일 에러. `.copy()` 또는 `^` 명시 강제 (= C++ `= delete` 패턴).
8. **수치 타입 = C `<cstdint>`와 1:1** + 정의된 wrap overflow (signed/unsigned). C++23 이전의 signed UB 회피.

### Python interop
9. **Python pure ↔ Mojo native = ~100× 차** (XOR over 10M elements 측정). 인터프리터 자체의 비용. **Mojo가 Python을 빠르게 만들지 않는다** — Python 핫스팟은 Mojo native로 다시 작성해야 가속.
10. **NumPy/C-impl 호출은 거의 native급** — interop 추가 비용은 함수 호출 1회 fixed overhead만. 큰 데이터에선 보이지 않음. 즉 **NumPy/PyTorch 그대로 호출 OK, 순수 Python 알고리즘은 재작성**.

## 학습자 관점 (C++ 사용자)

| 영역 | C++의 가장 가까운 것 | Mojo의 차이 |
|------|---------------------|-------------|
| 함수 시그니처 | `void f(T const&)` 등 | `read`/`mut`/`var` 명시, `raises` 명시 |
| struct | C++ struct + RAII | + 자동 copy 거절 default (안전 강화) |
| 수치 타입 | `<cstdint>` | 그대로 + wrap overflow 정의 |
| template | `template<typename T>` | `fn f[T: Trait](x: T)` (trait 제약 명시) |
| concept (C++20) | `concept T = requires(...)` | `trait T: fn m(self): ...` |
| `std::move` | manual | postfix `^` 연산자 |
| Python embedding | pybind11 보일러플레이트 | first-class `PythonObject`, 점-접근 |

**총평**: Rust borrow checker의 *학습 곡선이 완만한 버전* + C++ const/move semantics 직관 그대로 + Python interop이 매끄러움. 타입 안전 + 명시성 + 시스템 성능을 한 언어에서.

## 학습/실험 워크플로우

이 저장소는 **Claude Code(AI 페어 프로그래밍 도구)** 와 함께 만들어졌다. 워크스페이스에는 3-agent 시스템이 정의되어 있어:

- `mojo-orchestrator`: 사용자 목표 → work으로 분해 → experimenter 디스패치
- `mojo-experimenter`: 단일 work 실행 (코드 작성·실행·결과 캡처)
- `mojo-log-keeper`: `work-log` skill로 5섹션 정형 로그 작성

다른 사람이 이 저장소를 활용한다면:
- `log/`만 읽어도 학습 흐름 전체를 따라갈 수 있음 (각 로그가 5섹션 self-contained)
- `experiments/NNNN-*/`의 코드는 그대로 `mojo run`으로 재현 가능
- `CLAUDE.md`는 AI 도구가 이 워크스페이스에서 어떻게 일해야 하는지의 운영 규칙 (필요 시 무시 가능)

## 참고

- **Modular 공식 문서**: https://docs.modular.com/mojo
- **Mojo 언어 레퍼런스** (0.26 시점): 본 저장소의 keyword 변경 표(`log/0007`)가 실제 도구 동작 기준 검증됨

## 학습 상태 (2026-04-29 종결판)

⏸️ **본 머신 (CPU only) 기준 학습 cycle 일시 종료**. GPU 확보 시 재개 예정.

- **검증 완료**: Mojo 언어 자체 (work 0009-0013, NumPy MKL과 동급 SIMD/parallelize), Python interop 비용 모델 (work 0006/0008/0010), 0.26 키워드 표면 (work 0007), MAX 0.26 import 매트릭스의 한계 (work 0014/0015 — 부정 결과)
- **미검증 (GPU 필요)**: MAX Serve LLM serving, Mojo GPU 커널, GPU matmul 비교, Qwen3-4B GPU 추론
- **재개 trigger**: GPU 확보 / MAX 0.27+ 릴리스 / 새 op 개발 필요성 발생

다시 돌아올 때 first action: `cat docs/performance-summary.md` + Plane workspace `mojo` project의 정리 노트 7페이지 훑기.

## 라이선스

개인 학습용. 자유롭게 복제/수정. 한국어 응답 전제로 작성됨.
