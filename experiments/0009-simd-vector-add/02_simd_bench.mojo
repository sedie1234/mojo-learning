# MOJO-11: 벡터 add 벤치 — scalar / 명시적 SIMD16
# 0.26 closure 캡처 이슈 회피 위해 main에 완전 인라인

from std.time import perf_counter_ns

alias W: Int = 16     # AVX-512 native float32 width

fn main():
    print("=== MOJO-11: vector add (scalar vs explicit SIMD16) ===")
    print("alias W = 16 (AVX-512 native float32 lane count)")
    print()

    var sizes: List[Int] = [1024, 65536, 1048576, 16777216]
    for n in sizes:
        # alloc + 패턴 채우기
        var av = List[Float32](length=n, fill=Float32(0))
        var bv = List[Float32](length=n, fill=Float32(0))
        var cv = List[Float32](length=n, fill=Float32(0))
        for i in range(n):
            av[i] = 1.0 + Float32(i % 1000) * 0.01
            bv[i] = 2.0 + Float32(i % 1000) * 0.01
        var a = av.unsafe_ptr()
        var b = bv.unsafe_ptr()
        var c = cv.unsafe_ptr()

        # ── (a) scalar — warmup 3 + measure 10 ──
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

        # ── (b) explicit SIMD-16 ──
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
