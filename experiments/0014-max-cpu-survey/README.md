# 0014 — MAX CPU 적용 가능성 조사 (Qwen3-4B / Gemma4-E2B)

MAX CLI/엔진을 *로컬* HuggingFace 모델 weights에 CPU로 적용해보는 시도. 본 작업은 **부정 결과** — MAX 0.26 CPU 모드는 두 모델 모두 직접 적용 불가. 차단 지점이 어디인지 정확히 매핑.

코드 없이 CLI 명령 + 출력만으로 진행 (`results.log` 참고). 자세한 분석은 `../../log/0014-max-cpu-survey.md`.

## 빠른 재현

```bash
source /home/hwan/workspace/mojo/.venv/bin/activate

# Qwen3 — bfloat16 weights, CPU에서 거부
max generate --model-path /home/hwan/models/qwen-3/4B-Instruct \
    --quantization-encoding bfloat16 --prompt "Hi" --max-new-tokens 3
# → "encoding 'bfloat16' is not compatible with the selected device type 'cpu'"

# Gemma4 — 아키텍처 미지원
max list 2>&1 | grep -i gemma
# → Gemma3까지만, Gemma4 없음

# Qwen3 + float32 — repo bfloat16 weights와 불일치
max generate --model-path /home/hwan/models/qwen-3/4B-Instruct \
    --quantization-encoding float32 --prompt "Hi" --max-new-tokens 3
# → "quantization_encoding 'float32' is not supported by the repo"

# Qwen3 + q4_k (gguf 변형 + Qwen3 architecture)
# → "quantization_encoding of 'q4_k' not supported by MAX engine" (Qwen3 arch에서 미지원)
```
