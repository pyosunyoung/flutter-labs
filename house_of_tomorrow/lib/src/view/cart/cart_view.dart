import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_bottom_sheet.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_empty.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_item_tile.dart';
import 'package:house_of_tomorrow/theme/component/pop_button.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartService cartService = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.cart),
        leading: const PopButton(),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartService.cartItemList.isEmpty
                ///Empty
                ? CartEmpty()
                /// Not Empty
                : ListView.builder(
                    itemCount: cartService.cartItemList.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartService.cartItemList[index];
                      return CartItemTile(
                        cartItem: cartItem,
                        onPressed: () {
                          cartService.update(
                            // 상품 체크 아이콘 변경
                            index,
                            cartItem.copyWith(isSelected: !cartItem.isSelected),
                          );
                        },
                        onCountChanged: (count) {
                          cartService.update(
                            index,
                            cartItem.copyWith(count: count),
                          );
                        },
                      );
                    },
                  ),
          ),

          ///CartBottomSheet
          CartBottomSheet(
            totalPrice: cartService.selectedCartItemList.isEmpty
                ? '0'
                : IntlHelper.currency(
                    // ,찍어주기 위해 currency 활용
                    symbol: cartService
                        .selectedCartItemList
                        .first
                        .product
                        .priceUnit,
                    number: cartService.selectedCartItemList.fold(0, (
                      prev,
                      curr,
                    ) {
                      return prev + curr.count * curr.product.price;
                    }), // fold는 배열의 값들을 하나씩 거내 하나의 값으로 변환하는 함수, 0은 초기값
                  ),
            selectedCartItemList: cartService.selectedCartItemList,
            onCheckoutPressed: () {},
          ),
        ],
      ),
    );
  }
}
