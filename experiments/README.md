# Experiments

각 work에서 작성/실행한 실제 코드.

## 규칙

- 폴더 이름: `NNNN-<slug>/` — 동일 번호의 로그(`log/NNNN-<slug>.md`)와 1:1 매칭.
- 폴더 안 구조는 자유. 보통:
  ```
  NNNN-<slug>/
  ├── README.md       # 무엇을 하는 코드인지 한 줄 (선택)
  ├── main.mojo       # Mojo 코드
  ├── ref.py          # 비교용 Python (있을 때)
  ├── ref.cpp         # 비교용 C++ (있을 때)
  └── run.sh          # 빌드/실행 명령 한 번에 (선택)
  ```
- **빌드 산출물(`*.o`, 실행 파일, `__pycache__` 등)은 커밋하지 않는다** — 필요하면 `.gitignore` 추가.

## 인덱스

(아직 없음. 첫 실험은 Mojo 설치 후.)
