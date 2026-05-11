from std.python import Python, PythonObject
from std.time import perf_counter_ns

def main() raises:
    print("=== [1.0] PyTorch (CPU) interop ===")

    var torch = Python.import_module("torch")
    print("torch version:", torch.__version__)
    print("CUDA available:", torch.cuda.is_available())

    # (a) tensor 생성 — Python.list() 명시 변환
    var row1 = Python.list()
    row1.append(1.0); row1.append(2.0)
    var row2 = Python.list()
    row2.append(3.0); row2.append(4.0)
    var data = Python.list()
    data.append(row1); data.append(row2)
    var a = torch.tensor(data)
    print("a =", a)
    print("a.shape:", a.shape)
    print("a.dtype:", a.dtype)

    # (b) tensor op
    var b = torch.ones(Python.tuple(2, 2))
    var c = a + b
    print("a + b =", c)

    # (c) matmul
    var d = torch.matmul(a, b)
    print("a @ b =", d)

    # (d) tensor scalar extract
    var py_val = c[0][0].item()
    var mojo_val = Float64(py=py_val)
    print("c[0][0] item:", mojo_val)

    # (e) nn.Linear forward
    var nn = Python.import_module("torch.nn")
    var linear = nn.Linear(4, 2)
    var x = torch.randn(Python.tuple(1, 4))
    var t0 = perf_counter_ns()
    var y = linear(x)
    var t1 = perf_counter_ns()
    print()
    print("Linear(4→2) forward:", Int(t1 - t0), "ns")
    print("y =", y)

    # (f) transformers
    print()
    var tfm = Python.import_module("transformers")
    print("transformers version:", tfm.__version__)
