import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/src/view/base_view.dart';
import 'package:house_of_tomorrow/src/view/cart/cart_view_model.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_bottom_sheet.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_checkout_dialog.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_delete_dialog.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_empty.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_item_tile.dart';
import 'package:house_of_tomorrow/src/view/cart/widget/cart_layout.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/theme/component/pop_button.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    //cartservice를 내부적으로 이용하기 때문에 StatelessWidget로 사용가능했었음. 이젠 내부적이 아닌 cart_view_model로 비지니스 로직을 옮겨보자
    return BaseView(
      viewModel: CartViewModel(cartService: context.read()),
      builder: (context, viewModel) => Scaffold(
        appBar: AppBar(
          title: Text(S.current.cart),
          leading: const PopButton(),
          titleSpacing: 0,
          actions: [
            ///Delete Button
            Button(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CartDeleteDialog(
                      onDeletePressed: viewModel.onDeletePressed,
                    );
                  },
                );
              },
              text: S.current.delete,
              type: ButtonType.flat,
              color: context.color.secondary,
              isInactive: viewModel
                  .selectedCartItemList
                  .isEmpty, // 선택된 리스트에 아무것도 없다면 버튼 비활성화
            ),
          ],
        ),
        body: CartLayout(
          //반응형 UI 위해
          ///CartItemList
          cartItemList: viewModel.cartItemList.isEmpty
              ///Empty
              ? CartEmpty()
              /// Not Empty
              : ListView.builder(
                  itemCount: viewModel.cartItemList.length,
                  itemBuilder: (context, index) {
                    final cartItem = viewModel.cartItemList[index];
                    return CartItemTile(
                      cartItem: cartItem,
                      onPressed: () {
                        viewModel.onCartItemPressed(index);
                      },
                      onCountChanged: (count) {
                        viewModel.onCountChanged(index, count);
                      },
                    );
                  },
                ),

          cartBottomSheet: CartBottomSheet(
            totalPrice: viewModel.totalPrice,
            selectedCartItemList: viewModel.selectedCartItemList,
            onCheckoutPressed: () {
              ///CheckoutDialog
              showDialog(
                context: context,
                builder: (context) {
                  return CartCheckoutDialog(
                    onCheckoutPressed: viewModel.onCheckoutPressed,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
