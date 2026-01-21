import 'package:apple_store/3-provider/cart.dart';
import 'package:apple_store/3-provider/state/provider_badge.dart';
import 'package:apple_store/3-provider/state/provider_cart.dart';
import 'package:apple_store/3-provider/store.dart';
import 'package:apple_store/common/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 현재 선택된 index
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderCart()),
        ChangeNotifierProvider(
          create: (context) => ProviderBadge(providerCart: context.read()),
        ), // providerBadge는 providerCart를 의존하기 떄문에 아래에 등록해줘야 함.
      ], //Provider 등록
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: const [
            /// Store
            Store(),

            /// Cart
            Cart(),
          ],
        ),
        bottomNavigationBar: Selector<ProviderBadge, int>(
          // provider counter의 값이 변경 시 builder가 갱신되어지게 selector로 설정.
          selector: (context, providerBadge) => providerBadge.counter,
          builder: (context, counter, child) => BottomBar(
            currentIndex: currentIndex,
            cartTotal: "$counter",
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}
