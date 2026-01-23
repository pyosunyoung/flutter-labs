import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/theme/res/typo.dart';

part 'app_color.dart';
part 'app_deco.dart';
part 'app_typo.dart';

//part는 한곳으로 파일을 합치기 위해 사용한다. 약간 router 느낌?
abstract class AppTheme {
  late final Brightness brightness;
  late final AppColor color;
  late final AppDeco deco;
  late final AppTypo typo;
}
