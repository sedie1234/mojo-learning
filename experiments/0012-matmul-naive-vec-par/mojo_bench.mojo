# work 0012 — Mojo matmul: naive / 명시 SIMD16 / parallelize
# UnsafePointer를 함수 인자로 넘기면 mut 추론 안 됨 → 모두 인라인

from std.time import perf_counter_ns
from std.algorithm.functional import parallelize

alias W: Int = 16

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

    # ── (a) naive ──
    @parameter
    fn run_naive():
        for i in range(n):
            for j in range(n):
                var s: Float32 = 0
                for k in range(n):
                    s += a[i*n + k] * b[k*n + j]
                c[i*n + j] = s

    # ── (b) 명시 SIMD16: i,k 외부 / j 내부 ──
    @parameter
    fn run_simd():
        for i in range(n):
            for j in range(n): c[i*n + j] = 0
            for k in range(n):
                var va_s = a[i*n + k]
                var va = SIMD[DType.float32, W](va_s)
                var j: Int = 0
                while j + W <= n:
                    var vb = (b + k*n + j).load[width=W]()
                    var vc = (c + i*n + j).load[width=W]()
                    (c + i*n + j).store(vc + va * vb)
                    j += W
                while j < n:
                    c[i*n + j] += va_s * b[k*n + j]; j += 1

    # ── (c) SIMD16 + parallelize (row 단위) ──
    @parameter
    fn row(i: Int):
        for j in range(n): c[i*n + j] = 0
        for k in range(n):
            var va_s = a[i*n + k]
            var va = SIMD[DType.float32, W](va_s)
            var j: Int = 0
            while j + W <= n:
                var vb = (b + k*n + j).load[width=W]()
                var vc = (c + i*n + j).load[width=W]()
                (c + i*n + j).store(vc + va * vb)
                j += W
            while j < n:
                c[i*n + j] += va_s * b[k*n + j]; j += 1

    @parameter
    fn run_par():
        parallelize[row](n)

    # ── 측정 ──
    var t_n: Int = 0
    if n <= 256:
        for _ in range(2): run_naive()
        var ts: List[Int] = []
        for _ in range(5):
            var t0 = perf_counter_ns(); run_naive(); var t1 = perf_counter_ns()
            ts.append(Int(t1 - t0))
        sort(ts); t_n = ts[2]

    for _ in range(3): run_simd()
    var ts_s: List[Int] = []
    for _ in range(10):
        var t0 = perf_counter_ns(); run_simd(); var t1 = perf_counter_ns()
        ts_s.append(Int(t1 - t0))
    sort(ts_s); var t_s = ts_s[5]

    for _ in range(3): run_par()
    var ts_p: List[Int] = []
    for _ in range(10):
        var t0 = perf_counter_ns(); run_par(); var t1 = perf_counter_ns()
        ts_p.append(Int(t1 - t0))
    sort(ts_p); var t_p = ts_p[5]

    var flops = 2.0 * Float64(n) * Float64(n) * Float64(n)
    var g_n = flops / Float64(t_n + 1) if t_n > 0 else 0.0
    var g_s = flops / Float64(t_s + 1)
    var g_p = flops / Float64(t_p + 1)
    if t_n > 0:
        print("N=", n, "  naive=", t_n, "ns (", g_n, "GFLOPS)   simd16=", t_s,
              "ns (", g_s, "GFLOPS)   par=", t_p, "ns (", g_p, "GFLOPS)")
    else:
        print("N=", n, "  naive=(skipped, too slow)   simd16=", t_s,
              "ns (", g_s, "GFLOPS)   par=", t_p, "ns (", g_p, "GFLOPS)")

fn main():
    print("=== Mojo matmul: naive / SIMD16 / parallelize ===")
    run_size(128)
    run_size(256)
    run_size(512)
    run_size(1024)
