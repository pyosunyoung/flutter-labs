import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({
    super.key,
    required this.child,
    required this.isBusy,
  });

  final Widget child;
  final bool isBusy;
  //child로 받은 것을 배경으로 깔고 그 위에 isBusy가 true일 시 로딩 애니메이션을 보여줄 것.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        ///CircularIndicator -> 로딩 UI
        IgnorePointer( //이게 없으면 버튼 이벤트가 동작하지 않음. 왜냐 container가 이 버튼 이벤트를 모두 잡아먹고 있음 그래서 ignoring 사용
        // 또한 투명한 경우 클릭하지 못하도록 IgnorePointer 위젯을 사용하였습니다. , 자식(container)이 이벤트를 받지 못하게 사용할 수 있음
          ignoring: !isBusy, // true시 버튼 이벤트 작동.
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 222),
            opacity: isBusy
                ? 1
                : 0, // opacity, duration은 필수 매개변수 -> opactiy 0일시 배경 어두워짐.
            child: Container(
              color: context.color.background,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: context.color.primary,
                value: isBusy ? null : 0, // null 일시 로딩 애니메이션 작동
              ),
            ),
          ),
        ),
      ],
    );
  }
}
