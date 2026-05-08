#!/bin/bash
set -u
cd "$(dirname "$0")"
source ../../.venv-1.0/bin/activate
echo "=== Mojo version ==="
mojo --version
echo ""
echo "=== 01_hello_026.mojo (fn 사용) — JIT ==="
mojo run 01_hello_026.mojo 2>&1
echo ""
echo "=== 01_hello_026.mojo — AOT build ==="
mojo build 01_hello_026.mojo -o hello_026 2>&1
ls -l hello_026 2>/dev/null
./hello_026 2>&1
echo ""
echo "=== 02_hello_def.mojo (def 사용) — JIT ==="
mojo run 02_hello_def.mojo 2>&1
