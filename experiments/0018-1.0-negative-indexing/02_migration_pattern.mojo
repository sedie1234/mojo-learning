# 1.0 권장 마이그레이션 패턴: x[len(x) - 1]
def main():
    var xs = List[Int](10, 20, 30, 40, 50)
    print("len =", len(xs))
    var last = xs[len(xs) - 1]
    print("last =", last)
    var second_last = xs[len(xs) - 2]
    print("second_last =", second_last)
