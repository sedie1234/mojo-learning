from std.memory import UnsafePointer

def maybe_ptr(yes: Bool) -> Optional[UnsafePointer[Int, _]]:
    if yes:
        var x = UnsafePointer[Int].alloc(1)
        x[0] = 42
        return Optional[UnsafePointer[Int, _]](x)
    else:
        return None

def main():
    var a = maybe_ptr(True)
    var b = maybe_ptr(False)
    print("a is some?", Bool(a))
    print("b is some?", Bool(b))
    if a:
        var p = a.value()
        print("a.value()[0] =", p[0])
        p.free()
