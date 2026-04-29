# work 0010 — Mojo SIMD-16 vector add (JIT용 = `mojo run`, AOT용 = `mojo build` 같은 소스)

from std.time import perf_counter_ns

alias W: Int = 16     # AVX-512 native float32 width

fn run_size(n: Int):
    var av = List[Float32](length=n, fill=Float32(0))
    var bv = List[Float32](length=n, fill=Float32(0))
    var cv = List[Float32](length=n, fill=Float32(0))
    for i in range(n):
        av[i] = 1.0 + Float32(i % 1000) * 0.01
        bv[i] = 2.0 + Float32(i % 1000) * 0.01
    var a = av.unsafe_ptr()
    var b = bv.unsafe_ptr()
    var c = cv.unsafe_ptr()

    # warmup
    for _ in range(3):
        var i: Int = 0
        while i + W <= n:
            (c + i).store(a.load[width=W](i) + b.load[width=W](i))
            i += W
        while i < n:
            c[i] = a[i] + b[i]; i += 1

    # measure 10 + median
    var ts: List[Int] = []
    for _ in range(10):
        var t0 = perf_counter_ns()
        var i: Int = 0
        while i + W <= n:
            (c + i).store(a.load[width=W](i) + b.load[width=W](i))
            i += W
        while i < n:
            c[i] = a[i] + b[i]; i += 1
        var t1 = perf_counter_ns()
        ts.append(Int(t1 - t0))
    sort(ts)
    var t = ts[5]
    var bw = (3 * 4 * n) // (t + 1)
    print("N=", n, " median=", t, "ns   ns/elem=", t // n, "   bw=", bw, "GB/s")

fn main():
    print("=== Mojo SIMD16 (W=16, AVX-512) ===")
    run_size(1024)
    run_size(65536)
    run_size(1048576)
    run_size(16777216)
