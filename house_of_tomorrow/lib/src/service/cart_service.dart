import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/model/cart_item.dart';
import 'package:house_of_tomorrow/util/helper/immutable_helper.dart';

class CartService with ChangeNotifier {
  /// 상품 목록
  List<CartItem> cartItemList = const [];

  /// 선택된 상품 목록 반환 getter 함수
  List<CartItem> get selectedCartItemList {
    // 카트 함수에서 선택한 항목들을 가져올 때 이 함수를 이용
    return cartItemList.where((cartItem) => cartItem.isSelected).toImmutable();
  }

  /// 상품 추가
  void add(CartItem newCartItem) {
    cartItemList = [
      ...cartItemList,
      newCartItem,
    ].toImmutable(); // unmodifiable를 더욱 편리하게 => toImmutable
    //런타임에 새롭게 생성되는 cartItemList 배열도 불변을 유지하도록 List.unmodifiable()를 이용
    notifyListeners();
  }

  /// 상품 수정
  void update(int selectedIndex, CartItem newCartItem) {
    cartItemList = cartItemList.asMap().entries.map(
      (entry) {
        return entry.key == selectedIndex ? newCartItem : entry.value;
      },
    ).toImmutable(); //전달 받은 key와 선택된 indeㅌ가 같으면 newCartItem에 넣어줌. 아니면 기존 value 유지.
    notifyListeners();
  }

  /// 상품 삭제
  void delete(List<CartItem> deleteList) {
    cartItemList = cartItemList.where((cartItem) {
      return deleteList.contains(cartItem); // deleteList에 들어있지 않은 cartItem만 반환.
    }).toImmutable();
    notifyListeners();
  }
}
