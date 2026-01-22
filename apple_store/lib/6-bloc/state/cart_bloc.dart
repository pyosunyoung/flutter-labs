import 'package:apple_store/common/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable // 이게 붙으면 final 키워드를 모두 반드시 붙여줘야함.
abstract class CartEvent {
  const CartEvent(); // 하위 클래스인 OnProductPressed에서 불변 객체를 만들고 싶다면 부모 객체에서 이렇게 const로 만들어줘야함.
}

class OnProductPressed extends CartEvent {
  final Product product;

  const OnProductPressed(this.product);
}

class CartBloc extends Bloc<CartEvent, List<Product>> {
  CartBloc() : super(const []) {
    //const []를 붙여 애초에 불변객체로 만들어 add, remove를 사용하지 못하게 막아주자
    on<OnProductPressed>((event, emit) {
      if (state.contains(event.product)) {
        // state.remove(event.product);
        // emit(state);
        emit(state.where((element) => element != event.product).toList());
      } else {
        // state.add(event.product);
        // emit(state);
        emit([...state, event.product]);
      }
    });
  }
}
