# CPU bounds checking default ON.
# 같은 합 reduction을 (a) List 직접 subscript와 (b) unsafe_ptr 둘로 측정.
from std.time import perf_counter_ns

def main():
    var sizes: List[Int] = [1024, 65536, 1048576, 16777216]
    for n in sizes:
        var xs = List[Int](length=n, fill=0)
        for i in range(n): xs[i] = i

        # (a) List subscript (bounds-checked)
        var ts_sub: List[Int] = []
        for _ in range(3):
            var s = 0
            for i in range(n): s += xs[i]
        for _ in range(10):
            var s = 0
            var t0 = perf_counter_ns()
            for i in range(n): s += xs[i]
            var t1 = perf_counter_ns()
            ts_sub.append(Int(t1 - t0))
            if s == -1: print(s)  # sink
        sort(ts_sub)
        var t_sub = ts_sub[5]

        # (b) unsafe_ptr (no bounds check)
        var p = xs.unsafe_ptr()
        var ts_uns: List[Int] = []
        for _ in range(3):
            var s = 0
            for i in range(n): s += p[i]
        for _ in range(10):
            var s = 0
            var t0 = perf_counter_ns()
            for i in range(n): s += p[i]
            var t1 = perf_counter_ns()
            ts_uns.append(Int(t1 - t0))
            if s == -1: print(s)  # sink
        sort(ts_uns)
        var t_uns = ts_uns[5]

        var overhead_pct = ((t_sub - t_uns) * 100) // (t_uns + 1)
        print("N=", n, " subscript:", t_sub, "ns   unsafe:", t_uns, "ns   overhead:", overhead_pct, "%")
