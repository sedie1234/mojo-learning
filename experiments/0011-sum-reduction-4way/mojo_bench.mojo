# work 0011 — Mojo SIMD16 sum reduction
from std.time import perf_counter_ns

alias W: Int = 16

fn run_size(n: Int):
    var av = List[Float32](length=n, fill=Float32(0))
    for i in range(n):
        av[i] = 1.0 + Float32(i % 1000) * 0.01
    var a = av.unsafe_ptr()

    var sink: Float32 = 0.0  # dead-code 방지

    # warmup
    for _ in range(3):
        var acc = SIMD[DType.float32, W](0.0)
        var i: Int = 0
        while i + W <= n:
            acc += a.load[width=W](i)
            i += W
        var total: Float32 = acc.reduce_add()
        while i < n:
            total += a[i]; i += 1
        sink += total

    var ts: List[Int] = []
    for _ in range(10):
        var t0 = perf_counter_ns()
        var acc = SIMD[DType.float32, W](0.0)
        var i: Int = 0
        while i + W <= n:
            acc += a.load[width=W](i)
            i += W
        var total: Float32 = acc.reduce_add()
        while i < n:
            total += a[i]; i += 1
        var t1 = perf_counter_ns()
        ts.append(Int(t1 - t0))
        sink += total

    sort(ts)
    var t = ts[5]
    var bw = (4 * n) // (t + 1)
    print("N=", n, " median=", t, "ns  ns/elem=", Float64(t) / Float64(n), "  bw=", bw, "GB/s  (sink=", sink, ")")

fn main():
    print("=== Mojo SIMD16 sum reduction ===")
    run_size(65536)
    run_size(1048576)
    run_size(16777216)
