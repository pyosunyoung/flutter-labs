import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/view/base_view_model.dart';
import 'package:house_of_tomorrow/theme/component/circular_indicator.dart';
import 'package:provider/provider.dart';

//각 들어오는 viewModel 이 다르게 때문에 제네릭 함수로 ㄱ, 이렇게 코드 작성하면 각 view에서 빌더 함수를 구현할 떄 전달 받은 viewModel을 이용할 수 있음.
class BaseView<T extends BaseViewModel> extends StatelessWidget {
  const BaseView({super.key, required this.viewModel, required this.builder});

  final T viewModel;
  final Widget Function(BuildContext context, T viewModel) builder;

  @override
  Widget build(BuildContext context) {
    // 이 context와 아래 consumer의 context는 다른거임.
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<T>(
        builder: (context, viewModel, child) {
          return CircularIndicator(
            isBusy: viewModel.isBusy,
            child: builder(context, viewModel),
          ); // builder는 각 위젯 builder에서 전달해줄 예정.
        },
      ),
    );
  }
}
