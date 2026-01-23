part of 'button.dart';

//개수 한정 열거형 데이터

enum ButtonSize {
  small,
  medium,
  large;

  double get padding {
    switch (this) {
      // this는 ButtonSize의 인스턴스를 가리킴
      case ButtonSize.small:
        return 8;
      case ButtonSize.medium:
        return 12;
      case ButtonSize.large:
        return 16;
    }
  }

  TextStyle getTextStyle(BuildContext context) {
    // theme service에 접근하려면 BuildContext를 통해 접가능
    switch (this) {
      case ButtonSize.small:
        return context.typo.subtitle2;
      case ButtonSize.medium:
        return context.typo.subtitle1;
      case ButtonSize.large:
        return context.typo.headline6;
    }
  }
}
