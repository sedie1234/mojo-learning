from std.algorithm.functional import parallelize

def main():
    var n = 1024
    var xs = List[Int](length=n, fill=0)
    var p = xs.unsafe_ptr()

    def task(i: Int):    # capture list 없음 — 자동 capture?
        p[i] = i * i

    parallelize[task](n)

    var total = 0
    for i in range(n): total += xs[i]
    print("total =", total)
