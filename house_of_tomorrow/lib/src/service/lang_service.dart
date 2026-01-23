import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/util/helper/intl_helper.dart';
import 'package:house_of_tomorrow/util/lang/generated/l10n.dart';

class LangService with ChangeNotifier {
  LangService({Locale? locale})
    : locale = locale ?? IntlHelper.en; //locale이 들어갈 수도 있고 아니라면 기본값으로 en을 넣어줌

  /// 현재 언어
  Locale locale;

  /// 언어 변경
  void toggleLang() {
    //현재 한국어 -> 영어, 영어 -> 한국어
    locale = IntlHelper.isKo ? IntlHelper.en : IntlHelper.ko;
    S.load(locale);
    notifyListeners();
  }
}
