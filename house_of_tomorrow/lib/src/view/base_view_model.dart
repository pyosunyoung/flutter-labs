import 'package:flutter/material.dart';
//baseviewModel은 모든 viewmodel이 상속받도록 하는 base
class BaseViewModel with ChangeNotifier {
  bool _isBusy = false; //_은 private 변수

  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners(); //이렇게하면 isBusy가 변경된다면 화면이 갱신됨.
  } //true 경우 로딩로직을 보여주고, false시 없어짐

  //상태 변수가 바뀔 떄 화면이 갱신되어야 하기 떄문에 getter setter로 gogo
}
