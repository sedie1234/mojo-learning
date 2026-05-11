# GPU vector add — Mojo 1.0 SIMT 모델
# modular/skills:mojo-gpu-fundamentals 패턴
#
# CPU only 머신: 본 파일은 컴파일 시점에 `has_accelerator()`가 false라서
#   GPU 호출 부분이 *컴파일에서 제외*된다. 실행 시 "No GPU" 메시지만 출력.
# GPU 머신: 정상 컴파일 + 실행. 1024 element vector add (a=1.5 + b=2.5 → c=4.0).

from std.sys import has_accelerator

def main() raises:
    comptime if not has_accelerator():
        print("[GPU vector add] No GPU detected — code compiled OK, execution skipped.")
    else:
        from std.math import ceildiv
        from std.gpu import global_idx
        from std.gpu.host import DeviceContext
        from layout import TileTensor, row_major

        comptime dtype = DType.float32
        comptime N = 1024
        comptime BLOCK = 256
        comptime layout = row_major[N]()

        # GPU kernel — plain def (CUDA의 __global__ 데코레이터 *없음*).
        # global_idx.x = blockIdx.x * blockDim.x + threadIdx.x 의 단축형.
        def add_kernel(
            a: TileTensor[dtype, type_of(layout), MutAnyOrigin],
            b: TileTensor[dtype, type_of(layout), MutAnyOrigin],
            c: TileTensor[dtype, type_of(layout), MutAnyOrigin],
            size: Int,
        ):
            comptime assert a.flat_rank == 1, "expected 1D tensor"
            var tid = global_idx.x
            if tid < size:
                c[tid] = a[tid] + b[tid]

        var ctx = DeviceContext()
        var a_buf = ctx.enqueue_create_buffer[dtype](N)
        var b_buf = ctx.enqueue_create_buffer[dtype](N)
        var c_buf = ctx.enqueue_create_buffer[dtype](N)

        a_buf.enqueue_fill(1.5)
        b_buf.enqueue_fill(2.5)

        var a = TileTensor(a_buf, layout)
        var b = TileTensor(b_buf, layout)
        var c = TileTensor(c_buf, layout)

        # CUDA의 kernel<<<grid, block>>>(args) 대신
        ctx.enqueue_function[add_kernel](
            a, b, c, N,
            grid_dim=ceildiv(N, BLOCK),
            block_dim=BLOCK,
        )

        with c_buf.map_to_host() as host:
            var result = TileTensor(host, layout)
            print("c[0] =", result[0], "(expected 4.0)")
            print("c[N-1] =", result[N-1], "(expected 4.0)")
