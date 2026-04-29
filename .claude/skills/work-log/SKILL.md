---
name: work-log
description: Write a new work log file in /home/hwan/workspace/mojo/log/ using the fixed 5-section format. Use whenever a Mojo learning work has been completed (success, failure, or partial) and needs to be persisted. The skill handles next-number allocation, file creation, and index update.
---

# work-log skill

이 skill은 Mojo 학습 워크스페이스에서 **work 1건의 로그**를 표준 포맷으로 만든다.

## 입력 (호출자가 제공)

```
work_id          : "NNNN" (4자리. 모르면 "auto" 입력 — skill이 자동 할당)
slug             : 영문 소문자 + 하이픈, 짧게 (예: "hello-world")
title            : 한 줄 제목 (한국어 가능)
status           : done | failed | partial
date             : YYYY-MM-DD (생략 시 오늘)
tags             : 콤마/리스트 (예: setup, basics)
related_code     : experiments/NNNN-<slug>/   (없으면 비움)

section_1_purpose     : 1) 무엇을 하고자 하는지
section_2_actions     : 2) 수행한 일 (설치, 코드, 명령)
section_3_expected    : 3) 예상되는 결과
section_4_actual      : 4) 실제 결과
section_5_conclusion  : 5) 결론
```

## 절차

### Step 1. work_id가 "auto"면 다음 번호 할당

```bash
ls /home/hwan/workspace/mojo/log/ 2>/dev/null \
  | grep -oE '^[0-9]{4}' \
  | sort -n | tail -1
```

- 출력값 + 1, 4자리 zero-padding. 결과 없으면 `0001`.

### Step 2. 파일 경로 결정

```
/home/hwan/workspace/mojo/log/NNNN-<slug>.md
```

이미 같은 경로가 있으면 **덮어쓰지 말고 호출자에게 에러 반환** ("이미 존재함, slug 변경 필요").

### Step 3. 파일 작성

다음 템플릿에 입력값을 끼워 `Write` 도구로 작성:

```markdown
---
id: NNNN
title: <title>
status: <status>
date: <YYYY-MM-DD>
tags: [<tag1>, <tag2>, ...]
related_code: <experiments/NNNN-<slug>/  또는 생략>
---

# NNNN. <title>

## 1. 무엇을 하고자 하는지

<section_1_purpose>

## 2. 수행한 일

<section_2_actions>

## 3. 예상되는 결과

<section_3_expected>

## 4. 실제 결과

<section_4_actual>

## 5. 결론

<section_5_conclusion>
```

규칙:
- frontmatter의 `tags`는 항상 YAML 리스트(`[a, b]`).
- `related_code` 값이 비면 그 줄 자체를 생략.
- 섹션 헤더(`## 1. ...`)는 토씨 하나 바꾸지 않는다.

### Step 4. 인덱스 갱신

`/home/hwan/workspace/mojo/log/README.md` 안의 인덱스 표를 `Edit` 도구로 수정.

- 인덱스 표 헤더 행:
  ```
  | # | 제목 | 상태 | 날짜 | 태그 |
  |---|------|------|------|------|
  ```
- **헤더 바로 다음 줄에 새 행 추가** (시간 역순 유지):
  ```
  | NNNN | [<title>](NNNN-<slug>.md) | <status> | <date> | <tags 콤마> |
  ```

### Step 5. 결과 반환

호출자에게:
```
created: log/NNNN-<slug>.md
indexed: log/README.md updated
```

## 자주 하는 실수 (피할 것)

- **5섹션 헤더 변경 금지**. 자동 분석이 깨진다.
- **frontmatter 누락 금지**. 특히 `id`/`status`/`tags`는 검색에 쓰인다.
- **인덱스 표 갱신 누락 금지**. 파일만 만들고 표를 안 바꾸면 발견이 어려워진다.
- **slug에 공백/대문자 금지**. 파일 경로가 깨진다.
