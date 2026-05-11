# StableHLO 호환성 조사 — Mojo 1.0 / MAX 26.3

## 1. 결론

**호환성 없음**. Mojo는 외부 MLIR dialect (StableHLO, linalg, affine 등) import/emit 모두 미지원.

## 2. 시도 가능한 경로 모두 부정 결과

| 경로 | 가능? | 비고 |
|------|:--:|------|
| `mojo build foo.mlir` (StableHLO 직접 build) | ❌ | mojo는 `.mojo` 소스만 받음 |
| `mojo build --emit stablehlo` (Mojo → StableHLO) | ❌ | `--emit asm|llvm|object|...` 외 dialect 옵션 없음 |
| `max compile foo_stablehlo.mlir` | ❌ | MAX는 HF safetensors + 등록 architecture만 |
| `from std.mlir import stablehlo` (코드에서 dialect op) | ❌ | std.mlir에 외부 dialect 없음 |
| ONNX/PyTorch → StableHLO → MAX | ❌ | MAX는 StableHLO frontend 없음 |
| JAX → StableHLO → Mojo native | ❌ | 동일 |

## 3. Modular 공식 입장

`forum.modular.com/t/mlir-dialect-import-for-mojo/774`:
> "Mojo does not currently support importing external MLIR dialects"
> "aspirational goal as native frontend for MLIR, but no roadmap plans"

차단 요인 (Stef 발언):
1. **Parser integration**: 외부 dialect 인식 메커니즘 없음
2. **MLIR linking**: 동일 MLIR에 link되는 두 라이브러리 동시 사용 불가
3. **Mixed dialect output**: 표준 Mojo 구문 (`if` 등)이 *native Mojo op*만 생성
4. **Lowering gap**: 사용자 dialect → executable로 lowering 미구현

## 4. 우회 경로

- **PyTorch → ONNX → onnxruntime**: 가장 표준적. Mojo에선 `Python.import_module("onnxruntime")` (work 0034 참고)
- **MAX 등록 모델 직접 사용**: HF safetensors + registered architecture에 한정 (work 0014/0025)
- **`max.graph` Python API로 직접 그래프 작성**: Mojo의 ops로 *수동 변환*. work 0029 참고

## 5. 후속 (Modular 발표 시 재시도)

- 본 학습자는 *modular forum의 dialect import RFC*를 모니터링 권장
- 1.0 stable 또는 1.x 시점 추후 release notes에서 *MLIR frontend* 키워드 검색
