struct Box(Copyable):
    var x: Int
    def __init__(out self, x: Int): self.x = x

def main():
    var a = Box(7)
    var b = a.copy()  # 자동 생성 copy ctor
    print(a.x, b.x)
