# 0015 — YOLO ONNX → MAX 시도 (CV 모델 경로 검증)

work 0014의 LLM 경로 외에, **CV 모델(YOLO)** 도 MAX로 가능한지 확인.

## 파일

| 파일 | 역할 |
|------|------|
| `yolov8n-onnx-web/yolov8n.onnx` | salim4n/yolov8n-detect-onnx HF에서 받음, 12.5 MB |
| `load_yolo.py` | MAX `engine.InferenceSession.load(onnx)` 시도 (실패) |
| `ort_baseline.py` | onnxruntime CPU baseline (성공, 77 FPS) |
| `results.log` | 위 실행 캡처 |

## 한 줄 결과

> **MAX 0.26 `engine.InferenceSession.load()`는 ONNX 미지원** → CV 모델을 MAX로 직접 못 돌림. onnxruntime CPU(외부 도구) baseline = yolov8n 77 FPS @ 1×3×640×640.

상세는 `../../log/0015-yolo-max-attempt.md`.
