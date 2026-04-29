---
id: 0001
title: 워크스페이스 초기 셋업 (agents, skill, 디렉토리 구조)
status: done
date: 2026-04-28
tags: [setup, infra]
---

# 0001. 워크스페이스 초기 셋업 (agents, skill, 디렉토리 구조)

## 1. 무엇을 하고자 하는지

`/home/hwan/workspace/mojo/`를 Mojo 학습 전용 워크스페이스로 셋업한다. 사용자의 요구사항은 다음과 같다.

- **메인 agent**가 사용자의 목표를 받아 전체를 지휘.
- 새로운 실험·work마다 **별도 agent**를 띄워 분배 (병렬 가능하면 병렬).
- 모든 work은 `log/` 디렉토리에 정형 5섹션 포맷으로 기록.
- 로그 작성은 **skill**로 등록, 이를 관리하는 **전용 agent**도 있음.
- **TODO**는 메인 agent가 관리. 사용자가 결과를 보고 떠올린 아이디어를 누적.
- 트리 구조로 체계적 파일 관리. 학습 목적이므로 문서는 자세히.
- 무거운 자원 사용은 사전에 사용자에게 확인.

이 work에서는 위 인프라 자체를 한 번에 구축한다.

## 2. 수행한 일

### 2.1 환경 점검 (사전 조사)

- `which mojo magic pixi` → 모두 미설치.
- `~/.modular` 없음.
- 시스템: Ubuntu 24.04 LTS, kernel 6.17, 16 코어, RAM 14 GiB (가용 9.6 GiB, swap 2.6 GiB 사용 중), `/home/hwan` 699 GB free.
- 기 설치 도구: Python 3.12.3, g++ 13.3.0.

### 2.2 디렉토리 구조 생성

```bash
mkdir -p /home/hwan/workspace/mojo/{.claude/agents,.claude/skills/work-log,log,experiments,docs}
```

최종 트리:

```
mojo/
├── CLAUDE.md
├── README.md
├── TODO.md
├── .claude/
│   ├── agents/
│   │   ├── mojo-orchestrator.md
│   │   ├── mojo-experimenter.md
│   │   └── mojo-log-keeper.md
│   └── skills/work-log/SKILL.md
├── log/
│   ├── README.md
│   └── 0001-workspace-init.md  ← 본 파일
├── experiments/README.md
└── docs/README.md
```

### 2.3 작성한 파일

| 파일 | 역할 |
|------|------|
| `CLAUDE.md` | 운영 규칙 (Claude가 항상 읽음) — 사용자 프로필, 워크플로우, 절대 규칙, 시스템 환경 |
| `README.md` | 사람이 읽는 워크스페이스 개요 |
| `TODO.md` | In Progress / Next / Backlog / Done 4구역. 첫 항목부터 등재 |
| `.claude/agents/mojo-orchestrator.md` | 메인 지휘 agent. opus 모델. TODO 관리 + work 분해 + experimenter 디스패치 |
| `.claude/agents/mojo-experimenter.md` | 단일 work 실행 agent. opus 모델. 코드 작성/실행/로그 키퍼 호출 |
| `.claude/agents/mojo-log-keeper.md` | 로그 진입점 agent. sonnet 모델. 번호 할당, work-log skill 호출, 인덱스 갱신, 검색 |
| `.claude/skills/work-log/SKILL.md` | 5섹션 정형 로그 작성 skill. frontmatter + 5섹션 + 인덱스 갱신 |
| `log/README.md` | 로그 트리 인덱스 + 포맷 명세 |
| `experiments/README.md`, `docs/README.md` | 각 디렉토리 사용 가이드 |

### 2.4 핵심 설계 결정

- **work 번호 = log 번호 = experiments 폴더 번호**, 단일 글로벌 시퀀스. 4자리 zero-padding.
- agents 모델 분배: orchestrator/experimenter는 의사결정·코드 생성이 무거우니 **opus**, log-keeper는 정형 작업 위주라 **sonnet**.
- log-keeper만 `Skill` 도구를 갖는다 — skill 호출 권한을 한 곳에 모아 일관성 유지.
- experimenter는 절대 직접 로그를 안 쓴다 → 항상 log-keeper 경유. 포맷 일관성 강제.
- TODO.md 수정은 **orchestrator만** — 책임 분산 방지.

## 3. 예상되는 결과

- 사용자가 다음 메시지에서 "X를 해보자"고 말하면, orchestrator가 자동으로 로드되어 work으로 분해하고 experimenter를 띄워야 한다.
- experimenter가 끝나면 log-keeper를 통해 `log/NNNN-*.md`가 생기고 `log/README.md` 인덱스에 한 줄이 추가되어야 한다.
- TODO.md의 "Next" 항목이 작업 후보로 자연스럽게 잡혀야 한다.

## 4. 실제 결과

- 모든 파일 작성 완료. `tree`(또는 `ls -R`) 출력으로 구조 검증 가능.
- 로그 인덱스(`log/README.md`)에 본 0001 행이 등재된 상태.
- Mojo는 아직 미설치 — 다음 work 후보(Mojo 설치)로 TODO Next 최상단에 위치.

## 5. 결론

- 워크스페이스 인프라가 갖춰졌다. 이제부터의 모든 학습 활동은:
  1. 사용자 요청 → orchestrator
  2. orchestrator → experimenter (병렬 가능)
  3. experimenter → log-keeper (work-log skill)
  4. orchestrator → 사용자 (요약 + TODO 갱신)
  의 사이클로 돌아간다.

- **C++ 사용자 관점에서의 Mojo 학습 전략**:
  - 처음에는 언어 표면(syntax) 빠르게 훑고, 곧바로 메모리 모델/소유권/SIMD 같은 시스템 측면으로 진입.
  - Python 비교는 *동기부여용*(왜 Mojo가 만들어졌는지)이고, 본격 비교 대상은 **C++**이 더 적합.
  - 모든 벤치는 가능한 한 C++ `-O3 -march=native` 결과를 기준선으로 둘 것.

- **다음 work 후보 (TODO Next 반영됨)**:
  - Mojo 설치 (`magic`/`pip install modular` 중 선택)
  - Hello world & 첫 컴파일 산출물 관찰
  - `fn` vs `def` — 타입 강제와 컴파일 시점 검사 차이

- **남은 의문(향후 work 후보)**: Mojo가 실제로 어떤 IR로 컴파일되는지(`-emit=llvm`, `-emit=mlir` 같은 옵션이 있는지), AOT vs JIT 모드의 기본값이 무엇인지 — 0003에서 확인 예정.
