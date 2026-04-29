# MOJO-10: Trait / parametric polymorphism — C++ template/concept과 비교

# ── 1. trait 정의 ──
trait Drawable:
    fn draw(self): ...                  # 추상 메서드: '...'로 body 생략

trait Stringable:
    fn to_str(self) -> String: ...

# ── 2. struct가 trait에 conform (다중 가능) ──
struct Circle(Drawable, Stringable):    # 다중 conform
    var r: Float64
    fn __init__(out self, r: Float64): self.r = r
    fn draw(self): print("[Circle.draw] r=", self.r)
    fn to_str(self) -> String: return "Circle(" + String(self.r) + ")"

struct Square(Drawable):                # 단일 conform
    var s: Float64
    fn __init__(out self, s: Float64): self.s = s
    fn draw(self): print("[Square.draw] s=", self.s)

# ── 3. parametric fn — 단일 trait bound ──
fn render[T: Drawable](shape: T):
    shape.draw()

# ── 4. parametric fn — 다중 trait bound (& 연결) ──
fn describe[T: Drawable & Stringable](x: T):
    print("describe:", x.to_str())
    x.draw()

# ── 5. trait 상속 — Pet은 Animal의 모든 contract을 가짐 ──
trait Animal:
    fn sound(self): ...

trait Pet(Animal):                       # Pet extends Animal
    fn owner(self) -> String: ...

struct Dog(Pet):                         # Pet conform → 자동으로 Animal도 conform
    var name: String
    fn __init__(out self, n: String): self.name = n
    fn sound(self): print("[Dog.sound]", self.name, "→ woof")
    fn owner(self) -> String: return "Alice"

fn use_as_animal[T: Animal](a: T): a.sound()
fn use_as_pet[T: Pet](p: T):
    p.sound()
    print("  owner:", p.owner())

fn main():
    print("=== MOJO-10: Trait / parametric polymorphism ===\n")

    print("[1] 단일 trait bound — render(Drawable)]")
    render(Circle(3.0))
    render(Square(5.0))

    print("\n[2] 다중 trait bound — describe(Drawable & Stringable)]")
    describe(Circle(7.0))
    # describe(Square(5.0))   ← 컴파일 에러: Square가 Stringable conform 안 함

    print("\n[3] trait 상속 — Pet은 Animal의 contract도 만족]")
    var d = Dog("Rex")
    use_as_animal(d)               # Dog → Pet → Animal 자동
    use_as_pet(d)

    print("\n[정리]")
    print("  trait T = C++ concept")
    print("  struct Foo(T1, T2) = struct Foo conforms to T1 and T2")
    print("  fn f[T: Trait](x: T) = template<Trait T> + 컴파일 시점 monomorphization")
    print("  fn f[T: A & B](x: T) = 다중 concept requires (C++20)")
    print("  trait Pet(Animal) = trait inheritance (Rust 'trait Pet: Animal')")
    print("  abstract method body는 '...'로 표기 (Python '...'와 같은 위치, 의미는 'unimplemented')")
