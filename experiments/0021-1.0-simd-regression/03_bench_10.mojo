from std.time import perf_counter_ns

comptime W: Int = 16

def main():
    print("=== [1.0] vector add (scalar vs explicit SIMD16) ===")
    print("comptime W = 16 (AVX-512 native float32 lane count)")
    print()

    var sizes: List[Int] = [1024, 65536, 1048576, 16777216]
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

        for _ in range(3):
            for i in range(n): c[i] = a[i] + b[i]
        var ts_s: List[Int] = []
        for _ in range(10):
            var t0 = perf_counter_ns()
            for i in range(n): c[i] = a[i] + b[i]
            var t1 = perf_counter_ns()
            ts_s.append(Int(t1 - t0))
        sort(ts_s)
        var t_s = ts_s[5]

        for _ in range(3):
            var i: Int = 0
            while i + W <= n:
                (c + i).store(a.load[width=W](i) + b.load[width=W](i))
                i += W
            while i < n:
                c[i] = a[i] + b[i]; i += 1
        var ts_v: List[Int] = []
        for _ in range(10):
            var t0 = perf_counter_ns()
            var i: Int = 0
            while i + W <= n:
                (c + i).store(a.load[width=W](i) + b.load[width=W](i))
                i += W
            while i < n:
                c[i] = a[i] + b[i]; i += 1
            var t1 = perf_counter_ns()
            ts_v.append(Int(t1 - t0))
        sort(ts_v)
        var t_v = ts_v[5]

        var bw_simd = (3 * 4 * n) // (t_v + 1)
        print("N=", n, " scalar:", t_s, "ns   simd16:", t_v, "ns   ratio:", t_s // (t_v + 1),
              "  bw(simd16):", bw_simd, "GB/s")
