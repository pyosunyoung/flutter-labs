import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/lang_service.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/tile.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class SettingBottomSheet extends StatelessWidget {
  const SettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = context.theme.brightness == Brightness.light;
    final LangService langService = context.watch();
    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min, //children의 크기에 맞춤
        children: [
          /// Theme Tile
          Tile(
            icon: isLightTheme ? 'sunny' : 'moon',
            title: S.current.theme,
            subtitle: isLightTheme ? S.current.light : S.current.dark,
            onPressed: context.read<ThemeService>().toggleTheme,
          ),

          /// Lang Tile
          Tile(
            icon: 'language',
            title: S.current.language,
            subtitle: IntlHelper.isKo ? S.current.ko : S.current.en,
            onPressed: langService.toggleLang,
          ),
        ],
      ),
    );
  } // 다이얼로그 같이 다른 화면 위에 뜨는 위젯은 실제 코드상 위치와 위젯 트리상 위치가 다를 수 있음

  //인헤리티드 위젯과 같이 일부 기능
}
