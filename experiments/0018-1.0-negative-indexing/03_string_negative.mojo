# String도 negative index 차단되는지 확인
def main():
    var s: String = "hello"
    var c = s[-1]                     # ★ 컴파일 에러 예상
    print(c)
