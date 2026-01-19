class Scanner {
  void scanning() => print("scanning...");
}

class Printer extends Scanner {
  // 여기서 extends로 추가해줘야함.
  void printing() => print("printing...");
}

class Machine extends Printer {} 
// dart에선 Printer, Scanner이렇게 다중상속 지원 x =-> 이것을 해결하는게 mixin이란 것. 다중상속 지원 가능해짐.

void main() {
  final machine = Machine();
  machine.printing();
  machine.scanning();
}
