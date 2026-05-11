#!/usr/bin/env python3
"""
HTTP가 아니라 Python에서 max.engine 직접 사용 — 같은 프로세스에 모델 로드.

vLLM/HuggingFace transformers와 같은 *in-process inference* 패턴.
GPU 환경에서 추가 latency 없이 가장 빠른 응답.

CPU only 머신에선 max.pipelines 단계에서 GPU 강제 (work 0025 결과)로 동작 X.
"""
from max import engine
from max.pipelines import PipelineConfig, PipelineModel

# 1. config 정의 — 모델 경로 + device + encoding
config = PipelineConfig(
    model_path="/home/hwan/models/qwen-3/4B-Instruct",
    device_type="gpu",
    quantization_encoding="bfloat16",
    max_length=8192,
)

# 2. session 시작 (graph build + 가중치 load + GPU upload)
pipeline = PipelineModel.from_config(config)

# 3. 추론 — 단일 호출
output = pipeline.generate(
    prompt="Mojo 언어의 장점을 3가지로 요약해.",
    max_new_tokens=128,
    temperature=0.7,
)
print("=== single inference ===")
print(output.text)

# 4. continuation — token-by-token (streaming-like)
print("\n=== token-by-token ===")
for token in pipeline.generate_stream(
    prompt="GPU SIMT 모델이 CPU SIMD와 다른 점:",
    max_new_tokens=128,
):
    print(token, end="", flush=True)
print()

# 5. batched inference — 여러 prompt 한 번에
prompts = [
    "Python의 GIL이란?",
    "Rust의 borrow checker?",
    "C++ template과 Mojo trait 차이?",
]
results = pipeline.generate_batch(prompts, max_new_tokens=64)
print("\n=== batched ===")
for p, r in zip(prompts, results):
    print(f"[Q] {p}\n[A] {r.text}\n")

# 자원 정리는 자동 (PipelineModel이 context manager + __del__ 처리)
