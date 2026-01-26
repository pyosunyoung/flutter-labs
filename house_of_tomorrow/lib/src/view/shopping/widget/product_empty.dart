import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ProductEmpty extends StatelessWidget {
  const ProductEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    //productList가 비어있을 때 화면을 추가
    return Center(
      child: Text(
        S.current.noProduct,
        style: context.typo.headline4.copyWith(
          fontWeight: context.typo.light,
          color: context.color.inactive,
        ),
      ),
    );
  }
}