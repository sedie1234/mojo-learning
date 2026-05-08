# MOJO-11: 최소 SIMD 커널 — `mojo build --emit asm`으로 ASM dump해 vaddps 확인용

# 256-bit (AVX/AVX2 폭, float32 × 8)
fn add8(a: SIMD[DType.float32, 8], b: SIMD[DType.float32, 8]) -> SIMD[DType.float32, 8]:
    return a + b

# 512-bit (AVX-512 폭, float32 × 16). 본 머신은 AVX-512 지원
fn add16(a: SIMD[DType.float32, 16], b: SIMD[DType.float32, 16]) -> SIMD[DType.float32, 16]:
    return a + b

fn main():
    var a8 = SIMD[DType.float32, 8](1, 2, 3, 4, 5, 6, 7, 8)
    var b8 = SIMD[DType.float32, 8](10.0)
    print("add8(1..8, 10):", add8(a8, b8))

    var a16 = SIMD[DType.float32, 16](1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    var b16 = SIMD[DType.float32, 16](100.0)
    print("add16(1..16, 100):", add16(a16, b16))
