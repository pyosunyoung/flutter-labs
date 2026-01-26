import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';

class ProductColorPreview extends StatelessWidget {
  const ProductColorPreview({
    super.key,
    required this.colorIndex,
    required this.product,
  });

  final int colorIndex;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: context.deco.shadow,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          AspectRatio(
            //폭과 높이를 지정하는 위젯
            aspectRatio: 1 / 0.8, // 폭 / 높이
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(24),
              child: CachedNetworkImage(
                //이미지 최적화 작업, 이미지 로딩, 캐싱
                //image를 불러오는 동안 이미지의 크기가 없어서 색상 선택시 이미지 밖 흰색 박스 UI가 올라갔다 사라졌다 다시 뜨는 오류가 발생 => 해결 AspectRatio로
                imageUrl: product.productColorList[colorIndex].imageUrl,
                width: double.infinity, // 이미지를 가득 채움.
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),

          /// Name
          Text(
            product.name.toString(),
            style: context.typo.headline1.copyWith(
              fontWeight: context.typo.semiBold,
            ),
          ), // Lang type은 toString을 현재 설정된 이름에 맞는 언어로 보여지게 설정(다국어)
          const SizedBox(height: 4),
          Row(
            children: [
              ///Brand
              Text(
                product.brand.toString(),
                style: context.typo.subtitle1.copyWith(
                  fontWeight: context.typo.light,
                  color: context.color.subtext,
                ),
              ),

              const Spacer(),

              ///Price
              Text(
                IntlHelper.currency(
                  symbol: product.priceUnit,
                  number: product.price,
                ),
                style: context.typo.headline6.copyWith(
                  color: context.color.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
