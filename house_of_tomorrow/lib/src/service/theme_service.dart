//앱의 전역에서 접근하는 클래스는 service라는 이름으로 만들어 관리하도록 하겠습니다.
import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/theme/dark_theme.dart';
import 'package:house_of_tomorrow/theme/foundation/app_theme.dart';
import 'package:house_of_tomorrow/theme/light_theme.dart';
import 'package:provider/provider.dart';

class ThemeService with ChangeNotifier {
  ThemeService({AppTheme? theme}) : theme = theme ?? LightTheme();
  // ThemeService에 theme을 넘겨주지 않은 경우 디폴트 값으로 LightTheme이 사용되어지게 설정.

  //현재 테마
  AppTheme theme;

  /// 테마 변경

  void toggleTheme() {
    if (theme.brightness == Brightness.light) {
      theme = DarkTheme();
    } else {
      theme = LightTheme();
    }
    notifyListeners();
  }

  /// Material ThemeData 커스텀
  ThemeData get themeData {
    return ThemeData(
      /// Scaffold
      scaffoldBackgroundColor: theme.color.surface,

      /// AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: theme.color.surface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: theme.color.text),
        titleTextStyle: theme.typo.headline2.copyWith(color: theme.color.text),
      ),
    );
  }
}

extension ThemeServiceExt on BuildContext {
  ThemeService get themeService => watch<ThemeService>();
  AppTheme get theme => themeService.theme;
  AppColor get color => theme.color;
  AppDeco get deco => theme.deco;
  AppTypo get typo => theme.typo;
}
