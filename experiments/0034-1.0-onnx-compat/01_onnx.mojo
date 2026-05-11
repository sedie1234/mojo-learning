# ONNX 호환성 — onnxruntime via Python interop + max.engine ONNX 로드 시도
# yolov8n full inference는 시간 오래 걸려서 더 가벼운 검증으로 단축
from std.python import Python, PythonObject

def main() raises:
    print("=== [1.0] ONNX 호환성 ===")

    # (a) onnxruntime via Python interop (모델 로드까지만)
    var ort = Python.import_module("onnxruntime")
    print("onnxruntime version:", ort.__version__)

    var path = "/home/hwan/workspace/mojo/experiments/0015-yolo-max-attempt/yolov8n-onnx-web/yolov8n.onnx"
    var sess = ort.InferenceSession(path)
    print("ONNX model loaded via onnxruntime ✅")

    var inputs = sess.get_inputs()
    var inp = inputs[0]
    print("input:", inp.name, " shape:", inp.shape, " type:", inp.type)
    var outputs = sess.get_outputs()
    print("output:", outputs[0].name, " shape:", outputs[0].shape)

    # ort 자체로 추론은 work 0015에서 이미 77 FPS 측정됨 — 재측정 생략

    print()
    print("=== max.engine으로 ONNX 직접 import 시도 (work 0015 회귀) ===")
    try:
        var engine = Python.import_module("max.engine")
        var session = engine.InferenceSession()
        var loaded = session.load(path)
        print("MAX engine ONNX load: ✅ (변화 발견)")
    except e:
        print("MAX engine ONNX load: ❌")
        print("error:", e)
