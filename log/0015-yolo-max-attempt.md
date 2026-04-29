---
id: 0015
title: YOLO ONNX → MAX 시도 — CV 모델 경로 검증 (또 부정 결과)
status: done
date: 2026-04-29
tags: [max, ai-workloads, cv, yolo, onnx, infeasibility]
related_code: experiments/0015-yolo-max-attempt/
---

# 0015. YOLO ONNX → MAX 시도 — CV 모델 경로 검증 (또 부정 결과)

## 1. 무엇을 하고자 하는지

work 0014에서 **LLM Pipelines** 경로가 본 머신/시점에 막힘을 확인했음. 가설: *"LLM이 아닌 CV 모델은 다를 수도?"* — MAX가 더 generic한 graph 컴파일러로 동작하면 ONNX 같은 표준 IR을 import해서 어떤 모델이든 돌릴 수 있어야 함.

검증 대상: **YOLOv8n** (Object Detection, CNN-based) — 12.5 MB의 작은 ONNX. RAM 여유 충분.

## 2. 수행한 일

### 2.1 인벤토리 + MAX 지원 확인

```
$ max list 2>&1 | grep -iE 'yolo|detect'
(없음)
```

→ MAX architecture registry에 YOLO/Detection 계열 *없음* (LLM 전용 list). 하지만 그건 *Pipelines* 레벨 얘기. **`engine.InferenceSession`은 generic graph loader**일 가능성에 기대.

### 2.2 YOLO ONNX 다운로드

`pip install ultralytics` 없이 HF에서 이미 export된 ONNX:

```python
hf_hub_download(repo_id='salim4n/yolov8n-detect-onnx',
                filename='yolov8n-onnx-web/yolov8n.onnx')
# → 12.5 MB
# 헤더 확인: pytorch 2.3로 export된 ONNX (`8 0808 12 07 70 79 74 6f 72 63 68`)
```

### 2.3 MAX `engine.InferenceSession.load(onnx)` 시도

```python
from max import engine, driver
sess = engine.InferenceSession(devices=[driver.CPU()])
model = sess.load("yolov8n-onnx-web/yolov8n.onnx")
```

→ ❌ **`ValueError: cannot compile input with format input has unknown contents`**

`load()` 시그니처:
```
load(self, model: 'str | Path | Graph', ...)
```

— `Graph`는 `max.graph` API로 *직접 빌드한 객체*. `str | Path`는 MAX-native 형식만 인식 (.maxpkg 등). **ONNX 파일은 unknown contents로 거부**.

### 2.4 다른 진입점 탐색

```
$ max --help
Commands: benchmark, encode, generate, list, serve, warm-cache
```

→ **`convert`/`import`/`compile`/`build` 명령 없음**. MAX 0.26 CLI에 ONNX → MAX 변환 도구 미내장.

### 2.5 onnxruntime baseline (외부 비교)

```python
import onnxruntime as ort
sess = ort.InferenceSession("yolov8n.onnx", providers=["CPUExecutionProvider"])
# load + compile: 40 ms
# inference 1×3×640×640: median 12.9 ms = 77 FPS
# output: [1, 84, 8400] float32 (4 bbox + 80 classes × 8400 anchors)
```

→ ✅ **onnxruntime CPU = 77 FPS** (16 코어 활용 추정). MAX 우회로는 즉시 동작.

## 3. 예상되는 결과

- LLM Pipelines가 막혔지만 *generic graph loader*인 `engine.InferenceSession`은 ONNX 같은 표준 IR을 받아서 컴파일할 줄 알았음.
- CV 모델은 layer가 단순(Conv/BN/SiLU/Concat)해서 LLM의 KV cache/RoPE 같은 까다로운 dynamics가 없으니 더 잘 될 것이라 기대.

## 4. 실제 결과

**또 부정 결과**:

| 시도 | 결과 |
|------|------|
| `engine.InferenceSession.load(onnx_path)` | ❌ `unknown contents` — ONNX 미지원 |
| `max convert` / `max import` CLI | ❌ 명령 자체 없음 |
| `--custom-architectures` | LLM Pipelines 전용, generic ONNX 변환 안 함 |
| onnxruntime CPU baseline | ✅ 77 FPS — *MAX 우회*로 즉시 가능 |

**MAX 0.26의 모델 임포트 표면**:
- ✅ `max list`에 등록된 LLM architecture (Mojo로 hand-written)
- ✅ `max.graph` API로 **사용자가 직접 그래프 코드 작성** (Conv/BN/...)
- ❌ ONNX import (CLI/API 어디에도 없음)
- ❌ PyTorch state_dict import
- ❌ TF SavedModel import
- ❌ StableHLO import

→ **MAX 0.26은 임의의 표준 IR을 받지 않음**. 모델은 (1) MAX 팀이 미리 작성한 architecture 또는 (2) 사용자가 `max.graph`로 직접 작성한 그래프만 가능.

## 5. 결론

### 5.1 MAX 0.26의 모델 import 표면 (정확한 그림)

```
[사용자가 가진 모델 형식]              [MAX 진입 가능?]
─────────────────────────              ──────────────
HF safetensors + 등록된 arch     ────→  ✅ max.pipelines 경유 (architecture별 Mojo graph)
HF safetensors + 미등록 arch     ────→  ❌ Gemma4 (work 0014)
ONNX                              ────→  ❌ 본 work (yolov8n)
PyTorch state_dict (.pt)         ────→  ❌
TF SavedModel                    ────→  ❌
StableHLO MLIR                   ────→  ❌
GGUF (Q4_K_M 등)                 ────→  부분 ✅ (일부 LLM arch만)
max.graph 직접 작성              ────→  ✅ (그러나 코드 양 큼)
```

→ **MAX는 "기존 모델을 가져와서 돌리는" 도구가 아니라, "MAX 안에서 모델을 정의해서 돌리는" 도구**에 가까움. 이는 PyTorch/TF/ONNX-runtime의 *모델 import 우선* 디자인과 정반대 방향.

### 5.2 학습자 평가 (work 0014와 함께)

- **MAX 0.26은 일반적 ML 추론 프레임워크가 아님**. ONNX/TF/PyTorch import → 즉시 추론 같은 *흔한 use case*는 없음.
- MAX의 진짜 강점은:
  - Mojo 언어로 *가속 커널 직접 작성* (work 0009-0013에서 본 영역)
  - MAX 팀이 hand-written으로 등록한 *high-end LLM 파이프라인* (Llama/Qwen/...) on GPU
- **외부 모델을 그냥 돌리려면 onnxruntime/llama.cpp/vLLM 등이 정답**.
- *학습 시점*에 MAX의 가치 있는 영역:
  1. Mojo 언어 (CPU/GPU 양쪽 지원, 검증됨)
  2. `max.graph` API로 작은 모델 직접 빌드 (학습 목적)
  3. (GPU 있으면) MAX serving stack — production 추론 서빙

### 5.3 yolov8n 자체 측정

부수적으로 onnxruntime CPU에서 측정한 baseline:
- 모델: 12.5 MB ONNX (3M params, INT8 미양자화)
- 입력: 1×3×640×640 float32
- 출력: 1×84×8400 float32 (yolov8 standard: 4 bbox coord + 80 COCO classes × 8400 anchor positions)
- 추론: **12.9 ms median = 77 FPS** (16 코어 CPU)

만약 *MAX가 ONNX 받을 수 있었다면* 본 머신에서 비교 측정 가능했을 것. 현재 baseline 정보로만 보존.

### 5.4 후속 work 후보 (TODO 등재 권장)

- **(NEW from 0015)** `max.graph` Python API로 작은 CNN(예: 2-conv MLP) 직접 빌드 → 컴파일 → 추론. MAX Graph 작동 메커니즘 1급 검증. (work 0014 후속 #2와 같은 방향)
- **(NEW from 0015)** `max.graph` API에 Conv2d / BatchNorm / SiLU op 표면 조사 — YOLO를 *직접 작성*하려면 어떤 건물 블록이 노출돼 있나
- **(NEW from 0015)** ONNX → `max.graph` 자동 변환기 작성 가능성 — 둘 다 MLIR 기반이라 이론적으로 lowering 가능. 외부 프로젝트 있는지 검색
- **MAX 다음 릴리스에 ONNX import 추가될지** 모니터 — 지금은 미지원이지만 표준 IR 임포트는 흔한 요청
