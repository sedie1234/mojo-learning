---
id: 0005
title: Mojo 패키지/모듈 구조 — import 메커니즘, .mojopkg, stdlib 레이아웃
status: done
date: 2026-04-29
tags: [basics, packaging, stdlib, python-interop]
related_code: experiments/0005-package-structure/
---

# 0005. Mojo 패키지/모듈 구조 — import 메커니즘, .mojopkg, stdlib 레이아웃

## 1. 무엇을 하고자 하는지

Python의 `sys.path` + 패키지 트리에 해당하는 **Mojo의 모듈/패키지 모델**을 파일시스템 레벨에서 직접 확인. 코드 실행은 하지 않고 `ls`/`file`/`cat`/`grep`/`find`/`xxd`만으로 추적해 사용자가 직접 같은 명령으로 따라 검증 가능하게 한다.

확인 항목:
- `mojo` CLI 자체의 정체와 호출 흐름
- stdlib 위치/포맷 (`.mojopkg` vs `.mojo`)
- 모듈 검색 경로 (env, CLI flags, 컨벤션)
- Python ↔ Mojo bridge 구현 위치
- prelude/builtin 자동 주입 메커니즘

베이스라인 환경: 0003에서 `pip install modular`로 설치된 venv (`/home/hwan/workspace/mojo/.venv/`).

## 2. 수행한 일

`experiments/0005-package-structure/run.sh`에 12단계 추적이 함수로 구현되어 있다 (`bash run.sh` 또는 `bash run.sh <N>`로 단일 단계 실행). 아래는 단계별 핵심 명령 + 출력 + 발견.

### 단계 1. `mojo` CLI는 무엇인가

```
$ ls -la /home/hwan/workspace/mojo/.venv/bin/mojo
-rwxrwxr-x 1 hwan hwan 201 Apr 28 11:48 .../bin/mojo

$ file .../bin/mojo
.../bin/mojo: Python script, ASCII text executable

$ cat .../bin/mojo
#!/home/hwan/workspace/mojo/.venv/bin/python3
import sys
from mojo._entrypoints import exec_mojo
if __name__ == '__main__':
    sys.argv[0] = sys.argv[0].removesuffix('.exe')
    sys.exit(exec_mojo())
```

→ **CLI 진입점은 201바이트 Python 스크립트**. 진짜 컴파일러는 다른 곳.

### 단계 2~4. modular 패키지 레이아웃

```
$ ls /home/hwan/workspace/mojo/.venv/lib/python3.12/site-packages/modular/
bin
lib

$ du -sh modular/*
835M    modular/lib
293M    modular/bin
```

→ **딱 두 개 디렉토리**, 합쳐서 1.1 GB. `include/`/`share/` 같은 톱레벨 디렉토리 없음.

`modular/bin/` 내용:

```
mojo          135 MB  ELF compiler (stripped, dynamic)
lld           110 MB  LLVM 링커 (Mojo가 직접 링크 호출)
lldb-server    18 MB  debugger
mojo-lsp-server 33 MB IDE/editor 통합
llvm-symbolizer 6 MB
mojo-lldb     378 KB  debugger 프론트
gpu-query     292 KB  GPU 인벤토리
modular-crashpad-handler 593 KB
lldb-dap, lldb-argdumper
```

→ **mojo(컴파일러) + lld(링커) + lldb(디버거)** 셋이 핵심. LLVM 도구 직접 동봉.

`modular/lib/` 톱레벨:

```
*.so 파일 10개          # 런타임
디렉토리 ↓
  mojo/                 # ★ stdlib 본체
  mojo-repl-entry-point/
  lldb-visualizers/
  nixl/, nvshmem_*       # GPU 컴 백엔드
```

### 단계 5. stdlib 위치/포맷 — `modular/lib/mojo/`

```
$ ls modular/lib/mojo/
buffer.mojopkg            internal_utils.mojopkg    quantization.mojopkg
comm.mojopkg              kv_cache.mojopkg          register.mojopkg
compiler.mojopkg          layout.mojopkg            shmem.mojopkg
compiler_internal.mojopkg linalg.mojopkg            std.mojopkg            ← 표준 라이브러리
_cublas.mojopkg           MOGGKernelAPI.mojopkg     structured_kernels.mojopkg
_cudnn.mojopkg            MOGGPrimitives.mojopkg    tensor.mojopkg
_cufft.mojopkg            _miopen.mojopkg           weights_registry.mojopkg
_curand.mojopkg           nn.mojopkg
_rocblas.mojopkg          nvml.mojopkg

(총 25개 .mojopkg)

$ ls -la modular/lib/mojo/std.mojopkg
-rwxrwxr-x 1 hwan hwan 18617406 ... std.mojopkg                ← 18.6 MB

$ find modular -name '*.mojo' 2>/dev/null | wc -l
0                                                              ← 소스 0개
```

→ **모든 stdlib는 `.mojopkg`(pre-compiled binary)로만 배포**. `.mojo` 소스는 단 하나도 없다.

25개 패키지를 그룹지어 보면:

| 그룹 | 패키지 | 역할 |
|------|--------|------|
| **언어 본체** | `std`, `compiler`, `compiler_internal`, `internal_utils`, `register` | Mojo 표준 라이브러리, 컴파일러 introspection |
| **MAX core** | `buffer`, `tensor`, `layout`, `nn`, `linalg`, `MOGGKernelAPI`, `MOGGPrimitives`, `structured_kernels` | AI 추론 stack |
| **LLM 추론** | `kv_cache`, `quantization`, `weights_registry` | 트랜스포머 추론 인프라 |
| **GPU vendor** | `_cublas`, `_cudnn`, `_cufft`, `_curand`, `_miopen`, `_rocblas`, `nvml` | NVIDIA/AMD 라이브러리 바인딩 (underscore prefix = internal) |
| **HPC comm** | `comm`, `shmem` | multi-GPU/host 통신 |

### 단계 6. `.mojopkg` 파일 시그니처

```
$ xxd modular/lib/mojo/std.mojopkg | head -2
00000000: 4d50 4b47 012e 2e2e 0000 0000 001a 0200  MPKG............
00000010: 0000 3063 6164 3463 6536 3766 3061 6234  ..0cad4ce67f0ab4
```

→ **ASCII "MPKG" + 0x01 버전**. 자체 포맷. (`file` 명령은 잘못 매칭하지만 그건 무시.)

### 단계 7. CLI → ELF 점프 메커니즘

`/home/hwan/workspace/mojo/.venv/lib/python3.12/site-packages/mojo/_entrypoints.py`의 `exec_mojo`:

```python
def exec_mojo() -> None:
    env = _mojo_env()
    os.execve(env["MODULAR_MOJO_MAX_DRIVER_PATH"], sys.argv, env)
```

→ `os.execve` = **fork 없이 현재 프로세스를 ELF로 통째 교체**. PID 유지, 환경 주입, argv 전달. Python wrapper의 비용은 Python 인터프리터 한 번 시작 정도(짧음).

### 단계 8. 환경변수 — 어떤 경로를 주입하나

`mojo/run.py`의 `_sdk_default_env()`:

```python
return {
    "MODULAR_MAX_PACKAGE_ROOT":      str(root),                 # modular/
    "MODULAR_MOJO_MAX_PACKAGE_ROOT": str(root),                 # modular/
    "MODULAR_MOJO_MAX_DRIVER_PATH":  str(bin / "mojo"),         # modular/bin/mojo
    "MODULAR_MOJO_MAX_IMPORT_PATH":  str(lib / "mojo"),         # modular/lib/mojo  ★
}
```

→ **`MODULAR_MOJO_MAX_IMPORT_PATH`가 stdlib 검색 경로**. 추가로 `mojo build -I <PATH>`가 사용자 경로 append.

### 단계 9. `get_package_root()` 알고리즘

`mojo/_package_root.py`:

```python
def get_package_root() -> Path | None:
    site_packages_root = Path(__file__).parent.parent     # site-packages

    conda_root = site_packages_root.parent.parent.parent  # <conda env>/  (bin/mojo 직접)
    wheel_root = site_packages_root / "modular"            # site-packages/modular/

    # wheel을 먼저! 안 그러면 wrapper script가 자기 자신을 호출하는 무한루프
    for root in (wheel_root, conda_root):
        if (root / "bin/mojo").exists():
            return root

    if venv_root := os.environ.get("VIRTUAL_ENV"):
        return Path(venv_root)
    ...
```

→ **wheel/conda 양쪽 호환** + venv fallback. 주석 그대로: "Make sure we check the wheel root first!"

### 단계 10. import 검색 — `-I` + `__init__.mojo`

`mojo build --help`에서:

```
-I <PATH>
    Appends the given path to the list of directories to search for
    imported Mojo files.
```

→ **C++ `-I`와 똑같은 의미**. 이름까지 동일.

`mojo package --help`에서:

```
To create a Mojo package, first add an `__init__.mojo` file to your
package directory. Then pass that directory name to this command...
A Mojo package is portable across different systems because it includes
only non-elaborated code.
The code becomes an arch-specific executable only after it's imported
into a Mojo program that's then compiled with `mojo build`.
```

→ **`__init__.mojo` = Python `__init__.py` 동일 컨벤션**. 결정적 차이: **non-elaborated code**로 패키지화 → use-site에서 elaborate(arch-specific 코드 생성) → 그래서 `.mojopkg`는 portable.

### 단계 11. Python ↔ Mojo bridge — `importer.py`

```
$ wc -l mojo/importer.py
184 mojo/importer.py
```

이 184줄이 하는 일:
1. Python `import` hook (`importlib.util.spec_from_file_location` 사용).
2. Python에서 `import some_mojo_dir`이 호출되면, 해당 디렉토리의 모든 `.mojo` 파일을 SHA256으로 해시.
3. `/tmp/.modular_<uid>/mojo_pkg/mojo_pkg_<hash>.mojopkg` 경로에 캐시(없으면 `subprocess_run_mojo("package", ...)`로 컴파일).
4. 그 `.mojopkg`를 Python 모듈처럼 등록.

→ **Python에서 .mojo 디렉토리를 직접 `import` 가능**. 변경 감지는 SHA256 해시 16자리 prefix.

### 단계 12. prelude/builtin은 어디 있나

```
$ ls modular/lib/mojo/ | grep -iE 'prelude|builtin'
(없음)

$ strings modular/bin/mojo 2>/dev/null | grep -E '^builtin\.' | head -5
builtin.dense_resource_elements
builtin.f6E2M3FN
builtin.vector
builtin.string
builtin.module

$ mojo build --help 2>&1 | grep -A3 -i prelude
--elaboration-error-include-prelude
    Show elaboration error with locations in mojo startup modules
    (prelude).
```

→ **prelude는 별도 .mojopkg가 아니라 컴파일러 ELF에 내장**. 추가로 `mojo package --disable-builtins` 옵션 존재 → builtin이 자동 주입되는 구조 확인.

## 3. 예상되는 결과

- stdlib는 어딘가의 디렉토리에 `.mojo` 소스로 있을 것 (Python처럼).
- 모듈 검색 경로는 환경변수 또는 설정 파일로 노출될 것.
- mojo CLI는 단일 ELF일 것 (Python과 달리 시스템 언어니까).
- prelude는 stdlib의 일부일 것.

## 4. 실제 결과

**예상이 모두 빗나감**:

| 예상 | 실제 |
|------|------|
| stdlib는 `.mojo` 소스 | **모두 `.mojopkg` (binary), 소스 0개** |
| 검색 경로는 env or config | env (`MODULAR_MOJO_MAX_IMPORT_PATH`) + CLI `-I <PATH>`. Wrapper Python이 자동 주입 |
| 단일 ELF | **Python wrapper(201B) → os.execve → ELF(135MB)** 2단 |
| prelude는 stdlib 일부 | **컴파일러 바이너리에 내장** (별도 .mojopkg 없음) |

## 5. 결론

### Python과의 비교 (이 사용자에게 가장 익숙한 모델)

| 항목 | Python | Mojo |
|------|--------|------|
| 모듈 검색 경로 | `sys.path` (런타임) | `MODULAR_MOJO_MAX_IMPORT_PATH` + `-I <PATH>` (**컴파일타임**) |
| 패키지 마커 | `__init__.py` | `__init__.mojo` |
| stdlib 형태 | `.py` 소스 + 일부 `.so` | **모두 `.mojopkg` (pre-compiled binary, portable)** |
| 자동 주입 | 없음 (모든 import 명시) | prelude/builtin 자동 주입 (컴파일러 내장) |
| 외부 호출 | `import`로 즉시 실행 가능 | AOT — 컴파일 시점에 결합 |
| 자기 컴파일 산출물 | `__pycache__/*.pyc` | `.mojopkg` |

### C++ 사용자 관점 매핑

| C++ | Mojo |
|-----|------|
| `-I <PATH>` (header search) | `-I <PATH>` (**같은 옵션 이름·의미**) |
| `.h` + `.a`/`.so` 분리 | `.mojopkg` 단일 — 헤더와 컴파일된 코드를 한 파일에 |
| Static lib (`.a`) | `.mojopkg`의 "non-elaborated code" 부분 (template 미인스턴스화 상태) |
| Template instantiation at use | "elaboration" at `mojo build` time |
| `<cstdio>` 명시 include | prelude 자동 주입 (`--disable-builtins`로 끌 수 있음) |
| 링커 (`ld`) 별도 | `lld` 동봉, `mojo`가 직접 호출 |

### 호출 흐름 요약 다이어그램

```
사용자: mojo run hello.mojo
   │
   ▼
.venv/bin/mojo  (201 byte Python 스크립트, shebang = .venv python3)
   │
   ▼  import mojo._entrypoints; exec_mojo()
mojo/_entrypoints.py  (Python 패키지 — 별개의 'mojo' 디렉토리)
   │     ├─ _mojo_env() → 4개 환경변수 셋업 (DRIVER_PATH, IMPORT_PATH, ...)
   │     └─ os.execve(MODULAR_MOJO_MAX_DRIVER_PATH, argv, env)   ← fork 없음, 프로세스 통째 교체
   │
   ▼  process replacement
modular/bin/mojo  (135 MB ELF compiler)
   │     prelude/builtin = 바이너리 내장
   │     사용자 import 해석:
   │       1) MODULAR_MOJO_MAX_IMPORT_PATH = modular/lib/mojo/  ← stdlib (.mojopkg 25개)
   │       2) `-I <PATH>` flag로 추가된 디렉토리들
   │       3) 같은 디렉토리의 .mojo / __init__.mojo / .mojopkg
   │
   ▼  컴파일 + 링크 (lld)
실행 (또는 build 시 ELF 산출)
```

### 학습 인사이트 5개

1. **stdlib 소스 비공개**: 25개 .mojopkg는 binary only. 학습용으로 stdlib 코드를 직접 보려면 별도로 GitHub modularml/mojo 레포(또는 docs)를 봐야 한다.
2. **Pre-compiled portable packages**: `.mojopkg`는 arch-agnostic. C++의 `.a`/`.o` 가 arch-specific인 것과 대조. trade-off: elaborate(monomorphization)을 use-site로 미룸 → 컴파일 타임이 길어짐 가능성.
3. **CLI 2단 구조의 이유**: Python wrapper는 단순한 launcher가 아니다 — 환경변수 자동 주입, conda/wheel 경로 탐색, importer hook 등록(Python에서 import 가능하게)의 책임. ELF만 단독으론 안 됨.
4. **`-I` flag 동일 의미**: C++ 개발자는 즉시 직관적으로 사용 가능. Python `sys.path`보다 C++ 모델에 더 가까움.
5. **`importer.py`의 존재**: Mojo는 Python에 *호출당하는* 길도 미리 깔아둠. `python -c "import my_mojo_dir"` 흐름이 즉시 가능.

### 후속 work 후보 (TODO Backlog 등재 권장)

- **(NEW) `.mojopkg` 내부 포맷 deeper dive**: `xxd`로 헤더 파싱, KGEN module 형태인지, MLIR bytecode인지. `--emit=llvm` (work 0004 발견)으로 elaborate 후 IR을 보면 상호 검증 가능.
- **(NEW) `import compiler`(compiler.mojopkg) 시도**: 컴파일러 자체가 노출됐다는 건 Mojo에 reflection/introspection API가 있다는 단서.
- **(NEW) 자작 패키지 + `__init__.mojo` 실험**: 작은 디렉토리 만들고 `mojo package` → 다른 파일에서 `import`까지 — 패키지 라이프사이클 1회전 검증.
- **(NEW) Python에서 .mojo 디렉토리 import**: `mojo.importer`를 sys.meta_path에 등록하는 방법 확인 + 실제 `import`로 SHA 캐시 동작 관찰.
- 기존 T-15(NumPy 호출)와 자연스럽게 연결됨 — Python interop 양방향 모두 다룸.

이 5개 후보는 다음 cycle에서 orchestrator가 issue로 일괄 등재.
