# MOJO-5: fn vs def — 타입 강제·에러 시점·시맨틱 차이

# ── fn: 엄격 타입 + raises 명시 + 인자 read by default ──
fn add_fn(a: Int, b: Int) -> Int:
    return a + b

fn might_fail_fn(a: Int, b: Int) raises -> Int:
    if b == 0:
        raise Error("div by zero (fn raises)")
    return a // b

# ── def: Python-호환 + 묵시 raises + var 인자(가변) ──
def add_def(a: Int, b: Int) -> Int:
    return a + b

# 0.26부터: def도 raises를 안 적으면 raise 못 함 (예전엔 묵시적이었음 — 변경됨)
def might_fail_def(a: Int, b: Int) raises -> Int:
    if b == 0:
        raise Error("div by zero (def + raises)")
    return a // b

fn main() raises:
    print("=== MOJO-5: fn vs def ===\n")

    print("[정상 호출]")
    print("  fn add_fn(3, 4) =", add_fn(3, 4))
    print("  def add_def(3, 4) =", add_def(3, 4))

    print("\n[raises 명시 — 0.26부터는 fn/def 모두 명시 필요]")
    print("  fn/def 모두 raise 하려면 'raises' 명시. (이전 버전의 def 묵시적 raises는 0.26에서 제거됨.)")
    try:
        _ = might_fail_fn(10, 0)
    except e:
        print("  caught from fn:", e)
    try:
        _ = might_fail_def(10, 0)
    except e:
        print("  caught from def:", e)

    print("\n[타입 strict — 컴파일 시점 거부]")
    print("  fn은 일반적으로 args/return 타입 명시 필수.")
    print("  타입이 안 맞으면 컴파일 에러 (런타임 도달 불가).")
    print("  def도 타입을 적으면 fn처럼 컴파일 검사하지만,")
    print("  Python 호환 모드에서는 더 느슨할 수 있음.")
