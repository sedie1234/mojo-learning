# 컴파일러가 Copyable에 대해 자동 생성?
struct Box(Copyable):
    var x: Int
    fn __init__(out self, x: Int):
        self.x = x

def main():
    var a = Box(7)
    var b = a.copy()
    print(b.x)
