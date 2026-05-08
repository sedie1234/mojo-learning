# release notes: "Standard library types now use conditional conformances"
# Tuple이 Defaultable to test
def main():
    # Defaultable로 default 생성 가능한 type — Int
    var t: Tuple[Int, Int] = Tuple[Int, Int]()
    print(t[0], t[1])
