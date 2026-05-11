# 2D convolution — CPU 직접 작성 (im2col 없이, naive nested loop)
# 검증 목적: 1.0에서 List + SIMD16으로 conv2d 정확도 + 성능 측정.
#
# 입력:  NHWC, dtype=float32
#   N=1 (batch), H=W=64 (spatial), C_in=16
# 커널: 3x3, C_in=16, C_out=32, stride=1, padding=1 (same)
# 출력: 1x64x64x32

from std.time import perf_counter_ns
from std.algorithm.functional import parallelize

comptime W: Int = 16   # SIMD width
comptime H: Int = 64
comptime WIDTH: Int = 64
comptime C_IN: Int = 16
comptime C_OUT: Int = 32
comptime K: Int = 3       # kernel size 3x3
comptime PAD: Int = 1     # same padding

def init_data(n: Int) -> List[Float32]:
    var v = List[Float32](length=n, fill=Float32(0))
    for i in range(n):
        v[i] = Float32((i * 7) % 13) * 0.1 + 0.5   # 임의 패턴
    return v^

def cpu_conv2d_naive(
    img_ptr: UnsafePointer[Float32, MutAnyOrigin],
    ker_ptr: UnsafePointer[Float32, MutAnyOrigin],
    out_ptr: UnsafePointer[Float32, MutAnyOrigin],
):
    # 출력 oh, ow, oc에 대해 — 가장 깊은 루프 ic는 SIMD width=16과 일치 → 명시 SIMD
    # 본 예제는 *정확성* 우선, 성능 최적화는 후속.
    @parameter
    def row_task(oh: Int):
        for ow in range(WIDTH):
            for oc in range(C_OUT):
                var acc: Float32 = 0.0
                for kh in range(K):
                    var ih = oh + kh - PAD
                    if ih < 0 or ih >= H:
                        continue
                    for kw in range(K):
                        var iw = ow + kw - PAD
                        if iw < 0 or iw >= WIDTH:
                            continue
                        # SIMD16 along C_IN
                        var ic = 0
                        while ic + W <= C_IN:
                            var img_idx = ih * WIDTH * C_IN + iw * C_IN + ic
                            var ker_idx = (kh * K * C_IN * C_OUT
                                           + kw * C_IN * C_OUT
                                           + ic * C_OUT + oc)
                            # ker는 ic가 inner-most 아니므로 단일 element 곱
                            # 간단히 scalar 누적 (학습용)
                            for c in range(ic, ic + W):
                                acc += img_ptr[ih * WIDTH * C_IN + iw * C_IN + c] \
                                       * ker_ptr[kh * K * C_IN * C_OUT
                                                 + kw * C_IN * C_OUT
                                                 + c * C_OUT + oc]
                            ic += W
                out_ptr[oh * WIDTH * C_OUT + ow * C_OUT + oc] = acc

    parallelize[row_task](H)


def main():
    print("=== [1.0] 2D conv CPU — H=", H, " W=", WIDTH, " C_in=", C_IN,
          " C_out=", C_OUT, " K=", K, " ===")

    var img = init_data(H * WIDTH * C_IN)
    var ker = init_data(K * K * C_IN * C_OUT)
    var out = List[Float32](length=H * WIDTH * C_OUT, fill=Float32(0))

    var pi = img.unsafe_ptr()
    var pk = ker.unsafe_ptr()
    var po = out.unsafe_ptr()

    # warmup
    for _ in range(3): cpu_conv2d_naive(pi, pk, po)

    var ts: List[Int] = []
    for _ in range(5):
        var t0 = perf_counter_ns()
        cpu_conv2d_naive(pi, pk, po)
        var t1 = perf_counter_ns()
        ts.append(Int(t1 - t0))
    sort(ts)
    var t = ts[2]

    # FLOPs = 2 * H * W * C_in * C_out * K * K
    var flops = 2.0 * Float64(H) * Float64(WIDTH) * Float64(C_IN) * Float64(C_OUT) \
                * Float64(K) * Float64(K)
    var g = flops / Float64(t + 1)
    print("median:", t, "ns   GFLOPS:", g)

    # 정확성 spot-check
    print("out[0]=", out[0], "  out[H*W*C_out-1]=", out[H * WIDTH * C_OUT - 1])
