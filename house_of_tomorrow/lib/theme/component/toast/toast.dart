import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/main.dart';
import 'package:house_of_tomorrow/theme/component/toast/toast_builder.dart';

abstract class Toast {
  static void show(
    String text, {
    Duration duration = const Duration(seconds: 3), // toast를 몇초간 보여줄지
  }) async {
    BuildContext? context = MyApp
        .navigatorKey
        .currentContext; // NavigatorKey를 통해matrial app에 있는 buildcontext를 모두 가져올 수 있음
    //matrial app이 아직 위젯 트리에 등록되지 않은 상태일 수 있어 ? 붙여줌
    if (context == null) return; // => 그에대한 조건문

    /// Insert
    GlobalKey<ToastBuilderState> toastKey = GlobalKey();
    //GlobalKey을 이용하면 특정 StatefulWidget의 State 및 BuildContext에 접근할 수 있습니다.
    /// Overlay를 이용하면 특정 위젯을 화면의 레이아웃과 상관없이 위에 그릴 수 있습니다.
    final overlay = Overlay.of(context);
    final animDuration = Duration(milliseconds: 333);
    final toast = OverlayEntry(
      builder: (context) =>
          ToastBuilder(key: toastKey, text: text, animDuration: animDuration),
    ); // 이부분 해석 필요
    overlay.insert(toast);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      toastKey.currentState?.isShow =
          true; // 정상 출력. // 서로 연결된 후에 isShow를 true로 변경.
    });
    // print(toastKey.currentState?.isShow);// null 출력 // globalkey는 특정 위젯의 상태에 접근할 수 있음., key가 아직 위젯끼리 연결 안되었을 수 있으니 ? 붙여줌.
    //즉 null이 나온다면? toast와 widget트리가 아직 안붙은 상태
    /// Remove
    await Future.delayed(duration); //정해진 시간을 기다림 3초
    toastKey.currentState?.isShow = false;
    await Future.delayed(animDuration);
    toast.remove(); // 이 entry를 overlay에서 제거하는 것.
  }
}

// - `MaterialApp`에 있는 `Navigator`가 `Overlay`를 생성합니다.
// - `BuildContext`를 이용해 `Overlay` 위젯을 가져옵니다.
// - 화면에 그릴 위젯을 `OverlayEntry`로 생성합니다.
// - `Overlay`에 생성한 `OverlayEntry`를 `insert()`하면 화면에 나타납니다.
