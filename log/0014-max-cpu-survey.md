---
id: 0014
title: MAX CPU 적용 가능성 조사 — Qwen3-4B / Gemma4-E2B 부정 결과
status: done
date: 2026-04-29
tags: [max, ai-workloads, llm, cpu-only, infeasibility]
related_code: experiments/0014-max-cpu-survey/
---

# 0014. MAX CPU 적용 가능성 조사 — Qwen3-4B / Gemma4-E2B 부정 결과

## 1. 무엇을 하고자 하는지

MOJO-17 (MAX 엔진 설치 및 모델 로드) + MOJO-19 (`~/models/`의 기존 모델을 MAX에서 사용 가능한지)를 **두 구체 타깃 모델**(Qwen3-4B-Instruct, Gemma4-E2B-it)에 대해 조사. MOJO-18 (distilbert)은 사용자 요청으로 cancel.

핵심 질문: "이 머신(CPU only, 14 GiB RAM)에서 MAX로 두 모델을 로드/추론할 수 있는가?"

## 2. 수행한 일

### 2.1 환경 조사

```
머신: x86_64, AVX-512, 16 cores, 14 GiB RAM (가용 5.9 GiB), GPU 없음
설치: pip install modular (work 0003) — `max` CLI on PATH
       max --version OK, max list / max generate --help 정상
```

### 2.2 모델 인벤토리

```
~/models/qwen-3/4B-Instruct/         7.6 GB  (HF format, safetensors, bfloat16)
~/models/qwen-3/4B-Instruct-gguf-Q4/ 2.4 GB  (GGUF Q4_K_M, 단일 파일)
~/models/gemma-4/E2B-it/             9.6 GB  (HF format, safetensors)
```

각 `config.json`의 architecture 확인:

| 경로 | architecture | model_type | torch_dtype |
|------|--------------|------------|-------------|
| qwen-3/4B-Instruct | `Qwen3ForCausalLM` | `qwen3` | bfloat16 |
| gemma-4/E2B-it | `Gemma4ForConditionalGeneration` | `gemma4` | (확인 안 됨) |

### 2.3 MAX 지원 확인 (`max list`)

| Architecture | MAX 지원 | 인코딩 |
|--------------|:--:|--------|
| `Qwen3ForCausalLM` | ✅ | bfloat16 / float32 / float8_e4m3fn |
| `Gemma3ForCausalLM` | ✅ | bfloat16 |
| **`Gemma4ForConditionalGeneration`** | ❌ | **목록 자체에 없음** |

→ **Gemma4는 MAX 0.26에서 architecture 미지원** (Gemma3까지만). 첫 차단.

### 2.4 Qwen3 시도 (4 가지 인코딩)

`max generate --model-path /home/hwan/models/qwen-3/4B-Instruct --prompt "..." --max-new-tokens 3` 에 인코딩 변경하며:

| 인코딩 | 시도 결과 |
|--------|----------|
| `bfloat16` | ❌ "encoding 'bfloat16' is not compatible with the selected device type 'cpu'" |
| `float32` | ❌ "quantization_encoding 'float32' is not supported by the repo" (repo의 weights는 bfloat16) |
| `float8_e4m3fn` | ❌ 같은 사유 — repo weights ≠ 요청 인코딩 |
| `q4_k` | ❌ "quantization_encoding of 'q4_k' not supported by MAX engine" (Qwen3 arch 자체 미지원) |

GGUF 디렉토리(`qwen-3/4B-Instruct-gguf-Q4/`) 직접:
- ❌ `config.json` 없어서 architecture 추론 실패. MAX는 GGUF 디렉토리 단독 로드 안 함.

`--model-path <HF dir> --weight-path <gguf 파일>` 조합:
- ❌ q4_k는 MAX 엔진 자체에서 Qwen3 arch에 미지원 — 어차피 거부.

### 2.5 Gemma4

architecture 미지원이라 시도 자체 무의미. 확인만 기록:

```
$ max list 2>&1 | grep -i gemma
    Architecture: Gemma3ForCausalLM
              google/gemma-3-1b-it
              google/gemma-3-1b-pt
    Architecture: Gemma3ForConditionalGeneration
              google/gemma-3-12b-it (~)
```

→ Gemma4 family는 MAX 0.26에서 사용 불가.

## 3. 예상되는 결과

- Qwen3-4B는 4B params × 2 byte (bf16) = 7.6 GB. RAM 5.9 GB 가용으로 swap 의존하면 로드는 될 줄 알았음.
- Gemma4-E2B는 effective 2B params × 2 byte ≈ 4 GB로 더 가벼울 것.
- MAX는 modular의 핵심 엔진이므로 본 머신의 SDK 내장으로 로드 가능할 것.

## 4. 실제 결과

**두 모델 모두 차단**:

### 4.1 차단 지점 매핑

| 차단 | 영향받는 모델 | 우회 가능? |
|------|---------------|-----------|
| Gemma4 architecture 미지원 (MAX list에 없음) | Gemma4-E2B | ❌ MAX 업데이트 대기 또는 Gemma3로 대체 |
| bfloat16 + CPU 비호환 | Qwen3-4B (bfloat16 weights) | 우회 어려움 (다른 인코딩 모두 차단) |
| repo weights ≠ 요청 인코딩 | Qwen3-4B (float32/float8 시도) | weights 사전 변환 필요 (큰 작업) |
| q4_k가 Qwen3 arch에서 미지원 | GGUF Q4 변형 | MAX 업데이트 대기 |

### 4.2 일관된 패턴

MAX 0.26의 CPU 모드는 **인코딩-architecture 매트릭스의 좁은 교집합만** 작동. 본 머신의 두 모델은 둘 다 그 교집합 밖.

### 4.3 시도된 명령어 요약

```bash
max generate --model-path ~/models/qwen-3/4B-Instruct --quantization-encoding bfloat16 ...
# → CPU 비호환 error

max generate --model-path ~/models/qwen-3/4B-Instruct --quantization-encoding float32 ...
# → repo weights mismatch

max generate --model-path ~/models/qwen-3/4B-Instruct --quantization-encoding float8_e4m3fn ...
# → repo weights mismatch (bfloat16에서 float8 자동 변환 안 함)

max generate --model-path ~/models/qwen-3/4B-Instruct --quantization-encoding q4_k ...
# → MAX engine 자체에서 Qwen3+q4_k 미지원

max generate --model-path ~/models/qwen-3/4B-Instruct-gguf-Q4 ...
# → config.json 없음, GGUF 디렉토리 단독 로드 불가
```

## 5. 결론

### 5.1 사실의 정확한 정리

> **MAX 0.26은 GPU-우선 설계**. CPU 모드는 좁은 인코딩 호환성만 지원 (Qwen3에서는 float32 / float8_e4m3fn — 둘 다 추가 weight 변환 필요). 우리 *bfloat16 safetensors* 모델은 CPU에서 그대로 못 돌림.
>
> **Gemma4 architecture는 MAX 0.26에서 미지원** (Gemma3까지만 호환).

### 5.2 비용 분석 — 우회하려면 무엇이 필요한가

| 우회 방법 | 작업 | 가능성 |
|-----------|------|--------|
| Qwen3 weights를 float32로 변환 | safetensors 읽어 dtype cast → 새 safetensors 저장. 약 16 GB 디스크 + RAM 작업 | ⚠️ 디스크/RAM 빠듯 |
| Qwen3 weights를 float8_e4m3fn으로 양자화 | 양자화 calibration 또는 즉시 양자화 → MAX 호환 포맷 출력 | ⚠️ MAX 자체 도구로 가능한지 미확인 |
| MAX 자체로 양자화 (`max compile`?) | `max` CLI의 `warm-cache` 또는 별도 양자화 명령 | 본 work에서 미탐색 (시간 부족) |
| Gemma3 (이전 버전) 사용 | gemma-3 변형 다운로드해서 비교 | 다른 모델이지만 MAX path 검증 가능 |
| llama.cpp / vLLM-CPU 등 다른 엔진 | MAX 우회 | MAX 학습 목표와 어긋남 |

### 5.3 학습자 평가

- **MAX는 GPU 도구**. CPU 모드는 디버깅/개발 목적이거나 호환되는 사전 양자화 모델만. 일반적인 HF download model을 CPU에서 그대로는 거의 못 돌림. 0010~0013에서 본 SIMD/parallelize의 강력함과 별개로, *모델 추론* 단계는 GPU 부재 시 MAX의 가치가 급격히 떨어짐.
- 본 머신(GPU 없음)에서 MAX로 LLM 추론을 시도하려면 *모델/인코딩 사전 준비*가 본 시도(직접 CLI 호출)보다 훨씬 큰 비중. **"기존 HF 모델을 즉시 MAX로"라는 기대는 비현실적**.
- Gemma4 미지원은 *시간 의존* — MAX 다음 릴리스에 추가될 가능성. 단 본 학습 시점(2026-04)에 안 되는 건 사실.

### 5.4 실용적 권고 (이 머신 + 이 모델들)

| 시나리오 | 권고 도구 |
|----------|----------|
| Qwen3-4B CPU 추론 | **llama.cpp** (`Q4_K_M.gguf` 그대로 사용, ~2.5 GB RAM, 실용적 속도) |
| Gemma4-E2B CPU 추론 | llama.cpp (`E2B-it-gguf` 활용) |
| MAX 학습 자체 | GPU 환경 또는 MAX 호환 사전 양자화 모델 (HuggingFace의 일부) |
| Mojo MAX API 학습 | 작은 모델로 시작 (`google/gemma-3-1b-it` HF download — bfloat16지만 1B라 RAM 여유) → 본 work 후속 |

### 5.5 후속 work 후보 (TODO에 등재)

- **(NEW from 0014)** `max compile` / `max warm-cache` 등 양자화/사전컴파일 워크플로우 — bfloat16 → float32 또는 float8 변환을 MAX 자체로 가능한지
- **(NEW from 0014)** **gemma-3-1b-it** 같은 작은 호환 모델 HF download → MAX 추론 (CPU에서도 RAM 여유, MAX path 검증 목적)
- **(NEW from 0014)** Mojo `max.engine` Python API 직접 사용 — CLI보다 더 유연한 옵션 가능성
- **(NEW from 0014)** llama.cpp 비교 baseline — Qwen3-4B Q4 GGUF 추론 token/s 측정. MAX 미사용 baseline.
- (장기) GPU 환경에서 MAX 본격 운용
