from std.algorithm.functional import parallelize

def main():
    var n = 1000
    var sums = List[Int](length=n, fill=0)
    var p = sums.unsafe_ptr()

    # 1.0 명시 capture list — release notes: "capture lists {...}"
    @parameter
    def task[capture: {p}](i: Int):
        var s = 0
        for j in range(1, 1001):
            s += i * j
        p[i] = s

    parallelize[task](n)
    var total = 0
    for i in range(n): total += sums[i]
    print("total =", total)
