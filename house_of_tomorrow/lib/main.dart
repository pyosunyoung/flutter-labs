import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:house_of_tomorrow/src/service/lang_service.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/src/view/shopping/shopping_view.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeService()),
        ChangeNotifierProvider(create: (context) => LangService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const ShoppingView(),
    );
  }
}
