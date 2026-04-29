# 실험 4: Python 예외 → Mojo error 매핑 (MOJO-24)

from std.python import Python, PythonObject

fn divide_in_python(a: Int, b: Int) raises -> PythonObject:
    var op = Python.import_module("operator")
    return op.truediv(a, b)

fn main() raises:
    print("=== 4. Python 예외 ↔ Mojo error ===")
    print()

    print("[ZeroDivisionError]")
    try:
        var r = divide_in_python(10, 0)
        print("  결과 (잡혀야 할 곳에 도달):", r)
    except e:
        print("  caught:", e)

    print()
    print("[정상 케이스 (대조)]")
    try:
        print("  10/2 =", divide_in_python(10, 2))
    except e:
        print("  unexpected catch:", e)

    print()
    print("[KeyError]")
    var d = Python.dict()
    d["a"] = 1
    try:
        var v = d["nonexistent_key"]
        print("  잡혀야 할 곳에 도달:", v)
    except e:
        print("  caught:", e)

    print()
    print("[ValueError]")
    var builtins = Python.import_module("builtins")
    try:
        var n = builtins.int("not_a_number")
        print("  잡혀야 할 곳에 도달:", n)
    except e:
        print("  caught:", e)

    print()
    print("[AttributeError]")
    var math = Python.import_module("math")
    try:
        var x = math.nonexistent_function(1, 2)
        print("  잡혀야 할 곳에 도달:", x)
    except e:
        print("  caught:", e)
