import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

class AssetIcon extends StatelessWidget {
  const AssetIcon(this.icon, {super.key, this.color, this.size});
  //icon은 필수, 원래 required this.icon(이름지정 매개변수), 포지션 파라미터로 중괄호 앞에this.icon하면 동일한 결과물 가능
  // 나머지 this color, size는 선택적
  final String icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color ?? context.color.text, BlendMode.srcIn),
    );
  }
}
