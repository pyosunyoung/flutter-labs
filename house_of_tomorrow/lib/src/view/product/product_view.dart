import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/view/base_view.dart';
import 'package:house_of_tomorrow/src/view/product/product_view_model.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_color_preview.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_desc.dart';
import 'package:house_of_tomorrow/src/view/product/widget/product_layout.dart';
import 'package:house_of_tomorrow/theme/component/cart_button.dart';
import 'package:house_of_tomorrow/theme/component/color_picker.dart';
import 'package:house_of_tomorrow/theme/component/pop_button.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'widget/product_bottom_sheet.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.product});

  final Product product;
  //- 모든 상태를 부모인 `ProductView`에 속성으로 가지고 있는다.
  // - 자식 위젯은 속성을 전달 받고 이벤트를 부모에게 보낸다.
  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: ProductViewModel(
        product: product,
        cartService: context.read(),
      ),
      builder: (context, viewModel) => Scaffold( // viewModel에서 가져옴0
        appBar: AppBar(
          title: Text(S.current.product),
          leading: const PopButton(),
          titleSpacing: 0,
          actions: const [
            /// 카트 버튼
            CartButton(),
          ],
        ),
        body: ProductLayout(
          // 반응형 UI를 위한 ProductLayout적용
          // 하단 bottomSheet는 하단에 고정되어지게 설정하고 여기 스크롤 뷰는 스크롤 가능하게 하기 위해 Column안에 expanded로 설정.
          productInfo: SingleChildScrollView(
            //작은 화면에서 넘칠 수 있기 때문에 적용
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Wrap(
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: [
                /// ProductColorPreview
                ProductColorPreview(
                  colorIndex: viewModel.colorIndex,
                  product: product,
                ),

                /// ColorPicker
                ColorPicker(
                  colorIndex: viewModel.colorIndex,
                  colorList: product.productColorList.map((e) {
                    return e.color; // Product Color type을 color로 변환시켜주는 작업
                  }).toList(),
                  onColorSelected: viewModel.onColorIndexChanged,
                ),

                /// ProductDesc
                ProductDesc(product: product),
              ],
            ),
          ),

          /// ProductBottomSheet
          productBottomSheet: ProductBottomSheet(
            count: viewModel.count,
            product: product,
            onCountChanged: viewModel.onCountChanged,
            onAddToCartPressed: viewModel.onAddToCartPressed,
          ),
        ),
        //widget.이 붙은것은 생성자를 통해 넘겨받은 값을 여기서 사용할 수 있음.
      ),
    );
  }
}
