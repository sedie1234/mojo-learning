"""work 0015 — YOLO ONNX → MAX InferenceSession (CPU only)"""
import os, time, numpy as np
from max import engine, driver

ONNX = "yolov8n-onnx-web/yolov8n.onnx"
print(f"[1] ONNX: {ONNX} ({os.path.getsize(ONNX)//1024} KB)")

print("\n[2] CPU device + InferenceSession")
cpu = driver.CPU()
sess = engine.InferenceSession(devices=[cpu])
print(f"  session: {sess}")

print("\n[3] load(ONNX path)")
t0 = time.time()
try:
    model = sess.load(ONNX)
    t1 = time.time()
    print(f"  ✓ loaded in {t1-t0:.2f} s")
    print(f"  model: {model}")
    print(f"  inputs: {model.input_metadata}")
    print(f"  outputs: {model.output_metadata}")
except Exception as e:
    print(f"  ✗ {type(e).__name__}: {str(e)[:300]}")
