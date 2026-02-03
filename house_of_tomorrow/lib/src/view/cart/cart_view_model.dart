import 'package:house_of_tomorrow/src/model/cart_item.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/view/base_view_model.dart';
import 'package:house_of_tomorrow/theme/component/toast/toast.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class CartViewModel extends BaseViewModel {
  CartViewModel({required this.cartService}) {
    cartService.addListener(notifyListeners);
  } //cartservice의 값이 변할 시 알림을 보내면 CartviewModel 또한 동기화 되어지게 설정.
  //addLisster을 호출 시 remove Listener도 호출해줘야함. => 안해주면 notifyListeners가 cartViewModel이 제거된 뒤에도 계속 호출되어 메모리 누수 현상이 발생함.
  //즉 카트 viewmodel이 위젯트리에서 제거될 떄 removeListener로 제거해주면 됨.(주의 : 카트에서 뒤로가기 버튼 누르면 cartVIew는 위젯트리에서 제거됨.)
  final CartService cartService;

  @override
  void dispose() {
    cartService.removeListener(notifyListeners);
    super.dispose();
  }

  /// 전체 CartItem
  List<CartItem> get cartItemList => cartService.cartItemList;

  /// 선택한 CartItem 목록
  List<CartItem> get selectedCartItemList => cartService.selectedCartItemList;

  /// 최종 가격
  String get totalPrice {
    return cartService.selectedCartItemList.isEmpty
        ? '0'
        : IntlHelper.currency(
            // ,찍어주기 위해 currency 활용
            symbol: cartService.selectedCartItemList.first.product.priceUnit,
            number: cartService.selectedCartItemList.fold(0, (prev, curr) {
              return prev + curr.count * curr.product.price;
            }), // fold는 배열의 값들을 하나씩 거내 하나의 값으로 변환하는 함수, 0은 초기값
          );
  }

  /// 선택한 CartItem 삭제
  void onDeletePressed() {
    cartService.delete(cartService.selectedCartItemList);
    Toast.show(S.current.deleteDialogSuccessToast);
  }

  /// CartItem 클릭
  void onCartItemPressed(int index) {
    final cartItem = cartItemList[index];
    cartService.update(
      // 상품 체크 아이콘 변경
      index,
      cartItem.copyWith(isSelected: !cartItem.isSelected),
    ); //notifyListeners는 원래 호출해야하는데 위에서cartService.addListener(notifyListeners); 호출해주고 있기 때문에 생략
  }

  /// CartItem 개수 변경
  void onCountChanged(int index, int count) {
    final cartItem = cartItemList[index];
    cartService.update(index, cartItem.copyWith(count: count));
  }

  /// 선택한 CartItem 결제
  void onCheckoutPressed() {
    cartService.delete(cartService.selectedCartItemList);
    Toast.show(S.current.checkoutDialogSuccessToast);
  }
}
