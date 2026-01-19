extension MyMachineExt on Machine {
  void scanning() => print("scanning...");
  void printing() => print("printing...");
} // extension은 그냥 machine이란 클래스에 해당 기능을 추가해주는 느낌인가?
//class 외부에서 기능을 추가해줄 수 있음.

class Machine {}

void main() {
  final machine = Machine();
  machine.printing();
  machine.scanning();
}

//그리고 소스코드를 수정할 수 없는 String 같은 것도 수정해줄 수 있음 아래 이런느낌
// hello 스트링에 접근해서 해당 기능을 사용할 수 있게 String클래스를 확장한 것.
// void main() {
//   /// extension function 호출
//   print('HELLO'.equalsIgnoreCase('hello')); // true
// }


// /// String 클래스를 확장
// extension MyStringExt on String {
  
//   /// Function
//   /// 대소문자 무시 비교
//   bool equalsIgnoreCase(String other) {
//     return toLowerCase() == other.toLowerCase();
//   }
// }
