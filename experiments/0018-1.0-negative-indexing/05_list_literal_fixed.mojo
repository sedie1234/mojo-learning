# 마이그레이션 패턴 — len(xs)-1
def main():
    var xs: List[Int] = [10, 20, 30, 40, 50]
    print("len =", len(xs))
    var last = xs[len(xs) - 1]
    print("last =", last)
    var first = xs[0]
    print("first =", first)
