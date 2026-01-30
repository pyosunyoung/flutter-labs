import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_card.dart';
import 'package:house_of_tomorrow/theme/res/layout.dart';

class ProductCardGrid extends StatelessWidget {
  const ProductCardGrid(this.productList, {super.key});

  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      // 세로 방향으로 무제한 늘어날 수 있는 위젯임
      crossAxisCount: context.layout(2, tablet: 3, desktop: 4), // grid를 2줄로
      mainAxisSpacing: 24, //각 product의 세로 간격
      crossAxisSpacing: 16, //가로 줄 간격
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return ProductCard(product: product);
      },
    );
  }
}
