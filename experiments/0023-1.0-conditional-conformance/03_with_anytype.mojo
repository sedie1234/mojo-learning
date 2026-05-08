trait Stringable:
    def to_str(self) -> String: ...

struct Box[T: Copyable]:
    var x: T
    def __init__(out self, x: T): self.x = x.copy()

    # 메서드 단위 where 절 가능?
    def describe(self) -> String where T: Stringable:
        return "Box(" + self.x.to_str() + ")"

struct IntWrap(Copyable, Stringable):
    var v: Int
    def __init__(out self, v: Int): self.v = v
    def to_str(self) -> String: return String(self.v)

def main():
    var b = Box[IntWrap](IntWrap(42))
    print(b.describe())
