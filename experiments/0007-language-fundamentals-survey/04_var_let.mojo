# MOJO-8: var vs let — 0.26 시점의 mutability 모델

fn main():
    print("=== MOJO-8: var (let은 0.26부터 제거됨) ===\n")

    print("[var — 일반 가변 변수]")
    var x: Int = 10
    print("  var x = 10  →", x)
    x = 20
    print("  x = 20      →", x)

    print("\n[let — 더 이상 키워드가 아님 (이전 버전엔 immutable 선언이었음)]")
    print("  let y: Int = 30  ← 컴파일 에러 (별도 파일에서 검증)")
    print("  immutability는 'var' + 의도적 미재할당으로 표현하거나,")
    print("  파라미터 modifier(read = default in fn)로 표현.")

    print("\n[fn 파라미터 modifier로 표현되는 immutability]")
    print("  fn f(p: Int): ...           ← p는 읽기 전용 (default)")
    print("  fn f(read p: Int): ...      ← 명시적 동일")
    print("  fn f(mut p: Int): p += 1    ← 가변 참조")
    print("  fn f(var p: Int): ...       ← 함수가 소유 (consume)")

    print("\n[parameter — 컴파일 시점 상수]")
    var msg = build_msg[6]()    # 컴파일 타임 parameter (대괄호)
    print("  build_msg[6]() →", msg)

# 대괄호 = compile-time parameter (≒ const generic), 소괄호 = runtime arg
fn build_msg[N: Int]() -> String:
    return "compile-time N=" + String(N)
