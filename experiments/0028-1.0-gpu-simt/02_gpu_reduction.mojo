# GPU 1D sum reduction — tree reduction in shared memory + warp shuffle
# modular/skills:mojo-gpu-fundamentals 패턴
# CPU only 머신에선 컴파일 자체가 불가 (GPU device target 필요). 코드는 *문서 가치*.

from std.sys import has_accelerator

def main() raises:
    comptime if not has_accelerator():
        print("[GPU reduction] No GPU — execution skipped.")
    else:
        from std.math import ceildiv
        from std.gpu import block_idx, block_dim, thread_idx, barrier, WARP_SIZE
        from std.gpu.primitives import warp
        from std.gpu.memory import AddressSpace
        from std.gpu.host import DeviceContext
        from std.atomic import Atomic
        from std.memory import stack_allocation, UnsafePointer

        comptime dtype = DType.int32
        comptime N = 65536
        comptime BLOCK = 256
        comptime NUM_BLOCKS = ceildiv(N, BLOCK)

        def reduce_kernel(
            output: UnsafePointer[Scalar[dtype], MutAnyOrigin],
            input: UnsafePointer[Scalar[dtype], MutAnyOrigin],
            size: Int,
        ):
            # Shared memory: block 안 모든 thread가 자기 element를 적재
            var sums = stack_allocation[BLOCK, Scalar[dtype],
                address_space=AddressSpace.SHARED]()

            var tid = thread_idx.x
            var gid = block_idx.x * block_dim.x + tid

            sums[tid] = input[gid] if gid < size else 0
            barrier()

            # Tree reduction: BLOCK/2 → BLOCK/4 → ... → WARP_SIZE
            var active = block_dim.x
            while active > WARP_SIZE:
                active >>= 1
                if tid < active:
                    sums[tid] += sums[tid + active]
                barrier()

            # 마지막 warp 안에서 warp.sum primitive (hardware shuffle 활용)
            if tid < WARP_SIZE:
                var v = warp.sum(sums[tid][0])
                if tid == 0:
                    _ = Atomic.fetch_add(output, v)

        var ctx = DeviceContext()
        var in_buf = ctx.enqueue_create_buffer[dtype](N)
        var out_buf = ctx.enqueue_create_buffer[dtype](1)

        in_buf.enqueue_fill(1)
        out_buf.enqueue_fill(0)

        ctx.enqueue_function[reduce_kernel](
            out_buf.unsafe_ptr(), in_buf.unsafe_ptr(), N,
            grid_dim=NUM_BLOCKS,
            block_dim=BLOCK,
        )

        with out_buf.map_to_host() as host:
            print("sum =", host[0], "(expected", N, ")")
