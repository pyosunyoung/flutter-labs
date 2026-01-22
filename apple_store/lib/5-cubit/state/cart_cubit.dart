import 'package:apple_store/common/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<List<Product>> {
  CartCubit() : super([]); //초기 상태값 설정

  /// 상품 클릭
  void onProductPressed(Product product) {
    if (state.contains(product)) {
      // state.remove(product);
      // emit(state);
      emit(state.where((element) => element != product).toList());
    } else {
      // state.add(product);
      // emit(state);
      emit([...state, product]);
    }
  }
}
