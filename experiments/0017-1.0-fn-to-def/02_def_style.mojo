# 1.0 def 스타일 — 동일 코드 def으로 변환
def add(a: Int, b: Int) -> Int:
    return a + b

def sum_to(n: Int) -> Int:
    var s: Int = 0
    var i: Int = 1
    while i <= n:
        s += i
        i += 1
    return s

def main():
    print("add(3,4) =", add(3, 4))
    print("sum_to(100) =", sum_to(100))
