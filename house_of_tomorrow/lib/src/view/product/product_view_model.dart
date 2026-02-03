import 'package:house_of_tomorrow/src/model/cart_item.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/view/base_view_model.dart';
import 'package:house_of_tomorrow/theme/component/toast/toast.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class ProductViewModel extends BaseViewModel {
  ProductViewModel({required this.cartService, required this.product});

  //BuildContext는 어떤 위젯에서 가져오느냐에 따라 다른 정보가 들어있기 때문에 ViewModel에서 다루는 것은 좋지 않으므로,
  // CartService를 전달받도록 구현하였습니다.
  final CartService cartService;

  /// 선택한 상품
  final Product product;

  //- 모든 상태를 부모인 `ProductView`에 속성으로 가지고 있는다.
  // - 자식 위젯은 속성을 전달 받고 이벤트를 부모에게 보낸다.
  /// 선택한 수량
  int count = 1;

  /// 선택한 색상
  int colorIndex = 0;

  /// 수량 업데이트 이벤트 함수
  void onCountChanged(int newCount) {
    count = newCount;
    notifyListeners();
  }

  /// 색상 업데이트 이벤트 함수
  void onColorIndexChanged(int newColorIndex) {
    colorIndex = newColorIndex;
    notifyListeners();
  }

  /// 카트에 상품 추가
  void onAddToCartPressed() {
    // final CartService cartService = context.read(); => 이게 위 내용처럼 수정됨.
    final CartItem newCartItem = CartItem(
      colorIndex: colorIndex,
      count: count,
      isSelected: true,
      product: product,
    );
    cartService.add(newCartItem);
    Toast.show(S.current.productAdded(product.name));
  }
}
