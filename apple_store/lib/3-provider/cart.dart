import 'package:apple_store/3-provider/state/provider_cart.dart';
import 'package:apple_store/common/product.dart';
import 'package:apple_store/common/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> cartProductList = context.select<ProviderCart, List<Product>>(
      //ProductCart안에 list를 가져오는데 그중 cartProductList를 반환하도록 설정
      //그리고 select로 설정하면 cartProductList가 변경되었을 시에만 build가 갱신 실행됨
      //하지만 이렇게 설정 시  참조 복사 문제 떄문에 제대로 실행되어지지 않음. => provider cart go go
      (providerCart) => providerCart.cartProductList,
    );

    return Scaffold(
      body: cartProductList.isEmpty
          /// Empty
          ? const Center(
              child: Text(
                "Empty",
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            )
          /// Not Empty
          : ListView.builder(
              itemCount: cartProductList.length,
              itemBuilder: (context, index) {
                Product product = cartProductList[index];
                return ProductTile(
                  product: product,
                  isInCart: true,
                  onPressed: context.read<ProviderCart>().onProductPressed,
                );
              },
            ),
    );
  }
}
