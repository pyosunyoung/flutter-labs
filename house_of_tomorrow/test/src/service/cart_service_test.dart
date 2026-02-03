import 'package:flutter_test/flutter_test.dart';
import 'package:house_of_tomorrow/src/model/cart_item.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';

import '../../dummy.dart';

void main() {
  late CartService cartService;

  setUp(() {
    cartService = CartService(); // test 코드 실행 전 실행됨.
  }); // cartservice의 상태를 테스트 하기 위해선 항상 동일한 조건에서 테스트하기 위해 상태를 초기화 시켜주는 작업

  group('CartService', () {
    // group을 run하면 해당 group만 실행됨.
    group('add()', () {
      test('신규 CartItem을 cartItemList에 추가한다.', () {
        cartService.add(Dummy.cartItem);
        expect(cartService.cartItemList.length, 1); // 기대값2, 실제값1로 오류 발생
      });
    });

    group('selectedCartItemList', () {
      test('isSelected가 true인 CartItem만 반환한다.', () {
        cartService.add(
          Dummy.cartItem.copyWith(isSelected: true),
        ); //cartItem은 불변객체라 copyWith로 처리
        cartService.add(Dummy.cartItem.copyWith(isSelected: true));
        cartService.add(Dummy.cartItem.copyWith(isSelected: false));
        expect(cartService.selectedCartItemList.length, 2); // 2인 이유는 true가 2개라
        for (final cartItem in cartService.selectedCartItemList) {
          // 2개가 전부 true인지 반복문을 통해 확인작업
          expect(cartItem.isSelected, true);
        }
      });
    });

    group('update()', () {
      test('선택한 index의 CartItem을 수정한다.', () {
        cartService.add(Dummy.cartItem);
        CartItem newCartItem = Dummy.cartItem.copyWith(
          count: 100,
        ); // newCartItem과 add로 전달한 cartItem은 서로 다름
        cartService.update(0, newCartItem); // index는 0, 새로운 객체 전달
        expect(
          cartService.cartItemList[0],
          newCartItem,
        ); // 오류가 안나고 0번째와 newCartItem이 같기 떄문에 정상적으로 carItem에 newCartItem이 삽입 되었다고 볼 수 있음.
      });
    });

    group('delete()', () {
      test('deleteList에 포함된 cartItemList의 CartItem을 삭제한다.', () {
        cartService.add(Dummy.cartItem.copyWith(isSelected: true));

        cartService.add(Dummy.cartItem.copyWith(isSelected: true));

        cartService.add(Dummy.cartItem.copyWith(isSelected: false));

        cartService.add(Dummy.cartItem.copyWith(isSelected: false));
        cartService.delete(
          cartService.selectedCartItemList,
        ); // true인 두 아이템이 지워지면서 최종적으로 2개만 남게될것.
        expect(cartService.cartItemList.length, 2);
        for (final cartItem in cartService.selectedCartItemList) {
          // 2개가 전부 false인지 반복문을 통해 확인작업 => true인 것들은 모두 삭제되었으니.
          expect(cartItem.isSelected, false);
        }
      });
    });
  });
}
