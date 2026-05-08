# 0.26 fn 스타일 — 모든 인자/반환 타입 명시 strict mode
fn add(a: Int, b: Int) -> Int:
    return a + b

fn sum_to(n: Int) -> Int:
    var s: Int = 0
    var i: Int = 1
    while i <= n:
        s += i
        i += 1
    return s

fn main():
    print("add(3,4) =", add(3, 4))
    print("sum_to(100) =", sum_to(100))
