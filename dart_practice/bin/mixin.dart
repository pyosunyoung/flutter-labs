mixin class Scanner {
  void scanning() => print("scanning...");
}

mixin class Printer {
  void printing() => print("printing...");
}

class Machine with Printer, Scanner {}

void main() {
  final machine = Machine();
  machine.printing();
  machine.scanning();
}

// class Scanner {}       // mixin 불가능 & 인스턴스 생성 가능
// mixin Scanner {}       // mixin 가능 & 인스턴스 생성 불가능
// mixin class Scanner {} // mixin 가능 & 인스턴스 생성 가능
