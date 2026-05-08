# 1.0에서 negative indexing이 컴파일 에러여야 함
def main():
    var xs = List[Int](10, 20, 30, 40, 50)
    print("len =", len(xs))
    var last = xs[-1]                 # ★ 1.0 컴파일 에러 예상
    print("xs[-1] =", last)
