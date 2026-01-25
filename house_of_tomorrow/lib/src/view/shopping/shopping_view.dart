import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/theme/component/input_field.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

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
                // isScrollControlled: true, // 전체 시트 채우기 현재 기능에선 불필요
                builder: (context) {
                  //화면에 보여질 위젯
                  return SettingBottomSheet();
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                ///검색
                Expanded(
                  child: InputField(
                    hint: S
                        .current
                        .searchProduct, //다국어는 언어마다 달라져서 const를 붙일 수 없음.
                  ),
                ), // Row위젯 안에 textField가있을 시 무제한으로 늘어나는 어류를 Expanded를 안에 넣어서 해결
                const SizedBox(width: 16),

                ///검색 버튼
                Button(icon: 'search', onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
