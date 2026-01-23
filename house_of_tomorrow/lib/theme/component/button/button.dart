import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/assert_icon.dart';

part 'button_size.dart';
part 'button_type.dart';

class Button extends StatefulWidget {
  // 버튼은 클릭 여부에 대한 상태를 가지고 있어 statefulWidget으로 변경
  const Button({
    super.key,
    required this.onPressed,
    ButtonType? type,
    ButtonSize? size,
    bool? isInactive,
    this.text,
    this.icon,
    this.width,
    this.color,
    this.backgroundColor,
    this.borderColor,
  }) : type = type ?? ButtonType.fill,
       size = size ?? ButtonSize.medium,
       isInactive = isInactive ?? false;

  ///클릭 이벤트
  final void Function() onPressed;

  ///Button 타입 and 크기
  final ButtonType type;
  final ButtonSize size;

  ///비활성화 여부
  final bool isInactive;

  ///텍스트 and 아이콘
  final String? text;
  final String? icon;

  ///폭
  final double? width;

  ///커스텀 색상
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  ///버튼이 눌려있는지 여부
  bool isPressed = false;

  /// 비활성화 여부
  bool get isInactive =>
      isPressed || widget.isInactive; //버튼이 클릭되어있는 경우, 비활성화 여부 true인 경우

  /// Text and Icon color
  Color get color => widget.type.getColor(context, isInactive, widget.color);

  /// Background Color
  Color get backgroundColor => widget.type.getBackgroundColor(
    context,
    isInactive,
    widget.backgroundColor,
  );

  /// Border
  Border? get border =>
      widget.type.getBorder(context, isInactive, widget.borderColor);

  ///버튼 클릭 이벤트
  void onPresseed(bool newIsPressed) {
    if (isPressed == newIsPressed) return;
    setState(() {
      isPressed = newIsPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        onPresseed(false);
        if (!widget.isInactive) widget.onPressed();
      },
      onTapDown: (details) {
        onPresseed(true);
      },
      onTapCancel: () => onPresseed(false), //영역을 벗어나면 false로
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100), // 애니메이션 컨테이너 넣을 시 필수값, 시간
        width: widget.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: border,
        ),
        padding: EdgeInsets.all(widget.size.padding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Icon
            if (widget.icon != null)
              AssetIcon(widget.icon!, color: color), //null이 아닌 경우에만 .
            ///Gap
            if (widget.icon != null && widget.text != null)
              const SizedBox(width: 8),

            ///Text
            if (widget.text != null)
              Text(
                widget.text!,
                style: widget.size
                    .getTextStyle(context)
                    .copyWith(color: color, fontWeight: context.typo.semiBold),
              ),
          ],
        ),
      ),
    );
  }
}
