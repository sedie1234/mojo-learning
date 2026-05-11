# GPU 2D tiled matmul — shared memory blocking + synchronization
# modular/skills 의 "Complete 2D example (tiled matmul with shared memory)" 패턴
# CPU only 머신에선 컴파일 자체 불가 — 코드는 *문서 가치*.

from std.sys import has_accelerator

def main() raises:
    comptime if not has_accelerator():
        print("[GPU matmul] No GPU — execution skipped.")
    else:
        from std.math import ceildiv
        from std.gpu.sync import barrier
        from std.gpu.host import DeviceContext
        from std.gpu import thread_idx, block_idx
        from std.gpu.memory import AddressSpace
        from layout import TileTensor, TensorLayout, row_major, stack_allocation

        comptime dtype = DType.float32
        comptime M = 256
        comptime N = 256
        comptime K = 256
        comptime TILE = 16
        comptime a_layout = row_major[M, K]()
        comptime b_layout = row_major[K, N]()
        comptime c_layout = row_major[M, N]()

        def matmul_kernel[
            ALayout: TensorLayout, BLayout: TensorLayout, CLayout: TensorLayout,
        ](
            A: TileTensor[dtype, ALayout, MutAnyOrigin],
            B: TileTensor[dtype, BLayout, MutAnyOrigin],
            C: TileTensor[dtype, CLayout, MutAnyOrigin],
        ):
            comptime assert A.flat_rank == 2 and B.flat_rank == 2 and C.flat_rank == 2

            var tx = thread_idx.x
            var ty = thread_idx.y
            var row = block_idx.y * TILE + ty
            var col = block_idx.x * TILE + tx

            # Shared memory tiles
            var sa = stack_allocation[dtype,
                address_space=AddressSpace.SHARED](row_major[TILE, TILE]())
            var sb = stack_allocation[dtype,
                address_space=AddressSpace.SHARED](row_major[TILE, TILE]())

            var acc: C.ElementType = 0.0

            # K축을 TILE 단위로 나눠가며 누적
            comptime for k_tile in range(0, K, TILE):
                if row < M and k_tile + tx < K:
                    sa[ty, tx] = A[row, k_tile + tx]
                else:
                    sa[ty, tx] = 0.0
                if k_tile + ty < K and col < N:
                    sb[ty, tx] = B[k_tile + ty, col]
                else:
                    sb[ty, tx] = 0.0
                barrier()    # 모든 thread가 sa/sb 적재 완료 대기

                # Tile 안에서 dot product
                comptime for k in range(TILE):
                    acc += sa[ty, k] * sb[k, tx]
                barrier()    # 다음 tile load 전 모든 thread 대기

            if row < M and col < N:
                C[row, col] = acc

        var ctx = DeviceContext()
        var a_buf = ctx.enqueue_create_buffer[dtype](M * K)
        var b_buf = ctx.enqueue_create_buffer[dtype](K * N)
        var c_buf = ctx.enqueue_create_buffer[dtype](M * N)

        a_buf.enqueue_fill(1.0)
        b_buf.enqueue_fill(2.0)
        c_buf.enqueue_fill(0.0)

        var A = TileTensor(a_buf, a_layout)
        var B = TileTensor(b_buf, b_layout)
        var C = TileTensor(c_buf, c_layout)

        # Parametric kernel은 binding 필요
        comptime kernel = matmul_kernel[type_of(a_layout), type_of(b_layout), type_of(c_layout)]

        ctx.enqueue_function[kernel](
            A, B, C,
            grid_dim=(ceildiv(N, TILE), ceildiv(M, TILE)),
            block_dim=(TILE, TILE),
        )

        with c_buf.map_to_host() as host:
            var R = TileTensor(host, c_layout)
            print("C[0,0] =", R[0, 0], "(expected 512.0)")
            print("C[M-1,N-1] =", R[M-1, N-1], "(expected 512.0)")
