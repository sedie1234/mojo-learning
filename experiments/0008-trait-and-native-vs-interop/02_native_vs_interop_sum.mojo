# MOJO-16: Python 모듈 import vs Mojo native — 동일 알고리즘 비용 차
#
# ★ 알고리즘 변경 메모: 처음엔 sum(0..N-1)로 짰으나, Mojo 컴파일러(-O3 default)가
#   가우스 합 공식 n*(n-1)/2로 closed-form 축약 → 모든 N에서 20 ns 고정.
#   진짜 O(N) 루프 비용을 보려면 fold 불가능한 연산이 필요. → XOR로 교체.
#   XOR도 0..n-1에 대해 4-주기 closed-form이 있지만 LLVM은 인식하지 않음.
#
# 비교 대상 3종 (모두 XOR over 0..N-1):
#   (a) Mojo native — for 루프 + total ^= i
#   (b) Python via interop — functools.reduce(operator.xor, range(N))
#   (c) Python via interop — numpy.bitwise_xor.reduce(np.arange(N))   ← C-impl baseline

from std.python import Python, PythonObject
from std.time import perf_counter_ns

fn xor_native(n: Int) -> Int:
    var total: Int = 0
    for i in range(n):
        total ^= i
    return total

fn xor_python_pure(reduce_fn: PythonObject, op_xor: PythonObject,
                   builtins: PythonObject, n: Int) raises -> Int:
    return Int(py=reduce_fn(op_xor, builtins.range(n), 0))

fn xor_python_numpy(np: PythonObject, n: Int) raises -> Int:
    return Int(py=np.bitwise_xor.reduce(np.arange(n)))

fn measure_native(n: Int, mut sink: Int) -> Int:
    for _ in range(3): sink ^= xor_native(n)
    var ts: List[Int] = []
    for _ in range(10):
        var t0 = perf_counter_ns()
        var r = xor_native(n)
        var t1 = perf_counter_ns()
        ts.append(Int(t1 - t0))
        sink ^= r              # 결과를 외부에서 사용 → fold 방지
    sort(ts); return ts[5]

fn measure_pure(reduce_fn: PythonObject, op_xor: PythonObject,
                builtins: PythonObject, n: Int, mut sink: Int) raises -> Int:
    for _ in range(3): sink ^= xor_python_pure(reduce_fn, op_xor, builtins, n)
    var ts: List[Int] = []
    for _ in range(10):
        var t0 = perf_counter_ns()
        var r = xor_python_pure(reduce_fn, op_xor, builtins, n)
        var t1 = perf_counter_ns()
        ts.append(Int(t1 - t0))
        sink ^= r
    sort(ts); return ts[5]

fn measure_numpy(np: PythonObject, n: Int, mut sink: Int) raises -> Int:
    for _ in range(3): sink ^= xor_python_numpy(np, n)
    var ts: List[Int] = []
    for _ in range(10):
        var t0 = perf_counter_ns()
        var r = xor_python_numpy(np, n)
        var t1 = perf_counter_ns()
        ts.append(Int(t1 - t0))
        sink ^= r
    sort(ts); return ts[5]

fn main() raises:
    print("=== MOJO-16: native vs Python interop (동일 알고리즘 = XOR over 0..N-1) ===")
    print()

    var builtins = Python.import_module("builtins")
    var functools = Python.import_module("functools")
    var operator = Python.import_module("operator")
    var np = Python.import_module("numpy")
    var reduce_fn = functools.reduce
    var op_xor = operator.xor

    var sink: Int = 0     # fold 방지용 외부 sink

    print("N             | Mojo native ns | Python pure ns | NumPy ns        | pure/native  | numpy/native")
    print("--------------|----------------|----------------|-----------------|--------------|--------------")

    var sizes: List[Int] = [1000, 100_000, 10_000_000]
    for n in sizes:
        var t_n = measure_native(n, sink)
        var t_p = measure_pure(reduce_fn, op_xor, builtins, n, sink)
        var t_np = measure_numpy(np, n, sink)
        print(n,
              "    ", t_n,
              "    ", t_p,
              "    ", t_np,
              "    ", t_p // (t_n + 1),
              "  ", t_np // (t_n + 1))

    # sink가 죽지 않도록 print
    print("\n[sink 출력으로 dead-code 제거 방지] sink =", sink)
