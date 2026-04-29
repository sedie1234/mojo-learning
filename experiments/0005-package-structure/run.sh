#!/bin/bash
# 0005 — Mojo 패키지/모듈 구조 추적 (실행 없이 ls/find/cat/grep)
# 사용자가 직접 한 명령씩 따라가서 같은 결과를 볼 수 있어야 한다.
#
# 사용법:
#   bash run.sh                  # 모든 단계 순차 실행
#   bash run.sh 1                # STEP 1만
#   source run.sh                # 함수만 노출 (수동 호출용)

VENV=/home/hwan/workspace/mojo/.venv
MOD=$VENV/lib/python3.12/site-packages/modular
MOJO_PYPKG=$VENV/lib/python3.12/site-packages/mojo

step1() {
    echo "=== STEP 1: mojo CLI 실체 ==="
    echo "$ ls -la $VENV/bin/mojo"
    ls -la $VENV/bin/mojo
    echo
    echo "$ file $VENV/bin/mojo"
    file $VENV/bin/mojo
    echo
    echo "$ cat $VENV/bin/mojo"
    cat $VENV/bin/mojo
    echo
    echo "→ 결론: 201바이트 Python 스크립트. 진짜 컴파일러는 modular/bin/mojo에 있음."
}

step2() {
    echo "=== STEP 2: modular 패키지 톱레벨 ==="
    echo "$ ls $MOD/"
    ls $MOD/
    echo
    echo "$ du -sh $MOD/*"
    du -sh $MOD/* 2>/dev/null | sort -hr
    echo
    echo "→ 결론: bin/ (293M, 컴파일러+도구) + lib/ (835M, 런타임+stdlib). 다른 톱레벨 디렉토리 없음."
}

step3() {
    echo "=== STEP 3: bin/ — 실제 컴파일러 + 동봉 도구 ==="
    echo "$ ls -la $MOD/bin/"
    ls -la $MOD/bin/
    echo
    echo "$ file $MOD/bin/mojo"
    file $MOD/bin/mojo
    echo
    echo "→ 결론: mojo (135M ELF, 컴파일러), lld (110M, LLVM 링커), lldb-* (디버거), llvm-symbolizer, mojo-lsp-server, gpu-query 등."
}

step4() {
    echo "=== STEP 4: lib/ 톱레벨 — 런타임 .so + stdlib 디렉토리 ==="
    echo "$ ls $MOD/lib/"
    ls $MOD/lib/
    echo
    echo "→ 결론: *.so 10개(런타임), 그리고 디렉토리들 (mojo/, mojo-repl-entry-point/, lldb-visualizers/, nixl/, nvshmem_*)"
}

step5() {
    echo "=== STEP 5: lib/mojo/ — stdlib 본체 (25개 .mojopkg) ==="
    echo "$ ls $MOD/lib/mojo/"
    ls $MOD/lib/mojo/
    echo
    echo "$ ls $MOD/lib/mojo/*.mojopkg | wc -l"
    ls $MOD/lib/mojo/*.mojopkg | wc -l
    echo
    echo "$ ls -la $MOD/lib/mojo/std.mojopkg"
    ls -la $MOD/lib/mojo/std.mojopkg
    echo
    echo "→ 결론: 모든 stdlib는 .mojopkg(pre-compiled binary)로만 배포됨. .mojo 소스는 0개 (find 검증됨)."
}

step6() {
    echo "=== STEP 6: .mojopkg 파일 시그니처 (magic number) ==="
    echo "$ xxd $MOD/lib/mojo/std.mojopkg | head -2"
    xxd $MOD/lib/mojo/std.mojopkg | head -2
    echo
    echo "→ 결론: ASCII 'MPKG' + 0x01 버전 바이트로 시작. 자체 포맷."
}

step7() {
    echo "=== STEP 7: mojo Python wrapper 패키지 ==="
    echo "$ ls $MOJO_PYPKG/"
    ls $MOJO_PYPKG/
    echo
    echo "$ cat $MOJO_PYPKG/_entrypoints.py"
    cat $MOJO_PYPKG/_entrypoints.py
    echo
    echo "→ 결론: bin/mojo Python 스크립트가 부르는 exec_mojo()는 os.execve로 modular/bin/mojo ELF에 'process replacement' (fork 안 함)."
}

step8() {
    echo "=== STEP 8: 환경변수 — _mojo_env() ==="
    echo "$ grep -E 'MODULAR_|MOJO_' $MOJO_PYPKG/run.py"
    grep -E 'MODULAR_|MOJO_' $MOJO_PYPKG/run.py
    echo
    cat <<'NOTE'
→ 결론 (4개 핵심 env):
   MODULAR_MAX_PACKAGE_ROOT      = <modular/>
   MODULAR_MOJO_MAX_PACKAGE_ROOT = <modular/>
   MODULAR_MOJO_MAX_DRIVER_PATH  = <modular/bin/mojo>   ← 실제 컴파일러
   MODULAR_MOJO_MAX_IMPORT_PATH  = <modular/lib/mojo>   ← stdlib 검색 경로 (★)
NOTE
}

step9() {
    echo "=== STEP 9: get_package_root() 알고리즘 ==="
    echo "$ cat $MOJO_PYPKG/_package_root.py"
    cat $MOJO_PYPKG/_package_root.py
    echo
    echo "→ 결론: wheel 우선 (modular/bin/mojo 존재 검사) → conda → VIRTUAL_ENV. wheel 우선이 중요 (안 그러면 wrapper script self-loop)."
}

step10() {
    echo "=== STEP 10: import 검색 경로 (mojo build/package -I) ==="
    source $VENV/bin/activate
    echo "$ mojo build --help 2>&1 | grep -B0 -A3 -- '-I'"
    mojo build --help 2>&1 | grep -B0 -A3 -- '-I'
    echo
    echo "$ mojo package --help 2>&1 | sed -n '12,22p'"
    mojo package --help 2>&1 | sed -n '12,22p'
    echo
    echo "→ 결론: -I <PATH>가 import 검색 경로 추가 (C++ -I와 동일). __init__.mojo가 디렉토리 패키지 마커 (Python __init__.py와 동일)."
}

step11() {
    echo "=== STEP 11: Python ↔ Mojo bridge — importer.py ==="
    echo "$ wc -l $MOJO_PYPKG/importer.py"
    wc -l $MOJO_PYPKG/importer.py
    echo
    echo "$ grep -E 'def |class ' $MOJO_PYPKG/importer.py"
    grep -E 'def |class ' $MOJO_PYPKG/importer.py
    echo
    echo "→ 결론: 184줄 짜리 Python import hook. Python에서 .mojo 폴더 import 시 SHA256 해시로 임시 .mojopkg 컴파일 후 spec_from_file_location 등록."
}

step12() {
    echo "=== STEP 12: prelude / builtin 위치 ==="
    echo "$ ls $MOD/lib/mojo/ | grep -i prelude"
    ls $MOD/lib/mojo/ | grep -iE 'prelude|builtin' || echo '(없음)'
    echo
    echo "$ strings $MOD/bin/mojo | grep -E '^builtin\\.' | head -10"
    strings $MOD/bin/mojo 2>/dev/null | grep -E '^builtin\.' | head -10
    echo
    echo "$ mojo build --help 2>&1 | grep -A3 -i prelude"
    source $VENV/bin/activate
    mojo build --help 2>&1 | grep -A3 -i prelude
    echo
    echo "→ 결론: prelude/builtin은 별도 .mojopkg가 아니라 컴파일러 ELF에 내장. --disable-builtins 옵션 + --elaboration-error-include-prelude 옵션이 그 증거."
}

# ── 본 실행 ──
if [ -n "$1" ]; then
    step$1
else
    for n in 1 2 3 4 5 6 7 8 9 10 11 12; do
        step$n
        echo
    done
fi
