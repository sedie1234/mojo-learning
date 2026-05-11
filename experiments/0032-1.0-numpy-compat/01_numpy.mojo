# NumPy 호환성 — ndarray 다루기, 변환 비용, zero-copy 가능성 검토
from std.python import Python, PythonObject
from std.time import perf_counter_ns

def main() raises:
    print("=== [1.0] NumPy 호환성 ===")

    var np = Python.import_module("numpy")
    print("numpy version:", np.__version__)

    # (a) np 객체 직접 사용
    var a = np.arange(10)
    print("np.arange(10):", a)
    var b = np.ones(Python.tuple(3, 3))
    print("np.ones((3,3)):")
    print(b)

    # (b) list → np.array 변환 비용 (work 0006 회귀)
    print()
    print("=== np.array(list) 변환 비용 ===")
    var sizes: List[Int] = [10, 100, 1000, 10000, 100000]
    for n in sizes:
        var py_list = Python.list()
        for i in range(n):
            py_list.append(i)
        var ts: List[Int] = []
        for _ in range(7):
            var t0 = perf_counter_ns()
            var arr = np.array(py_list)
            var t1 = perf_counter_ns()
            ts.append(Int(t1 - t0))
        sort(ts)
        var t = ts[3]
        print("N=", n, " median:", t, "ns   ns/elem:", t // (n + 1))

    # (c) ndarray dtype/shape 검사
    print()
    print("=== ndarray 속성 ===")
    var arr = np.arange(12).reshape(Python.tuple(3, 4))
    print("shape:", arr.shape)
    print("dtype:", arr.dtype)
    print("size:", arr.size)
    print("ndim:", arr.ndim)

    # (d) PyObject → Mojo native scalar 변환
    print()
    print("=== PyObject → Mojo Int 변환 ===")
    var py_val = arr.item(Python.tuple(1, 2))   # arr[1,2] = 6
    var mojo_val = Int(py=py_val)
    print("arr[1,2] = Int(py=", py_val, ") =", mojo_val)

    # (e) ndarray.tolist() — 양방향
    print()
    print("=== ndarray.tolist() (Python으로 양방향) ===")
    var lst = arr.tolist()
    print(lst)

    # (f) 연산 — vector op
    print()
    print("=== ndarray vector op ===")
    var x = np.arange(5, dtype=np.float32)
    var y = np.arange(5, dtype=np.float32)
    var z = x + y
    print("x + y =", z)
    print("dot(x,y) =", np.dot(x, y))
