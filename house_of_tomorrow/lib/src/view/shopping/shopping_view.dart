import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/view/base_view.dart';
import 'package:house_of_tomorrow/src/view/shopping/shopping_view_model.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_card_grid.dart';
import 'package:house_of_tomorrow/src/view/shopping/widget/product_empty.dart';
import 'package:house_of_tomorrow/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';
import 'package:house_of_tomorrow/theme/component/cart_button.dart';
import 'package:house_of_tomorrow/theme/component/hide_keyboard.dart';
import 'package:house_of_tomorrow/theme/component/input_field.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  late final ShoppingViewModel shoppingViewModel =
      ShoppingViewModel(
        productRepository: context.read() //stateful 위젯에서 빌드 context를 사용하려면 앞에 late 키워드를 붙여줘야함.
      ); // 이렇게 속성을 추가해주면 됨.
  //ShoppingView가 시작될 때 initState()에서 검색을 하도록
  @override
  void initState() {
    super.initState();
    shoppingViewModel
        .searchProductList(); // searchProductList() => shoppingViewModel.searchProductList() 이렇게 변경하면 상품 안보여지는 오류 해결.

    //searchProductList는 ShoppingviewModel 안에 있어서 ViewModel에  stateless같은 iniState를 통해 viewModel 안에 있는 함수로 호출되어지기 떄문에
    /// viewModel을 stateful widget에 속성을 추가해줘야함.
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      // base_View적용
      viewModel: shoppingViewModel,
      builder: (context, viewModel) => HideKeyboard(
        child: Scaffold(
          // 다국어 사용 필요시 S
          appBar: AppBar(
            title: Text(S.current.shopping),
            actions: [
              /// 설정 버튼
              Button(
                icon: 'option',
                type: ButtonType.flat,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    // isScrollControlled: true, // 전체 시트 채우기 현재 기능에선 불필요
                    builder: (context) {
                      //화면에 보여질 위젯
                      return SettingBottomSheet();
                    },
                  );
                },
              ),

              ///카트 버튼
              const CartButton(),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    ///검색
                    Expanded(
                      child: InputField(
                        controller: viewModel
                            .textController, // textController => viewModel.textController, view model 적용해서 이렇게 변경
                        onClear: viewModel.searchProductList, // 검색의 x버튼을 클릭했을 떄 productlist다시 가져오는 로직
                        onSubmitted: (text) =>
                            viewModel.searchProductList, //함수의 입력 파라미터가 맞지 않아 익명
                        hint: S
                            .current
                            .searchProduct, //다국어는 언어마다 달라져서 const를 붙일 수 없음.
                      ),
                    ), // Row위젯 안에 textField가있을 시 무제한으로 늘어나는 어류를 Expanded를 안에 넣어서 해결
                    const SizedBox(width: 16),

                    ///검색 버튼
                    Button(
                      icon: 'search',
                      onPressed: viewModel.searchProductList,
                    ),
                  ],
                ),
              ),

              /// ProductCartList
              Expanded(
                child: viewModel.productList.isEmpty
                    ? ProductEmpty()
                    : ProductCardGrid(viewModel.productList),
              ), // expanded는 영역 내에서 가장 넓은 범위를 차지하게 됨. 즉 제약 조건이 생겨 세로가 무제한으로 안늘어나게 됨.
            ],
          ),
        ),
      ),
    );
  }
}
