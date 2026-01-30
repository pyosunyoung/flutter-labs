import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/theme/res/layout.dart';

class ProductLayout extends StatelessWidget {
  const ProductLayout({
    super.key,
    required this.productInfo,
    required this.productBottomSheet,
  });

  final Widget productInfo;
  final Widget productBottomSheet;

  @override
  Widget build(BuildContext context) {
    return context.layout(
      /// Mobile & tablet
      Column(
        children: [
          Expanded(child: productInfo),
          productBottomSheet,
        ],
      ),

      ///DeskTop
      desktop: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: productInfo), //공간을 3개로 분할해서 이건 2개 차지
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: productBottomSheet,
              ),
            ), // 이건 1개차지
          ],
        ),
      ), // Expanded적용해서 영역 제한줘서 오류 해결
    );
  }
}

///desktop에서만 bottomSheet가 우측으로 이동된 것을 확인 할 수 있습니다.(Row)
/// 나머진 모두 Column으로 구현하면 될듯
