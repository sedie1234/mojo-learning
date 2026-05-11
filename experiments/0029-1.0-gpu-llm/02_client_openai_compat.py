#!/usr/bin/env python3
"""
max serve OpenAI-compat API 클라이언트.

전제: 01_serve_qwen3.sh로 server가 port 8000에 떠 있음 (GPU 머신).
CPU only 머신에선 server 자체가 안 떠서 본 스크립트도 동작 X.

OpenAI SDK가 그대로 동작 (base_url만 max serve로 지정).
"""
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:8000/v1",
    api_key="not-needed-for-local-max",
)


def chat_completion_demo():
    """단순 chat completion — 기본 사용법."""
    response = client.chat.completions.create(
        model="qwen-3-4b-instruct",   # max serve가 알아서 매핑
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": "Mojo 언어의 SIMT 모델을 한 줄로 설명해."},
        ],
        max_tokens=128,
        temperature=0.7,
    )
    print("=== chat completion ===")
    print(response.choices[0].message.content)


def streaming_demo():
    """SSE streaming — 토큰별로 받아 stdout 출력."""
    stream = client.chat.completions.create(
        model="qwen-3-4b-instruct",
        messages=[{"role": "user", "content": "1부터 5까지 세어줘."}],
        stream=True,
        max_tokens=64,
    )
    print("=== streaming ===")
    for chunk in stream:
        delta = chunk.choices[0].delta.content
        if delta:
            print(delta, end="", flush=True)
    print()


def batch_throughput_demo():
    """N개 요청을 동시에 — max serve의 dynamic batching이 합쳐서 처리.

    GPU 환경에서 throughput 측정에 유용한 패턴.
    """
    import asyncio, time
    from openai import AsyncOpenAI

    aclient = AsyncOpenAI(
        base_url="http://localhost:8000/v1",
        api_key="not-needed-for-local-max",
    )

    async def one(i: int):
        r = await aclient.chat.completions.create(
            model="qwen-3-4b-instruct",
            messages=[{"role": "user", "content": f"숫자 {i}를 영어 단어로 써."}],
            max_tokens=32,
        )
        return r.choices[0].message.content

    async def run_batch(n: int):
        t0 = time.perf_counter()
        results = await asyncio.gather(*[one(i) for i in range(n)])
        t1 = time.perf_counter()
        print(f"=== batch {n} concurrent requests: {t1-t0:.2f}s "
              f"({(t1-t0)/n*1000:.0f}ms/req amortized) ===")
        for i, r in enumerate(results[:3]):
            print(f"  [{i}] {r}")

    asyncio.run(run_batch(16))


if __name__ == "__main__":
    chat_completion_demo()
    streaming_demo()
    batch_throughput_demo()
