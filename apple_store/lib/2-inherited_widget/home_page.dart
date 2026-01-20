import 'package:apple_store/2-inherited_widget/cart.dart';
import 'package:apple_store/2-inherited_widget/state/inherited_cart.dart';
import 'package:apple_store/2-inherited_widget/store.dart';
import 'package:apple_store/common/bottom_bar.dart';
import 'package:apple_store/common/product.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 현재 선택된 index
  int currentIndex = 0;

  /// 카트에 담긴 상품 목록
  List<Product> cartProductList = [];

  /// 상품 클릭
  void onProductPressed(Product product) {
    setState(() {
      // 이곳 떄문에 얕은 복사가 됨. => 새로운 객체를 만들어서 매번 다른 참조를 가지게 설정.
      if (cartProductList.contains(product)) {
        cartProductList = cartProductList.where((element) {
          // 새로운 배열을 만들어서 할당.
          return element != product;
        }).toList();
        //원래 cartProductList.remove 파트의 얕은 복사 문제 해결
      } else {
        cartProductList = [
          ...cartProductList,
          product,
        ]; // 새로운 배열 재할당. 이렇게 하면 상태 변경 시 재할당
        //원래 cartProductList.add파트의 얕은 복사 문제 해결
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedCart(
      // 상위에 배치
      cartProductList: cartProductList,
      onProductPressed: onProductPressed,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: const [
            /// Store
            Store(),

            /// Cart
            Cart(),
          ],
        ),
        bottomNavigationBar: Builder(
          builder: (context) {
            final inheritedCart = context.read<InheritedCart>();
            return BottomBar(
              currentIndex: currentIndex,
              cartTotal: "${inheritedCart.cartProductList.length}",
              onTap: (index) => setState(() {
                currentIndex = index;
              }),
            );
          },
        ),
      ),
    );
  }
}


// 저장 단축키(Ctrl/Cmd + S)를 눌러 Hot Reload 실행하는 경우 아래와 같이 에러가 발생합니다. 코드상에서 에러는 dependOnInheritedWidgetOfExactType<T>()에서 null을 반환하였기 때문에 !에서 에러가 발생한 것 입니다.

// dependOnInheritedWidgetOfExactType<T>()에서 null을 반환한 원인은, HomePage에서 context.read<InheritedCart>();에서 사용된 BuildContext는 아직 InheritedCart가 생성되기 전의 BuildContext 이므로 위젯트리 위치상 부모 위젯에 InheritedCart 위젯이 존재하지 않기 때문입니다.