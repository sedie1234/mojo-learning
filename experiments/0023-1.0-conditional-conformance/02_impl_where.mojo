# impl X[T] as Trait where T: Bound
trait Stringable:
    def to_str(self) -> String: ...

struct Box[T]:
    var x: T
    def __init__(out self, x: T): self.x = x

impl Box[T] as Stringable where T: Stringable:
    def to_str(self) -> String:
        return "Box(" + self.x.to_str() + ")"

struct IntWrap(Stringable):
    var v: Int
    def __init__(out self, v: Int): self.v = v
    def to_str(self) -> String: return String(self.v)

def main():
    var b = Box[IntWrap](IntWrap(42))
    print(b.to_str())
