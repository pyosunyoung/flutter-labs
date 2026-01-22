import 'dart:async';

import 'package:apple_store/5-cubit/state/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BadgeCubit extends Cubit<int> {
  BadgeCubit({required CartCubit cartCubit}) : super(0) {
    cartCubitSubs = cartCubit.stream.listen((cartProductList) { // cartCubit 구독
      emit(cartProductList.length);
    });
  }

  late final StreamSubscription cartCubitSubs;

  @override
  Future<void> close() { // 더이상 필요 없을 시 구독 해제
    cartCubitSubs.cancel();
    return super.close();
  }
}
