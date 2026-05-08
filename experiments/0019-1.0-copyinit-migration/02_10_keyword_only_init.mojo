# 1.0 패턴 추정 — keyword-only __init__으로 copy/move 통합
struct Box(Copyable):
    var x: Int
    fn __init__(out self, x: Int):
        self.x = x
    fn __init__(out self, *, copy: Self):    # keyword-only copy
        self.x = copy.x

def main():
    var a = Box(7)
    var b = a.copy()
    print(b.x)
