import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/model/cart_item.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_bottom_sheet.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_color_preview.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_desc.dart';
import 'package:house_of_tomorrow/theme/component/cart_button.dart';
import 'package:house_of_tomorrow/theme/component/color_picker.dart';
import 'package:house_of_tomorrow/theme/component/pop_button.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key, required this.product});

  final Product product;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  //- 모든 상태를 부모인 `ProductView`에 속성으로 가지고 있는다.
  // - 자식 위젯은 속성을 전달 받고 이벤트를 부모에게 보낸다.
  /// 선택한 수량
  int count = 1;

  /// 선택한 색상
  int colorIndex = 0;

  /// 수량 업데이트 이벤트 함수
  void onCountChanged(int newCount) {
    setState(() {
      count = newCount;
    });
  }

  /// 색상 업데이트 이벤트 함수
  void onColorIndexChanged(int newColorIndex) {
    setState(() {
      colorIndex = newColorIndex;
    });
  }

  /// 카트에 상품 추가
  void onAddToCartPressed() {
    final CartService cartService = context.read();
    final CartItem newCartItem = CartItem(
      product: widget.product,
      colorIndex: colorIndex,
      count: count,
      isSelected: true,
    );
    cartService.add(newCartItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.product),
        leading: const PopButton(),
        titleSpacing: 0,
        actions: [CartButton()],
      ),
      body: Column(
        children: [
          Expanded(
            // 하단 bottomSheet는 하단에 고정되어지게 설정하고 여기 스크롤 뷰는 스크롤 가능하게 하기 위해 Column안에 expanded로 설정.
            child: SingleChildScrollView(
              //작은 화면에서 넘칠 수 있기 때문에 적용
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Wrap(
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: [
                  ///productColorPreview
                  ProductColorPreview(
                    colorIndex: colorIndex,
                    product: widget.product,
                  ),

                  ///ColorPicker
                  ColorPicker(
                    colorIndex: colorIndex,
                    colorList: widget.product.productColorList.map((e) {
                      return e.color; // Product Color type을 color로 변환시켜주는 작업
                    }).toList(),
                    onColorSelected: onColorIndexChanged,
                  ),

                  ///productDesc
                  ProductDesc(product: widget.product),
                ],
              ),
            ),
          ),

          ///ProductBottomSheet
          ProductBottomSheet(
            count: count,
            product: widget.product,
            onCountChanged: onCountChanged,
            onAddToCartPressed: onAddToCartPressed,
          ),
        ],
      ),
      //widget.이 붙은것은 생성자를 통해 넘겨받은 값을 여기서 사용할 수 있음.
    );
  }
}
