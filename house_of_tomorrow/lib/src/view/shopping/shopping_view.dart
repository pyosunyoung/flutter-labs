import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_card_grid.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_empty.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/theme/component/hide_keyboard.dart';
import 'package:house_of_tomorrow/theme/component/input_field.dart';
import 'package:house_of_tomorrow/util/helper/network_helper.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  List<Product> productList = [];

  final TextEditingController textController = TextEditingController();

  String get keyword => textController.text.trim(); // 검색한 텍스트를 반환

  Future<void> searchProductList() async {
    try {
      final res = await NetworkHelper.dio.get(
        'https://gist.githubusercontent.com/nero-angela/d16a5078c7959bf5abf6a9e0f8c2851a/raw/04fb4d21ddd1ba06f0349a890f5e5347d94d677e/ikeaSofaDataIBB.json',
      );

      setState(() {
        //product list의 값이 바뀌었기 떄문에 화면 갱신
        productList = jsonDecode(res.data)
            .map<Product>((json) {
              return Product.fromJson(json);
            })
            .where((product) {
              /// 키워드가 비어있는 경우 모두 반환
              if (keyword.isEmpty) return true;

              /// name이나 brand에 키워드 포함 여부 확인
              return "${product.name}${product.brand}".toLowerCase().contains(
                keyword.toLowerCase(),
              );
            })
            .toList(); //json type의 문제열을 dart의 배열이 map으로 변경
      });
    } catch (e, s) {
      log(
        'Failed to searchProductList',
        error: e,
        stackTrace: s,
      ); //stackTrace는 어떤 파일 몇번째 줄에서 오류가 발생했는지 알 수 있음.
    }
  }

  //ShoppingView가 시작될 때 initState()에서 검색을 하도록
  @override
  void initState() {
    super.initState();
    searchProductList();
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyboard(
      child: Scaffold(
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
                      controller: textController,
                      onClear:
                          searchProductList, // 검색의 x버튼을 클릭했을 떄 productlist다시 가져오는 로직
                      onSubmitted: (text) =>
                          searchProductList, //함수의 입력 파라미터가 맞지 않아 익명
                      hint: S
                          .current
                          .searchProduct, //다국어는 언어마다 달라져서 const를 붙일 수 없음.
                    ),
                  ), // Row위젯 안에 textField가있을 시 무제한으로 늘어나는 어류를 Expanded를 안에 넣어서 해결
                  const SizedBox(width: 16),

                  ///검색 버튼
                  Button(icon: 'search', onPressed: searchProductList),
                ],
              ),
            ),

            /// ProductCartList
            Expanded(
              child: productList.isEmpty
                  ? ProductEmpty()
                  : ProductCardGrid(productList),
            ), // expanded는 영역 내에서 가장 넓은 범위를 차지하게 됨. 즉 제약 조건이 생겨 세로가 무제한으로 안늘어나게 됨.
          ],
        ),
      ),
    );
  }
}
