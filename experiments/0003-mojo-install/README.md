# 0003 — Mojo 설치 검증 실험

`pip install modular` (venv 안)로 설치된 mojo 컴파일러의 기본 동작 검증.

## 파일

- `hello.mojo` — `fn main()` + 정수/부동소수 print
- `hello` — `mojo build hello.mojo -o hello` 산출물 (44K ELF, dynamically linked, not stripped)

## 재현

```bash
cd /home/hwan/workspace/mojo
source .venv/bin/activate
cd experiments/0003-mojo-install
mojo run hello.mojo            # JIT/직접 실행
mojo build hello.mojo -o hello # AOT 빌드
./hello
```

자세한 결과는 `../../log/0003-mojo-install.md` 참고.
