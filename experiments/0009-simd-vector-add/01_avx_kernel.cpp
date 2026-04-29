// MOJO-11 비교용: C++ AVX2 / AVX-512 최소 커널
// g++ -S -O3 -march=native -mavx512f -fno-tree-vectorize ...로 ASM dump

#include <immintrin.h>

// AVX2 (256-bit float32 × 8)
__m256 add8(__m256 a, __m256 b) {
    return _mm256_add_ps(a, b);
}

// AVX-512 (512-bit float32 × 16)
__m512 add16(__m512 a, __m512 b) {
    return _mm512_add_ps(a, b);
}

// main은 link 위해 (값 사용)
#include <cstdio>
int main() {
    float a8[8] __attribute__((aligned(32))) = {1,2,3,4,5,6,7,8};
    float b8[8] __attribute__((aligned(32))) = {10,10,10,10,10,10,10,10};
    float c8[8] __attribute__((aligned(32)));
    _mm256_store_ps(c8, add8(_mm256_load_ps(a8), _mm256_load_ps(b8)));
    printf("add8: ");
    for (int i = 0; i < 8; ++i) printf("%g ", c8[i]);
    printf("\n");

    float a16[16] __attribute__((aligned(64))) = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
    float b16[16] __attribute__((aligned(64))) = {100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100};
    float c16[16] __attribute__((aligned(64)));
    _mm512_store_ps(c16, add16(_mm512_load_ps(a16), _mm512_load_ps(b16)));
    printf("add16: ");
    for (int i = 0; i < 16; ++i) printf("%g ", c16[i]);
    printf("\n");
    return 0;
}
