# MOJO-7: 정수/부동소수 타입 — range, overflow, 변환
# (sizeof는 0.26 외부 API 미노출이라 MIN/MAX로 폭을 대체 입증)

fn main():
    print("=== MOJO-7: 수치 타입 ===\n")

    print("[Range — bit width를 MIN/MAX로 입증]")
    print("  Int8.MIN  =", Int8.MIN, " MAX  =", Int8.MAX, "  (signed 8-bit: -128..127)")
    print("  Int16.MIN =", Int16.MIN, " MAX =", Int16.MAX, " (signed 16-bit)")
    print("  Int32.MIN =", Int32.MIN, " MAX =", Int32.MAX, " (signed 32-bit)")
    print("  Int64.MIN =", Int64.MIN, " MAX =", Int64.MAX)
    print("  UInt8.MIN =", UInt8.MIN, " MAX =", UInt8.MAX, "  (unsigned 8-bit: 0..255)")
    print("  UInt32.MAX =", UInt32.MAX)
    print("  Int.MIN   =", Int.MIN, " MAX =", Int.MAX, " (플랫폼 의존, x86_64에서 64-bit)")

    print("\n[Overflow — 고정폭 정수의 wrap-around]")
    var max_i8: Int8 = Int8.MAX
    var ovf_i = max_i8 + Int8(1)
    print("  Int8(127) + Int8(1) =", ovf_i, "  (2의 보수 wrap → -128)")

    var max_u8: UInt8 = UInt8.MAX
    var ovf_u = max_u8 + UInt8(1)
    print("  UInt8(255) + UInt8(1) =", ovf_u, "  (unsigned wrap → 0)")

    print("\n[Float 정밀도]")
    var f16: Float16 = 1.0 / 3.0
    var f32: Float32 = 1.0 / 3.0
    var f64: Float64 = 1.0 / 3.0
    print("  1/3 in Float16 :", f16)
    print("  1/3 in Float32 :", f32)
    print("  1/3 in Float64 :", f64)

    print("\n[변환]")
    var i32_from_i: Int32 = Int32(42)
    var i_from_f: Int = Int(3.7)
    var f_from_i: Float64 = Float64(42)
    print("  Int32(42)        =", i32_from_i)
    print("  Int(3.7)         =", i_from_f, " (절단)")
    print("  Float64(42)      =", f_from_i)

    print("\n[C++ 비교]")
    print("  Mojo Int     ≈ C++ ssize_t/intptr_t (x86_64에서 64-bit)")
    print("  Mojo Int32   ≈ C++ int32_t  (cstdint)")
    print("  Mojo Float64 ≈ C++ double")
    print("  Mojo overflow는 wrap (Int8.MAX+1 = MIN 검증됨).")
    print("  C++23부터 signed wrap도 정의됨; 그 이전엔 UB.")
