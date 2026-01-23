import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/base_bottom_sheet.dart';

class SettingBottomSheet extends StatelessWidget {
  const SettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseBottomSheet(child: Text("hello bottom sheet!!"));
  } // 다이얼로그 같이 다른 화면 위에 뜨는 위젯은 실제 코드상 위치와 위젯 트리상 위치가 다를 수 있음

  //인헤리티드 위젯과 같이 일부 기능
}
