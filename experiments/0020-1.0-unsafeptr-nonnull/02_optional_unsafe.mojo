from memory import UnsafePointer

def maybe_ptr(yes: Bool) -> Optional[UnsafePointer[Int]]:
    if yes:
        var x = UnsafePointer[Int].alloc(1)
        x[0] = 42
        return Optional[UnsafePointer[Int]](x)
    else:
        return None

def main():
    var a = maybe_ptr(True)
    var b = maybe_ptr(False)
    print("a is some?", a.__bool__())
    print("b is some?", b.__bool__())
    if a:
        var p = a.value()
        print("a.value()[0] =", p[0])
        p.free()
