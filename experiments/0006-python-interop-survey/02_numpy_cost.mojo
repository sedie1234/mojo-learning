# 실험 2: NumPy 변환 비용 vs 크기 (MOJO-15)

from std.python import Python, PythonObject
from std.time import perf_counter_ns

fn measure_np_array(np: PythonObject, n: Int) raises -> Int:
    var lst = Python.list()
    for i in range(n):
        lst.append(i)

    # warmup 3 + measure 10, 중앙값(median)
    for _ in range(3):
        _ = np.array(lst)

    var times: List[Int] = []
    for _ in range(10):
        var t0 = perf_counter_ns()
        _ = np.array(lst)
        var t1 = perf_counter_ns()
        times.append(Int(t1 - t0))

    sort(times)
    return times[5]

fn main() raises:
    print("=== 2. NumPy np.array() 변환 비용 vs 크기 ===")
    var np = Python.import_module("numpy")
    _ = np.array(Python.list(1, 2, 3))   # numpy warmup

    print()
    print("size       | median ns       | ns/elem")
    print("-----------|-----------------|--------")

    var sizes: List[Int] = [10, 100, 1000, 10000, 100000]
    for s in sizes:
        var ns = measure_np_array(np, s)
        var per = ns // s
        print(s, "      ", ns, "      ", per)
