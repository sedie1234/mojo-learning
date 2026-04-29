# Mojo 학습 워크스페이스

이 디렉토리는 사용자가 **Mojo 언어를 배우고 실험하기 위한 전용 공간**이다. Claude는 이 워크스페이스에서 작업할 때 아래 규칙을 반드시 따른다.

## 1. 사용자 프로필

- 주력 언어: **C++ (강함) > Python**.
  → Mojo의 시스템 프로그래밍 측면(타입, 메모리, SIMD, 소유권/borrow, MLIR)은 C++ 비유로 설명하면 빠르게 이해함.
  → 반대로 Python 진영 관용구(`__init__`, decorator, dunder)는 너무 자세히 풀지 않아도 됨.
- 학습 목적: **언어 자체의 이해 + 성능/SIMD/AI 워크로드에서의 활용 가능성 탐색**.
- 응답 언어: **한국어**. 코드/명령어/식별자/에러 메시지는 그대로 영어 유지.

## 2. 워크스페이스 구조

```
mojo/
├── CLAUDE.md              # 본 파일. 운영 규칙 (Claude가 항상 읽음)
├── README.md              # 사람이 읽는 워크스페이스 개요
├── TODO.md                # 활성 TODO. 메인 agent가 관리
├── .claude/
│   ├── agents/            # 프로젝트 전용 sub-agent 정의
│   │   ├── mojo-orchestrator.md   # 메인 지휘 agent
│   │   ├── mojo-experimenter.md   # work 단위 실행 agent
│   │   └── mojo-log-keeper.md     # 로그 작성/검색 전용 agent
│   └── skills/
│       └── work-log/      # 로그 작성 skill (정형 5섹션 포맷)
│           └── SKILL.md
├── log/                   # 모든 work 로그가 모이는 곳
│   ├── README.md          # 트리 인덱스 (필수 갱신)
│   └── NNNN-<slug>.md     # 개별 work 로그
├── experiments/           # 실제 Mojo/Python/C++ 코드
│   └── NNNN-<slug>/       # work 번호와 1:1 매칭
└── docs/                  # 학습 노트, 정리 문서, 다이어그램 등
```

- log 번호와 experiment 번호는 **같은 시퀀스를 공유**한다. 즉 `log/0007-simd-add.md`의 코드는 `experiments/0007-simd-add/`에 위치.
- 번호는 4자리 zero-padding (`0001`...). 새 번호 할당은 work-log skill에서 자동 처리.

## 3. Agent 구성 및 워크플로우

세 종류의 agent가 협업한다.

### 3.1 mojo-orchestrator (메인 지휘)

- 사용자의 고수준 목표를 받아 **discrete work 단위로 분해**.
- TODO.md를 읽고/쓰고/정렬한다 (사용자가 결과를 보고 떠올린 아이디어를 여기에 누적).
- 독립적인 work 여러 개는 **병렬로 experimenter agent에 분배**.
  → 단, 동시에 돌릴 work이 무거우면 (compile/bench 등) **사용자에게 자원 사용 계획을 보고하고 승인 받은 뒤 실행**.
- 모든 work이 끝나면 결과를 종합해 사용자에게 보고하고, TODO를 업데이트.

### 3.2 mojo-experimenter (work 실행)

- 단일 work을 받는다 (예: "Mojo의 `SIMD` 타입으로 vector add 후 Python 대비 측정").
- 실행 단계:
  1. **계획**: 목표/기대 결과를 명시.
  2. **실행**: `experiments/NNNN-<slug>/` 에 코드 작성, 빌드/실행, 출력 캡처.
  3. **로그**: work-log skill 호출하여 5섹션 포맷으로 `log/NNNN-<slug>.md` 작성.
  4. **보고**: orchestrator에게 핵심 결과 요약 + 후속 아이디어 후보 반환.
- 자체 판단으로 코드 정리/리팩토링은 하지 않음 (work 범위 안에서만).

### 3.3 mojo-log-keeper (로그 관리)

- work-log skill의 실제 호출 책임.
- 새 로그 작성 시 **다음 번호 할당 + 인덱스(`log/README.md`) 갱신**.
- 사용자가 "지금까지 SIMD 관련 work 뭐 있었어?" 같은 질문을 하면 로그를 검색·요약.
- 로그 자체의 일관성(포맷, 메타데이터) 검증.

## 4. 추천 워크플로우

```
사용자 메시지 (목표/아이디어)
        │
        ▼
 mojo-orchestrator
        │
        ├─ TODO.md 갱신 (새 아이디어 누적)
        ├─ work 분해 (병렬 가능 여부 판단)
        ├─ [자원 확인] 무거운 병렬 실행이면 사용자 승인
        │
        ▼
  mojo-experimenter × N  (병렬)
        │
        ├─ experiments/NNNN-* 코드 작성/실행
        ├─ work-log skill 호출 → mojo-log-keeper
        │       └─ log/NNNN-*.md + log/README.md 갱신
        ▼
 결과 종합 → 사용자에게 보고 + TODO 정리
```

## 5. 절대 규칙

1. **모든 work은 반드시 로그를 남긴다.** 실패한 시도, 중단된 실험도 로그로 기록 (실패의 이유가 다음 work의 입력).
2. **로그 포맷은 5섹션 고정** (Title 아래에 1) 목적, 2) 수행, 3) 예상 결과, 4) 실제 결과, 5) 결론). work-log skill을 통해서만 작성.
3. **CPU/메모리/디스크가 필요한 무거운 작업은 사전에 사용자에게 보고**. 예: 동시에 4개 이상의 빌드/벤치, RAM 4GB+ 모델 로드, 대용량 다운로드.
4. **TODO 추가는 메인 agent의 책임**. experimenter가 후속 아이디어를 발견하면 메인에게 보고하고, 메인이 TODO에 등재.
5. **학습 목적이므로 모든 문서는 자세히** 쓴다. 로그의 "결론" 섹션은 단순 OK/Fail이 아니라 *왜 그런 결과가 나왔는지*까지 적는다.
6. **C++ 비유**를 적극 활용한다 (예: Mojo struct ≈ C++ struct + value semantics, `fn` ≈ strict mode, `def` ≈ Python-compat mode 등).

## 6. 시스템 환경 (2026-04-28 기준)

- OS: Ubuntu 24.04 LTS, kernel 6.17
- CPU: 16 cores
- RAM: 14 GiB (swap 4 GiB)
- Disk: 699 GB free at `/home/hwan`
- Python 3.12.3, g++ 13.3.0
- Mojo: **미설치** (첫 work에서 설치 예정)

## 7. 참고 경로

- 공용 모델: `~/models/` (read-only). 추후 MAX 엔진으로 모델을 돌릴 때 사용.
- 사용자 글로벌 지침: `~/.claude/CLAUDE.md`.
