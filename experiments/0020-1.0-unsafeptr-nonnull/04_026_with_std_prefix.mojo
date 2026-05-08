from std.memory import UnsafePointer

def main():
    var xs: List[Int] = [10, 20, 30, 40, 50]
    var p = xs.unsafe_ptr()
    var sum: Int = 0
    var i: Int = 0
    while i < len(xs):
        sum += p[i]
        i += 1
    print("sum =", sum)
