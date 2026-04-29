"""work 0015 — onnxruntime baseline for YOLO (MAX 우회)"""
import time
import numpy as np
import onnxruntime as ort

ONNX = "yolov8n-onnx-web/yolov8n.onnx"

print(f"[1] ort version: {ort.__version__}")
print(f"[2] available providers: {ort.get_available_providers()}")

t0 = time.time()
sess = ort.InferenceSession(ONNX, providers=["CPUExecutionProvider"])
t1 = time.time()
print(f"[3] ONNX load + compile: {t1-t0:.2f} s")

inp = sess.get_inputs()[0]
out = sess.get_outputs()[0]
print(f"[4] input: {inp.name} {inp.shape} {inp.type}")
print(f"    output: {out.name} {out.shape} {out.type}")

# 더미 input (1×3×640×640)
x = np.random.randn(1, 3, 640, 640).astype(np.float32)

# warmup
for _ in range(3): sess.run([out.name], {inp.name: x})

# measure
times = []
for _ in range(10):
    t0 = time.time()
    y = sess.run([out.name], {inp.name: x})[0]
    times.append(time.time() - t0)

print(f"\n[5] inference (1×3×640×640):")
print(f"    median {sorted(times)[5]*1000:.1f} ms")
print(f"    output shape: {y.shape}")
print(f"    fps (1 batch): {1/sorted(times)[5]:.1f}")
