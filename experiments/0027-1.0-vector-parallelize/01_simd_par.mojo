from std.time import perf_counter_ns
from std.algorithm.functional import parallelize

comptime W: Int = 16

def main():
    print("=== [1.0] vector add: SIMD16 single-thread vs SIMD16+parallelize ===")
    var sizes: List[Int] = [1048576, 16777216, 67108864]
    for n in sizes:
        var av = List[Float32](length=n, fill=Float32(0))
        var bv = List[Float32](length=n, fill=Float32(0))
        var cv = List[Float32](length=n, fill=Float32(0))
        for i in range(n):
            av[i] = 1.0 + Float32(i % 1000) * 0.01
            bv[i] = 2.0 + Float32(i % 1000) * 0.01
        var a = av.unsafe_ptr()
        var b = bv.unsafe_ptr()
        var c = cv.unsafe_ptr()

        # (a) single-thread SIMD16
        @parameter
        def run_single():
            var i: Int = 0
            while i + W <= n:
                (c + i).store(a.load[width=W](i) + b.load[width=W](i))
                i += W
            while i < n:
                c[i] = a[i] + b[i]; i += 1

        # (b) parallelize: chunks across cores
        comptime NUM_CHUNKS = 16
        var chunk = (n + NUM_CHUNKS - 1) // NUM_CHUNKS

        @parameter
        def chunk_task(idx: Int):
            var start = idx * chunk
            var stop = min(start + chunk, n)
            var i = start
            while i + W <= stop:
                (c + i).store(a.load[width=W](i) + b.load[width=W](i))
                i += W
            while i < stop:
                c[i] = a[i] + b[i]; i += 1

        @parameter
        def run_par():
            parallelize[chunk_task](NUM_CHUNKS)

        # measure single
        for _ in range(3): run_single()
        var ts_s: List[Int] = []
        for _ in range(10):
            var t0 = perf_counter_ns(); run_single(); var t1 = perf_counter_ns()
            ts_s.append(Int(t1 - t0))
        sort(ts_s); var t_s = ts_s[5]

        # measure par
        for _ in range(3): run_par()
        var ts_p: List[Int] = []
        for _ in range(10):
            var t0 = perf_counter_ns(); run_par(); var t1 = perf_counter_ns()
            ts_p.append(Int(t1 - t0))
        sort(ts_p); var t_p = ts_p[5]

        var bw_s = (3 * 4 * n) // (t_s + 1)
        var bw_p = (3 * 4 * n) // (t_p + 1)
        print("N=", n, "  single:", t_s, "ns (", bw_s, "GB/s)   par16:", t_p,
              "ns (", bw_p, "GB/s)   speedup:", t_s // (t_p + 1), "x")
