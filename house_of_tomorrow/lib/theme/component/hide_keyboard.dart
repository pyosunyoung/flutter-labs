import 'package:flutter/material.dart';

class HideKeyboard extends StatelessWidget {
  const HideKeyboard({
    super.key,
    required this.child,
  });

  final Widget child; // 자식 위젯을 생성자로부터 전달받음
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: child,
    );
  }
}