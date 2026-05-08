# 0.26 패턴 — __copyinit__(out self, copy: Self) 명시
struct Box(Copyable):
    var x: Int
    fn __init__(out self, x: Int):
        self.x = x
    fn __copyinit__(out self, copy: Self):
        self.x = copy.x

def main():
    var a = Box(7)
    var b = a.copy()
    print(b.x)
