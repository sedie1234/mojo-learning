# 1.0 명시 capture syntax 시도 — modular/skills 가이드: {mode name, mode name, ...}
# work 0024에서 미정복했던 부분
from std.algorithm.functional import parallelize

def main():
    var n = 1024
    var xs = List[Int](length=n, fill=0)
    var p = xs.unsafe_ptr()

    # 1.0 명시 capture syntax: arg list 다음 colon 앞에 {}
    # read = immutable borrow (default), mut = mutable, var = owned
    @parameter
    def task(i: Int) {read p, read n}:
        p[i] = i * (i + 1)

    parallelize[task](n)

    var total = 0
    for i in range(n): total += xs[i]
    print("total =", total)
    # expected: sum_{i=0}^{n-1} i*(i+1) = sum i^2 + sum i for i=0..n-1
    # n=1024: sum i^2 = 1023*1024*2047/6 = 357389824; sum i = 523776
    # total = 357913600
    print("expected: 357913600")
