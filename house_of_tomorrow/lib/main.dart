import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:house_of_tomorrow/src/repository/product_repository.dart';
import 'package:house_of_tomorrow/src/service/cart_service.dart';
import 'package:house_of_tomorrow/src/service/lang_service.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:house_of_tomorrow/util/route_path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ProductRepository(),
        ), //changenotifierProvider를 상속받을 필요가 없기떄문에 일반 provider로 설정, 이렇게하면 buildcontext를 통해 어디서든 접근 가능.
        ChangeNotifierProvider(create: (context) => ThemeService()),
        ChangeNotifierProvider(create: (context) => LangService()),
        ChangeNotifierProvider(create: (context) => CartService()),
      ],
      child: const MyApp(),
    ),
  );
}

// GlobalKey를 이용하면 특정 StatefulWidget의 BuildContext를 가져올 수 있습니다.
// MaterialApp은 화면이 쌓인 상태를 NavigatorState로 가지고 있으며, 해당 상태의 BuildContext를 GlobalKey로 가져와 활용하도록 하겠습니다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(); // 어디서든 이 키에 접근하기 위해 Static 붙임

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) {
        //build를 통해 Overlay를 추가시켜서 No Overlay widget found 에러 해결
        return Overlay(
          initialEntries: [OverlayEntry(builder: (context) => child!)],
        );
      },
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: context
          .watch<LangService>()
          .locale, // 앱 내부에서 사용하도록 접근, 한국어, 영어 변환이 있기 떄문에 watch 사용
      theme: context.themeService.themeData, //watch이미 해줘서 다시 watch로 접근할 필요가 없음.
      initialRoute: RoutePath.shopping, //초기 페이지
      onGenerateRoute: RoutePath.onGenerateRoute, //get
    );
  }
}
