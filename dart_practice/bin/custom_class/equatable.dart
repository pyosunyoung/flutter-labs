import 'package:equatable/equatable.dart';

class A extends Equatable {
  final int value;

  const A(this.value);

  @override
  List<Object?> get props => [value]; //특정 클래스가 Equatable을 상속받으면 props를 필수로 구현해야 합니다
}

//props는 비교시 사용하고 싶은 속성을 배열로 반환해 주면 됩니다.
void main() {
  print(A(1) == A(1));
  print(A(1));
}
