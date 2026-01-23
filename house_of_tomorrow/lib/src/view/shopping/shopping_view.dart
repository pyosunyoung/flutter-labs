import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class ShoppingView extends StatelessWidget {
  const ShoppingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 다국어 사용 필요시 S
      appBar: AppBar(
        title: Text(S.current.shopping),
        actions: [
          Button(
            icon: 'option',
            type: ButtonType.flat,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  //화면에 보여질 위젯
                  return SettingBottomSheet();
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: TextButton(
          onPressed: context.read<ThemeService>().toggleTheme,
          child: Text("Toggle Theme", style: context.typo.headline6),
        ),
      ),
    );
  }
}
