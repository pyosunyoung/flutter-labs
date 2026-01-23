part of 'button.dart';

///버튼 타입
enum ButtonType {
  fill,
  flat,
  outline;

  ///텍스트 아이콘 색상
  Color getColor(BuildContext context, bool isInactive, [Color? color]) {
    //위에 이렇게 작성하면 context, isInactvie는 필수로 전달 대괄호(선택적 위치 매개변수)는 선택으로 설정 가능. 중괄호 안에는 이름 지정 매개변수
    switch (this) {
      case ButtonType.fill:
        return isInactive //Inactive 선택 혹은 클릭 되어진 상태?
            ? context.color.onInactiveContainer
            : color ?? context.color.onPrimary;
      case ButtonType.flat:
      case ButtonType.outline:
        return isInactive
            ? context.color.inactive
            : color ?? context.color.primary;
    }
  }

  /// 배경 색상
  Color getBackgroundColor(
    BuildContext context,
    bool isInactive, [
    Color? color,
  ]) {
    switch (this) {
      case ButtonType.fill:
        return isInactive
            ? context.color.inactiveContainer
            : color ?? context.color.primary;
      case ButtonType.flat:
      case ButtonType.outline:
        return color ?? Colors.transparent; //투명색?
    }
  }

   /// 테두리
  Border? getBorder(
    BuildContext context,
    bool isInactive, [
    Color? color,
  ]) {
    switch (this) {
      case ButtonType.fill:
      case ButtonType.flat:
        return null;
      case ButtonType.outline:
        return Border.all( //all 상하좌우 전반
          color: getColor(context, isInactive, color),
        );
    }
  }
}
