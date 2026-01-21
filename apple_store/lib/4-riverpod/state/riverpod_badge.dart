import 'package:apple_store/4-riverpod/state/riverpod_cart.dart';
import 'package:apple_store/common/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final badeProvider = NotifierProvider<RiverpodBadge, int>(RiverpodBadge.new);

class RiverpodBadge extends Notifier<int> {
  @override
  int build() {
    List<Product> cartProductList = ref.watch(cartProvider);
    return cartProductList
        .length; // cartProductList length가 변하면 계속 build가 실행될것 여러 provider를 상호작용 한 것.
  }
}
