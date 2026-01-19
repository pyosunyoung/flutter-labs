// class A {
//   int value1;
//   int value2;

//   A({required this.value1, required this.value2});

//   @override
//   String toString() {
//     return "A(value1:$value1, value2:$value2)";
//   }
// }

// void main() {
//   A a = A(value1: 1, value2: 1);
//   A b = a; // 얕은 복사

//   a.value1 = 2;
//   print(a);
//   print(b);
// }

class A {
  final int value1;
  final int value2;

  const A({required this.value1, required this.value2});

  @override
  String toString() {
    return "A(value1:$value1, value2:$value2)";
  }

  A copyWith({int? value1, int? value2}) {
    return A(value1: value1 ?? this.value1, value2: value2 ?? this.value2);
  }
}

void main() {
  A a = A(value1: 1, value2: 1);
  A b = a; // 얕은 복사

  // a.value1 = 2; // 에러 발생
  // a = A(value1: 2, value2: a.value2); // 깊은 복사
  a = a.copyWith(
    value1: 2,
  ); // 깊은 복사(위처럼 일일히 저렇게 a.value2 적어줄 수 없으니 copywith 함수를 만듦)
  print(a);
  print(b);
}
