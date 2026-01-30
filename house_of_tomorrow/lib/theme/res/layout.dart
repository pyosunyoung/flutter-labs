import 'package:flutter/material.dart';

abstract class Breakpoints {
  /// Device max width
  static const double mobile = 600;
  static const double tablet = 1000;
  static const double desktop = 1190;

  /// BottomSheet max width
  static const double bottomSheet = 600;
}

extension LayoutExt on BuildContext {
  /// Screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Responsive layout
  T layout<T>(T base, {T? mobile, T? tablet, T? desktop}) {
    if (screenSize.width < Breakpoints.mobile) {
      //현재 기기의 사이즈가 브레이크포인트 mobile width 보다 작다면? mobile 반환
      return mobile ?? base;
    } else if (screenSize.width < Breakpoints.tablet) {
      return tablet ?? base;
    } else {
      return desktop ?? base;
    }
  }
}
