# 2D convolution — GPU 버전 (modular/skills 패턴)
# CPU only 머신에서는 컴파일 자체 불가 (work 0028 결과). 문서 가치만.
# GPU 머신에서: 1 thread = 1 output (oh, ow) 패턴, oc loop는 thread 내부.

from std.sys import has_accelerator

def main() raises:
    comptime if not has_accelerator():
        print("[GPU conv2d] No GPU — execution skipped.")
    else:
        from std.math import ceildiv
        from std.gpu import thread_idx, block_idx
        from std.gpu.host import DeviceContext
        from layout import TileTensor, TensorLayout, row_major

        comptime dtype = DType.float32
        comptime H = 64
        comptime W = 64
        comptime C_IN = 16
        comptime C_OUT = 32
        comptime KSZ = 3        # 'K' 변수명은 일반적으로 사용 — 충돌 회피 위해 KSZ
        comptime PAD = 1
        comptime BLOCK_H = 8
        comptime BLOCK_W = 8

        # Layouts: input/output NHWC (N=1 omitted), kernel KKxCinxCout
        comptime img_layout = row_major[H, W, C_IN]()
        comptime ker_layout = row_major[KSZ, KSZ, C_IN, C_OUT]()
        comptime out_layout = row_major[H, W, C_OUT]()

        # 'out'은 Mojo 1.0 예약어이므로 argument 이름 'output' 사용
        def conv2d_kernel[
            ImgL: TensorLayout, KerL: TensorLayout, OutL: TensorLayout,
        ](
            img: TileTensor[dtype, ImgL, MutAnyOrigin],
            ker: TileTensor[dtype, KerL, MutAnyOrigin],
            output: TileTensor[dtype, OutL, MutAnyOrigin],
        ):
            comptime assert img.flat_rank == 3
            comptime assert ker.flat_rank == 4
            comptime assert output.flat_rank == 3

            var oh = block_idx.y * BLOCK_H + thread_idx.y
            var ow = block_idx.x * BLOCK_W + thread_idx.x

            if oh >= H or ow >= W:
                return

            for oc in range(C_OUT):
                var acc: Scalar[dtype] = 0.0
                comptime for kh in range(KSZ):
                    var ih = oh + kh - PAD
                    if ih < 0 or ih >= H:
                        continue
                    comptime for kw in range(KSZ):
                        var iw = ow + kw - PAD
                        if iw < 0 or iw >= W:
                            continue
                        for ic in range(C_IN):
                            var img_v = rebind[Scalar[dtype]](img[ih, iw, ic])
                            var ker_v = rebind[Scalar[dtype]](ker[kh, kw, ic, oc])
                            acc += img_v * ker_v
                output[oh, ow, oc] = rebind[output.ElementType](acc)

        var ctx = DeviceContext()
        var img_buf = ctx.enqueue_create_buffer[dtype](H * W * C_IN)
        var ker_buf = ctx.enqueue_create_buffer[dtype](KSZ * KSZ * C_IN * C_OUT)
        var out_buf = ctx.enqueue_create_buffer[dtype](H * W * C_OUT)

        img_buf.enqueue_fill(0.5)
        ker_buf.enqueue_fill(0.1)
        out_buf.enqueue_fill(0.0)

        var img = TileTensor(img_buf, img_layout)
        var ker = TileTensor(ker_buf, ker_layout)
        var output = TileTensor(out_buf, out_layout)

        comptime kernel = conv2d_kernel[
            type_of(img_layout), type_of(ker_layout), type_of(out_layout)
        ]

        ctx.enqueue_function[kernel](
            img, ker, output,
            grid_dim=(ceildiv(W, BLOCK_W), ceildiv(H, BLOCK_H)),
            block_dim=(BLOCK_W, BLOCK_H),
        )

        with out_buf.map_to_host() as host:
            var R = TileTensor(host, out_layout)
            # img=0.5, ker=0.1, K*K*C_in=9*16=144 → interior 출력 = 144*0.5*0.1 = 7.2
            print("output[H/2, W/2, 0] =", R[H//2, W//2, 0], "(expected ~7.2 interior)")
