# Python interop lifecycle (cold/warm import) — 0.26 work 0006 1.0 회귀
from std.python import Python, PythonObject
from std.time import perf_counter_ns

def main() raises:
    print("=== [1.0] Python interop lifecycle ===")

    # math cold (Py_Initialize 포함)
    var t0 = perf_counter_ns()
    var math = Python.import_module("math")
    var t1 = perf_counter_ns()
    print("math cold import:", Int(t1 - t0), "ns")

    # math 재import (sys.modules cache 사용 — warm)
    var ts: List[Int] = []
    for _ in range(5):
        var s = perf_counter_ns()
        var m2 = Python.import_module("math")
        var e = perf_counter_ns()
        ts.append(Int(e - s))
    sort(ts)
    print("math warm import (median of 5):", ts[2], "ns")

    # sys 첫 import (Py_Initialize는 끝났으니 모듈만)
    var t2 = perf_counter_ns()
    var sys = Python.import_module("sys")
    var t3 = perf_counter_ns()
    print("sys first import (after Py_Initialize):", Int(t3 - t2), "ns")

    # numpy cold
    var t4 = perf_counter_ns()
    var np = Python.import_module("numpy")
    var t5 = perf_counter_ns()
    print("numpy cold import:", Int(t5 - t4), "ns")

    # numpy warm
    var t6 = perf_counter_ns()
    var np2 = Python.import_module("numpy")
    var t7 = perf_counter_ns()
    print("numpy warm import:", Int(t7 - t6), "ns")

    print()
    print("=== Type 변환 (Python → Mojo) ===")
    var py_int = Python.evaluate("42")
    var mojo_int = Int(py=py_int)
    print("Int(py=42) =", mojo_int)

    var py_float = Python.evaluate("3.14")
    var mojo_float = Float64(py=py_float)
    print("Float64(py=3.14) =", mojo_float)

    var py_str = Python.evaluate("'hello'")
    var mojo_str = String(py=py_str)
    print("String(py='hello') =", mojo_str)

    print()
    print("=== 예외 통합 ===")
    try:
        var op = Python.import_module("operator")
        var r = op.truediv(10, 0)
        print("not reached")
    except e:
        print("caught:", e)
