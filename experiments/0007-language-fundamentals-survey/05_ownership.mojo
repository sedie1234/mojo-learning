# MOJO-9: 소유권 — read (default) / mut / var (consume) + ^ transfer

struct Box(Copyable):
    var x: Int

    fn __init__(out self, x: Int): self.x = x

    fn __copyinit__(out self, copy: Self):
        print("    [Box.__copyinit__ from x=", copy.x, "]")
        self.x = copy.x

fn observe(b: Box):                      # default = read borrow
    print("  observe sees x =", b.x)

fn observe_explicit(read b: Box):        # 'read'로 명시
    print("  observe_explicit sees x =", b.x)

fn modify(mut b: Box):                   # mut = 가변 참조
    b.x += 100

fn consume(var b: Box):                  # var = owned, 함수가 소유권 갖음
    print("  consume took x =", b.x)
    # b는 함수 끝에서 자동 소멸

fn main():
    print("=== MOJO-9: 소유권/borrow checker ===\n")

    var b = Box(7)

    print("[1] read borrow — default 또는 'read']")
    observe(b)
    observe_explicit(b)
    print("  b는 여전히 살아있음, x =", b.x)

    print("\n[2] mut borrow — 가변 참조]")
    modify(b)
    print("  modify 후 b.x =", b.x)

    print("\n[3] var (consume) — ^ transfer 필수]")
    consume(b^)
    print("  consume 호출 끝, b는 더 이상 사용 불가 (다음 줄 풀면 컴파일 에러)")
    # print(b.x)   ← 풀면: error: use of uninitialized value 'b'

    print("\n[4] consume에 ^ 안 붙이면? 같은 디렉토리 05b_no_transfer.mojo로 별도 검증]")

    print("\n[정리]")
    print("  default = read   ← Rust의 &T")
    print("  mut              ← Rust의 &mut T (Mojo는 inout 키워드 폐기)")
    print("  var              ← Rust의 T move (Mojo는 owned 키워드 폐기)")
    print("  ^ transfer       ← Rust의 std::move 또는 함수 인자 move")
    print("  Copyable trait이 있으면 ^ 없이도 자동 copy 시도됨")
