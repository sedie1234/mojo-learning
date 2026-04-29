# 05b: ^ 없이 var 파라미터에 넘기면 컴파일이 어떻게 거부하는지 (실행 안 되는 게 정상)

struct Box:                       # ★ Copyable 의도적으로 빼서 implicit copy 차단
    var x: Int
    fn __init__(out self, x: Int): self.x = x

fn consume(var b: Box): print(b.x)

fn main():
    var b = Box(7)
    consume(b)         # ← ^ 없음 → ImplicitlyCopyable 미준수로 에러
