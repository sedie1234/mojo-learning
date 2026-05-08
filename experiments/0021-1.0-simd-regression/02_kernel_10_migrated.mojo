def add8(a: SIMD[DType.float32, 8], b: SIMD[DType.float32, 8]) -> SIMD[DType.float32, 8]:
    return a + b

def add16(a: SIMD[DType.float32, 16], b: SIMD[DType.float32, 16]) -> SIMD[DType.float32, 16]:
    return a + b

def main():
    var a8 = SIMD[DType.float32, 8](1, 2, 3, 4, 5, 6, 7, 8)
    var b8 = SIMD[DType.float32, 8](10.0)
    print("add8(1..8, 10):", add8(a8, b8))

    var a16 = SIMD[DType.float32, 16](1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    var b16 = SIMD[DType.float32, 16](100.0)
    print("add16(1..16, 100):", add16(a16, b16))
