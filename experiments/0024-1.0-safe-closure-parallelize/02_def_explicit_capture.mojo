# 1.0 패턴 시도 — @parameter def + 명시 capture list
from std.time import perf_counter_ns
from std.algorithm.functional import parallelize

def main():
    var n = 1000
    var sums = List[Int](length=n, fill=0)
    var p = sums.unsafe_ptr()

    @parameter
    def task(i: Int):
        var s = 0
        for j in range(1, 1001):
            s += i * j
        p[i] = s

    parallelize[task](n)
    var total = 0
    for i in range(n): total += sums[i]
    print("total =", total)
