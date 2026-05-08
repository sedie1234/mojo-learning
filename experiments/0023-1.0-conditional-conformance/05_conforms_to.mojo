trait Stringable:
    def to_str(self) -> String: ...

struct IntWrap(Copyable, Stringable):
    var v: Int
    def __init__(out self, v: Int): self.v = v
    def to_str(self) -> String: return String(self.v)

struct Box[T: Copyable]:
    var x: T
    def __init__(out self, x: T): self.x = x.copy()

    # comptime if 안에서 conforms_to[Trait]() 사용
    def describe(self) -> String:
        comptime if T.conforms_to[Stringable]():
            return "Box(" + self.x.to_str() + ")"
        else:
            return "Box(?)"

def main():
    var b = Box[IntWrap](IntWrap(42))
    print(b.describe())
