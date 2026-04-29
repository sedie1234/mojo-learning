# work 0013 — Mojo blocked matmul + SIMD16 + parallelize

from std.time import perf_counter_ns
from std.algorithm.functional import parallelize

alias W: Int = 16
alias BM: Int = 64
alias BK: Int = 64
alias BN: Int = 128

fn run_size(n: Int):
    var av = List[Float32](length=n*n, fill=Float32(0))
    var bv = List[Float32](length=n*n, fill=Float32(0))
    var cv = List[Float32](length=n*n, fill=Float32(0))
    for i in range(n*n):
        av[i] = 1.0 + Float32(i) * 0.001
        bv[i] = 2.0 + Float32(i) * 0.001
    var a = av.unsafe_ptr()
    var b = bv.unsafe_ptr()
    var c = cv.unsafe_ptr()

    # blocked matmul, ii row-block을 코어 분배
    @parameter
    fn block_row(ii_index: Int):
        var ii = ii_index * BM
        for jj in range(0, n, BN):
            for kk in range(0, n, BK):
                var iend = min(ii + BM, n)
                var jend = min(jj + BN, n)
                var kend = min(kk + BK, n)
                for i in range(ii, iend):
                    for k in range(kk, kend):
                        var va_s = a[i*n + k]
                        var va = SIMD[DType.float32, W](va_s)
                        var j = jj
                        while j + W <= jend:
                            var vb = (b + k*n + j).load[width=W]()
                            var vc = (c + i*n + j).load[width=W]()
                            (c + i*n + j).store(vc + va * vb)
                            j += W
                        while j < jend:
                            c[i*n + j] += va_s * b[k*n + j]; j += 1

    @parameter
    fn run():
        for i in range(n*n): c[i] = 0
        var num_blocks = (n + BM - 1) // BM
        parallelize[block_row](num_blocks)

    for _ in range(3): run()
    var ts: List[Int] = []
    for _ in range(10):
        var t0 = perf_counter_ns(); run(); var t1 = perf_counter_ns()
        ts.append(Int(t1 - t0))
    sort(ts)
    var t = ts[5]
    var flops = 2.0 * Float64(n) * Float64(n) * Float64(n)
    var g = flops / Float64(t + 1)
    print("N=", n, "  median=", t, "ns  GFLOPS=", g)

fn main():
    print("=== Mojo blocked matmul (BM=", BM, " BK=", BK, " BN=", BN, ") + SIMD16 + parallelize ===")
    run_size(512)
    run_size(1024)
    run_size(2048)
