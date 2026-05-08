# String __getitem__ 새 시그너처 — byte: keyword 사용
def main():
    var s: String = "hello"
    var c = s[byte=0]            # 추정 시그너처
    print(c)
