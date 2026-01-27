import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

class CounterBadge extends StatelessWidget {
  const CounterBadge({
    super.key,
    required this.child,
    required this.label,
    required this.isShow,
  });

  final Widget child;
  final String label;
  final bool isShow; //0인 경우 label을 보여줄 필요가 없기 떄문에 그에 맞는 조건식에 필요

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ///child widget
        child, //Button 넘겨준것
        ///badge
        Positioned(
          top: 10,
          right: 6,
          child: IgnorePointer(
            ignoring: true, // badge 클릭시 cart로 이동 안되는 오류 이렇게 해결
            child: CircleAvatar(
              backgroundColor: context.color.secondary,
              radius: isShow ? 10 : 0,
              child: Text(
                label,
                style: context.typo.body2.copyWith(
                  color: context.color.onSecondary,
                ),
              ),
            ),
          ),
        ),
      ],
    ); // 장바구니 아이콘 위에 카운팅 해줘야하기 때문에 위에 배치될 수 있게 Stack 사용
  }
}
