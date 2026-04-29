# Work 로그 인덱스

이 디렉토리는 워크스페이스에서 진행된 모든 **work의 영구 기록**이다.
모든 로그는 `mojo-log-keeper` agent + `work-log` skill을 통해 작성된다.

## 트리

```
log/
├── README.md          ← 이 파일 (인덱스)
└── NNNN-<slug>.md     ← 개별 work 로그
```

- **번호 할당 규칙**: 4자리 zero-padding, 단일 글로벌 시퀀스. 다음 번호 = `max(existing) + 1`.
- **slug**: 영문 소문자 + 하이픈, 짧고 구체적으로 (`hello-world`, `simd-add-bench`, `fn-vs-def`).
- **연관 코드**: 각 로그는 동일 번호의 `experiments/NNNN-<slug>/` 폴더와 1:1 매칭.

## 로그 포맷 (고정)

각 로그는 다음 5섹션을 그대로 가진다 (work-log skill이 강제).

```markdown
---
id: NNNN
title: <한 줄 제목 — 무엇에 대한 work인지>
status: done | failed | partial
date: YYYY-MM-DD
tags: [setup, basics, simd, perf, interop, ml, ...]
related_code: experiments/NNNN-<slug>/   # 코드 없으면 생략
---

# NNNN. <제목>

## 1. 무엇을 하고자 하는지
(목적/가설/질문)

## 2. 수행한 일
(설치한 패키지, 작성한 코드의 요점, 실행한 명령, 변경한 설정 — 재현 가능 수준으로)

## 3. 예상되는 결과
(work 시작 시점에 기대했던 결과/수치/거동)

## 4. 실제 결과
(실제로 관측한 출력, 수치, 에러 메시지)

## 5. 결론
- 무엇이 검증/반증되었는지
- 왜 그런 결과가 나왔는지 (가능하면 원리적 설명)
- 후속 work 후보 (TODO로 등재될 후보)
```

## 인덱스 (시간 역순)

| # | 제목 | 상태 | 날짜 | 태그 |
|---|------|------|------|------|
| 0014 | [MAX CPU 적용 가능성 조사 — Qwen3-4B / Gemma4-E2B 부정 결과](0014-max-cpu-survey.md) | done | 2026-04-29 | max, ai-workloads, llm, cpu-only, infeasibility |
| 0013 | [Blocked matmul — Mojo vs C++ vs NumPy MKL (cache tiling)](0013-matmul-blocked.md) | done | 2026-04-29 | simd, performance, benchmark, matmul, cache-blocking, parallelize |
| 0012 | [Matmul 다구현 비교 — naive / SIMD / Mojo parallelize / NumPy BLAS](0012-matmul-naive-vec-par.md) | done | 2026-04-29 | simd, performance, benchmark, matmul, parallelize, multi-thread |
| 0011 | [sum reduction 4-way — Python pure / NumPy / C++ AVX-512 / Mojo SIMD16](0011-sum-reduction-4way.md) | done | 2026-04-29 | simd, performance, benchmark, reduction |
| 0010 | [vector add 4-way 비교 — Python pure / NumPy / C++ / Mojo JIT / Mojo AOT](0010-vector-add-4way.md) | done | 2026-04-29 | simd, performance, benchmark, jit-vs-aot, python-cpp-mojo |
| 0009 | [SIMD vector add — Mojo SIMD16 vs C++ AVX-512 (벤치 + ASM)](0009-simd-vector-add.md) | done | 2026-04-29 | simd, performance, benchmark, asm, cpp-comparison |
| 0008 | [Trait/parametric polymorphism + Python interop vs Mojo native cost](0008-trait-and-native-vs-interop.md) | done | 2026-04-29 | basics, trait, python-interop, benchmark |
| 0007 | [Language Fundamentals 5건 (fn vs def, struct, numeric, var, ownership)](0007-language-fundamentals-survey.md) | done | 2026-04-29 | basics, language-fundamentals, ownership, types |
| 0006 | [Python interop 표면 + 비용 측정 (lifecycle / 변환비용 / 타입변환 / 예외)](0006-python-interop-survey.md) | done | 2026-04-29 | python-interop, benchmark, basics |
| 0005 | [Mojo 패키지/모듈 구조 — import 메커니즘, .mojopkg, stdlib 레이아웃](0005-package-structure.md) | done | 2026-04-29 | basics, packaging, stdlib, python-interop |
| 0003 | [Mojo 설치 (venv + pip install modular) 및 hello world 검증](0003-mojo-install.md) | done | 2026-04-28 | setup, install, basics |
| 0001 | [워크스페이스 초기 셋업 (agents, skill, 디렉토리)](0001-workspace-init.md) | done | 2026-04-28 | setup |

> 새 로그가 작성될 때마다 이 표 맨 위에 한 줄을 추가한다.
