import 'package:apple_store/common/product.dart';
import 'package:flutter/material.dart';

class InheritedCart extends InheritedWidget {
  const InheritedCart({
    super.key,
    required super.child,
    required this.cartProductList,
    required this.onProductPressed,
  });

  /// 카트에 담긴 상품 목록
  final List<Product> cartProductList;

  /// 상품 클릭
  final void Function(Product product) onProductPressed;

  @override
  bool updateShouldNotify(InheritedCart oldWidget) {
    //자식 업데이트 여부
    print("${cartProductList.length} / ${oldWidget.cartProductList.length}");
    return cartProductList != oldWidget.cartProductList;
    //현재와 이전 상태의 카트 length가 다른 경우 상태 없데이트
    //현재 같은 메모리를 참조하고 있어서 1/1 0/0 동일한 랭스가 업데이트
    //그래서 깊은 복사를 통해 서로 다른 메모리로 바꿔주자 home page에서 변경 ㄱㄱ
  }

  /// InheritedCart.of(context)로 손쉽게 접근
  static InheritedCart of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedCart>()!;
  }

  //class 내부에 있는 static 함수는 해당 클래스의 인스턴스를 생성할 필요 없이 클래스명.함수명으로 바로 접근할 수 있습니다.
  //자식 위젯에서 InheritedCart 위젯에 접근시 context.dependOnInheritedWidgetOfExactType<InheritedCart>()!; 대신 InheritedCart.of(context);로 보다 직관적이고 짧게 접근할 수 있습니다.
}

extension BuildContextExt on BuildContext {
  /// context.read<InheritedCart>()로 손s쉽게 접근
  T read<T extends InheritedWidget>() {
    return dependOnInheritedWidgetOfExactType<T>()!;
  }
}
