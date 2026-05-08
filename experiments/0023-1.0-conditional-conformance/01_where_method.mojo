# 메서드에 where 절 — 일부 메서드만 추가 trait 요구
trait Stringable:
    def to_str(self) -> String: ...

struct Box[T]:
    var x: T
    def __init__(out self, x: T): self.x = x

    # T가 Stringable일 때만 컴파일러가 이 메서드 활성화
    def describe(self) -> String where T: Stringable:
        return "Box(" + self.x.to_str() + ")"

struct IntWrap(Stringable):
    var v: Int
    def __init__(out self, v: Int): self.v = v
    def to_str(self) -> String: return String(self.v)

def main():
    var b = Box[IntWrap](IntWrap(42))
    print(b.describe())
