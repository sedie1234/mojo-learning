# 모든 메서드까지 def으로 전환한 1.0 권장 형태
struct Box(Copyable):
    var x: Int
    def __init__(out self, x: Int): self.x = x
    def __init__(out self, *, copy: Self):
        self.x = copy.x

def main():
    var a = Box(7)
    var b = a.copy()
    print(a.x, b.x)

    # 자동 copy ctor 활용 케이스도 def으로
    var c = Box(99)
    var d = c.copy()
    print(c.x, d.x)
