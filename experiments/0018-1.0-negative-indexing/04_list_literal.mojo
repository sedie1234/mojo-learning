# 1.0의 List 리터럴 syntax 시도
def main():
    var xs: List[Int] = [10, 20, 30, 40, 50]
    print("len =", len(xs))
    var last_neg = xs[-1]                 # negative — 컴파일 에러 예상
    print(last_neg)
