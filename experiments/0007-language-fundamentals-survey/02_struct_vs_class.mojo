# MOJO-6: struct vs Python class — value semantics 검증

from std.python import Python

struct Point(Copyable):
    var x: Int
    var y: Int

    fn __init__(out self, x: Int, y: Int):
        self.x = x; self.y = y

    fn __copyinit__(out self, copy: Self):
        print("    [Point.__copyinit__ x=", copy.x, "y=", copy.y, "]")
        self.x = copy.x; self.y = copy.y

fn read_point(p: Point):
    print("  read_point sees x =", p.x)

fn main() raises:
    print("=== MOJO-6: struct(Mojo) vs class(Python) — value vs reference ===\n")

    print("[Mojo struct — value semantics]")
    var p1 = Point(10, 20)
    print("  p1 = Point(10, 20)")

    # 0.26: implicit copy는 ImplicitlyCopyable trait 필요. Copyable만 있으면 .copy() 명시
    var p2 = p1.copy()
    print("  var p2 = p1.copy()   ← __copyinit__ 호출 (명시적)")

    p2.x = 999
    print("  p2.x = 999 후:")
    print("    p1.x =", p1.x, "(영향 없음 ← value)")
    print("    p2.x =", p2.x)

    print("\n  read_point(p1)   ← read borrow, copy 안 일어남")
    read_point(p1)

    print("\n[Python class — reference semantics, 비교용]")
    var pyc = Python.evaluate("type('PyPoint', (), {'__init__': lambda s, x, y: setattr(s, 'x', x) or setattr(s, 'y', y)})")
    var pp1 = pyc(10, 20)
    var pp2 = pp1                        # 같은 객체 가리킴 (no copy)
    print("  pp1 = PyPoint(10, 20)")
    print("  pp2 = pp1")
    pp2.x = 999
    print("  pp2.x = 999 후:")
    print("    pp1.x =", pp1.x, "(같이 바뀜 ← reference)")
    print("    pp2.x =", pp2.x)

    print("\n[정리]")
    print("  Mojo struct: 대입은 __copyinit__ — 별개 인스턴스, value semantics (C++ struct과 동일)")
    print("  Python class: 대입은 reference 복사 — 같은 객체 공유")
