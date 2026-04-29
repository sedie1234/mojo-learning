# 실험 3: PyObject ↔ Mojo native 타입 변환 (MOJO-23)

from std.python import Python

fn main() raises:
    print("=== 3. PyObject ↔ Mojo native 타입 변환 ===")
    print()
    var builtins = Python.import_module("builtins")

    print("[Int]")
    var mojo_int: Int = 42
    var py_from_mojo = builtins.int(mojo_int)
    print("  Mojo Int → Python int:     ", py_from_mojo, " type:", builtins.type(py_from_mojo))

    var py_int = builtins.int(99)
    var mojo_from_py = Int(py=py_int)            # 키워드 only — 0.26 API
    print("  Python int → Mojo Int:     ", mojo_from_py)

    print()
    print("[Float64]")
    var mojo_f: Float64 = 3.14
    var py_f = builtins.float(mojo_f)
    print("  Mojo Float64 → Python float:", py_f)
    var py_f2 = builtins.float(2.71)
    var mojo_f2 = Float64(py=py_f2)
    print("  Python float → Mojo Float64:", mojo_f2)

    print()
    print("[String]")
    var mojo_s = String("hello mojo")
    var py_s = builtins.str(mojo_s)
    print("  Mojo String → Python str:   ", py_s, " len:", builtins.len(py_s))
    var py_s2 = builtins.str("from python")
    var mojo_s2 = String(py=py_s2)
    print("  Python str → Mojo String:   ", mojo_s2)

    print()
    print("[List]")
    var pylist = Python.list(1, 2, 3, 4, 5)
    print("  Python list 직접 사용:      ", pylist, " len:", builtins.len(pylist))
    pylist.append(99)
    print("  pylist.append(99) 후:       ", pylist)

    var native_list: List[Int] = [10, 20, 30]
    var py_from_native = Python.list()
    for v in native_list:
        py_from_native.append(v)
    print("  Mojo List[Int] → Python list:", py_from_native)

    print()
    print("[자동 변환 (Mojo native → Python 함수 인자)]")
    var math = Python.import_module("math")
    print("  math.sqrt(Mojo Int 16):     ", math.sqrt(16))
    print("  math.pow(2, 10):            ", math.pow(2, 10))
    print("  math.cos(Mojo Float64 0.0): ", math.cos(Float64(0.0)))
