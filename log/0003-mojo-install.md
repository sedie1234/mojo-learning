---
id: 0003
title: Mojo 설치 (venv + pip install modular) 및 hello world 검증
status: done
date: 2026-04-28
tags: [setup, install, basics]
related_code: experiments/0003-mojo-install/
---

# 0003. Mojo 설치 (venv + pip install modular) 및 hello world 검증

## 1. 무엇을 하고자 하는지

- 본 워크스페이스에 격리된 Python venv 안에서 `pip install modular`로 Mojo 컴파일러(+ MAX 런타임)를 설치한다.
- `mojo --version` / `mojo run` / `mojo build` 세 동작을 확인하여 다음 단계 학습의 토대를 만든다.
- **설치 방식 선택의 근거를 기록**: magic(curl-pipe) 대신 venv를 채택한 이유 (학습 페이스에서의 투명성·격리성 우위). MAX/GPU 단계에서 magic을 다시 평가할 때를 위해 기준선을 남긴다.

## 2. 수행한 일

### 2.1 설치 방식 선택 — magic vs venv

| 항목 | magic | venv + pip |
|------|-------|------------|
| Mojo 컴파일러 | ✓ | ✓ |
| MAX/CUDA stack 자동 매칭 | ✓ | 수동 |
| Shell 환경 변경 | curl-pipe가 `~/.bashrc` 수정 | 격리 (`.venv`만) |
| 투명성 | pixi 추상화 한 겹 더 | `pip list`로 모든 의존성 가시 |
| 제거 | 환경 삭제 + shell 잔재 | `rm -rf .venv` |

→ **언어 학습 단계에서는 venv 채택**. MAX/GPU(T-17~19) 진입 시 magic을 재평가하기로 결정.

### 2.2 사전 점검

- python3-venv: `3.12.3-0ubuntu2.1` 설치됨
- 디스크: 699 GB free
- 메모리: 9.6 GB available

### 2.3 venv 구성 + 설치

```bash
cd /home/hwan/workspace/mojo
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip          # 26.1
pip install modular                # 본 명령 1개로 전체 스택 설치
```

설치된 핵심 패키지:

```
modular        26.2.0
max            26.2.0
max-core       26.2.0
mojo           0.26.2.0
mojo-compiler  0.26.2.0
+ ~80 의존성 (transformers, datasets, numpy, pandas, scipy, pyarrow, opentelemetry-* 등)
```

설치 후 `.venv/` 사이즈 = **2.0 GB**.

`which mojo` → `/home/hwan/workspace/mojo/.venv/bin/mojo` (venv 격리 OK).

### 2.4 hello world 작성/실행/빌드

`experiments/0003-mojo-install/hello.mojo`:

```mojo
fn main():
    print("Hello, Mojo! (work 0003)")
    var x: Int = 42
    var y: Float64 = 3.14
    print("Int =", x, " Float64 =", y)
```

세 가지 모드 검증:

```bash
mojo run hello.mojo                  # JIT/직접 실행
mojo build hello.mojo -o hello       # AOT 빌드 (default -O3)
./hello                              # 빌드 산출물 실행
```

### 2.5 산출물 분석

```text
file hello
  ELF 64-bit LSB pie executable, x86-64, dynamically linked,
  interpreter /lib64/ld-linux-x86-64.so.2, not stripped

du -h hello   → 44K

ldd hello (요약)
  libKGENCompilerRTShared.so   ← .venv/lib/python3.12/site-packages/modular/lib/
  libAsyncRTRuntimeGlobals.so   ← 동
  libMSupportGlobals.so         ← 동
  libNVPTX.so                   ← 동 (CPU-only 환경에도 GPU codegen 라이브러리가 따라옴)
  libAsyncRTMojoBindings.so     ← 동
  libstdc++.so.6                ← 시스템 (Mojo 런타임이 C++ 기반 시사)
  libc.so.6, libm.so.6, libgcc_s.so.1  ← 시스템
```

### 2.6 `mojo build --help` — 다음 work에 쓸 옵션 발견

- `--emit exe|shared-lib|object|llvm|llvm-bitcode|asm` — IR/ASM dump 가능
- `--optimization-level 0~3` (기본 **3**)
- "Python libs는 binary에 포함되지 않음, 실행 환경이 제공해야 함" 명시

## 3. 예상되는 결과

- `mojo --version` 출력 + JIT/AOT 모두 동작.
- AOT 빌드 산출물은 정적이 아닐 가능성이 높다(LLVM 기반 → libstdc++/runtime 의존). 크기는 작을 것 (수십 KB).
- venv 사이즈 1~2 GB 예상 (Mojo 컴파일러 + MAX + transformers/torch류 의존).

## 4. 실제 결과

- ✅ `Mojo 0.26.2.0 (d627decc)`. JIT, AOT, 산출물 직접 실행 모두 통과.
- ✅ AOT 산출물: **44 KB, dynamically linked**. `.venv/.../modular/lib/`의 `libKGENCompilerRTShared`, `libAsyncRTRuntimeGlobals`, `libMSupportGlobals`, `libNVPTX`, `libAsyncRTMojoBindings`에 의존 + 시스템 `libstdc++`, `libc`, `libm`, `libgcc_s`.
- ✅ venv 사이즈 = **2.0 GB**.

특이점:
- **`libNVPTX.so` 동봉**: CPU-only 머신에서도 NVIDIA GPU codegen 백엔드가 따라온다. `mojo build --emit asm`이 GPU 타깃 sidecar(`.ptx`/`.amdgcn`/`.ll`)를 함께 낼 수 있다는 도움말과 일관 — GPU 지원이 빌드 타임 옵션이 아니라 **항상 포함되는 백엔드**로 보임.
- **`libstdc++` 의존**: Mojo 런타임이 C++ 기반(LLVM/MLIR 인프라 자체가 C++)으로 추정 — 향후 ABI/예외 동작 분석 시 참고.
- **`mojo build --emit llvm|asm`** 존재: 0004(첫 컴파일 산출물 관찰)에서 코드 한 줄 변경하지 않고 IR과 어셈블리를 바로 비교 가능.

## 5. 결론

- Mojo 학습 환경이 venv 한 곳에 격리되어 깨끗하게 구축됐다. 워크스페이스 외부에 어떤 흔적도 남기지 않음 (shell rc 미수정). `rm -rf .venv` 한 번이면 완전 제거.
- **2.0 GB**라는 양은 단순 컴파일러보다는 **MAX + 트랜스포머 의존성까지 함께 들어온** 결과. 추후 컴파일러만 따로 분리하고 싶으면 별도 venv에 부분 설치를 시도해 볼 수 있음(향후 work 후보).
- AOT 산출물의 **shared lib 의존성**은 C++ 사용자가 흔히 기대하는 `-static` 산출물과 다르다. 배포 시 venv 라이브러리 디렉토리 동봉 또는 `LD_LIBRARY_PATH` 설정이 필요. `mojo build --emit shared-lib` / `object`도 있으므로 정적 링크 흐름은 별도 work에서 검증 (TODO 후보).
- **GPU codegen 백엔드가 항상 포함**되는 점은 Mojo의 핵심 설계 단서: "단일 컴파일러로 CPU/GPU 동시 타깃" 철학이 빌드 타임에 이미 박혀 있음. 후일 SIMD work과 매칭되는 GPU work에서 이 점이 다시 살아남.
- **다음 work 후보(이미 등재된 issue 우선)**:
  - 0004 = T-4 *Hello world & 첫 컴파일 산출물 관찰* — 본 work의 후속. `--emit llvm/asm`로 IR/ASM 비교, optimization level 차이, `mojo build` 정적 링크 시도.
  - 새 후보(아직 issue 없음): "venv에서 Mojo 컴파일러만 단독 분리 설치 가능한가" — TODO Backlog에 추가 권장.
  - 새 후보: "`mojo build --emit shared-lib`로 만든 .so를 C++에서 dlopen으로 호출 가능한가" — Mojo↔C++ 상호운용 work으로 발전 가능.
