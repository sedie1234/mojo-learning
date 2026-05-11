#!/bin/bash
# GPU 머신에서 Qwen3-4B를 max serve로 OpenAI-compat API 띄우기
# CPU only 머신: work 0025 결과대로 graph build 단계에서 차단되어 실행 불가
# GPU 머신: 정상 동작 예상 (port 8000 default)

# venv 활성
source ~/workspace/mojo/.venv-1.0/bin/activate

# 모델 경로 (공용 ~/models)
MODEL_PATH="${HOME}/models/qwen-3/4B-Instruct"

# max serve — OpenAI-compat HTTP API
max serve \
    --model-path "${MODEL_PATH}" \
    --quantization-encoding bfloat16 \
    --devices gpu \
    --port 8000 \
    --max-length 8192 \
    --max-num-steps 64

# 다른 옵션들:
#  --devices gpu:0,1            multi-GPU (tensor parallel)
#  --quantization-encoding q4_k float8_e4m3fn 등
#  --max-batch-size 32          dynamic batching
#  --headless                   API server 없이 worker만 (별도 router에 연결)
