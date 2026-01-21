import 'package:apple_store/common/product.dart';
import 'package:flutter/material.dart';

class ProviderCart with ChangeNotifier {
  /// 카트에 담긴 상품 목록
  List<Product> cartProductList = [];

  /// 상품 클릭
  void onProductPressed(Product product) {
    if (cartProductList.contains(product)) {
      // cartProductList.remove(product);
      cartProductList = cartProductList.where((cartProduct) {
        return cartProduct != product;
      }).toList();
    } else {
      // cartProductList.add(product);
      cartProductList = [...cartProductList, product];
    }
    notifyListeners();
  }
}

//remove() 대신 where().toList()를 사용하고, add() 대신 전개 연산자(Spread Operator)를 이용하여 새로운 배열을 생성하였습니다.
//이렇게 하여 참조 복사 오류 문제 해결
