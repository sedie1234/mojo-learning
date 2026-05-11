# SKILL.md 예시 그대로 — top-level def + capture {} after arg list
from std.algorithm.functional import parallelize

def main():
    var n = 1024
    var xs = List[Int](length=n, fill=0)
    var p = xs.unsafe_ptr()

    # capture list {read p}: p를 immutable borrow
    def task(i: Int) {read p}:
        p[i] = i * i

    parallelize[task](n)

    var total = 0
    for i in range(n): total += xs[i]
    print("total =", total)
    # n=1024: sum i^2 = 1023*1024*2047/6 = 357389824
    print("expected: 357389824")
