import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/res/layout.dart';

//스크린 크기가 1190 보다 커져도 UI는 1190을 유지하도록 만들어 봅시다.
class ConstrainedScreen extends StatelessWidget {
  const ConstrainedScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.color.surface,
      alignment: Alignment.center, // Cent위젯과 동일해서 아래 Center 감싼거 제거.
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Breakpoints.desktop),
        child: child,
      ),
    );
  }
}

// Flutter 공식 문서에 나와있는 예제를 보면, 화면의 첫 번째 위젯은 항상 스크린 크기와 같은 크기를 갖도록 강제되어 있습니다. Center 위젯으로 Container를 감싸면 Center가 스크린 크기를 차지하고, 자식 위젯에게 원하는 크기를 갖도록 해줍니다.
// 여기선 아마 ConstrainedBox가 첫번쨰였는데 크기가 같은 크기를 갖도록 강제해서 크기를 바꿔주기 위해 Center를 넘어서 자식 위젯 즉 자식인 ConstrainedBox의 크기를 바꿔줄 수 있음
