import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';
import 'package:house_of_tomorrow/theme/component/button/button.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  final String? hint;
  final TextEditingController? controller; // 외부에서 받는 텍스트 값
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final void Function()? onClear; //입력시 클리어
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  // 외부에서 받은 값에 바로 접근하려면 late 키워드를 써야함.
  late final TextEditingController controller =
      widget.controller ?? TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {}); //텍스트 입력시 Inputfiled 갱신되어지게 setState 설정.
        widget.onChanged?.call(value);
      },
      onSubmitted: widget.onSubmitted,
      style: context.typo.headline5,
      cursorColor: context.color.primary,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0, style: BorderStyle.none),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: context.color.hintContainer,
        hintText: widget.hint,
        hintStyle: context.typo.headline5.copyWith(
          fontWeight: context.typo.light,
          color: context.color.onHintContainer,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 11.5,
          horizontal: 16,
        ),
        suffixIcon: controller.text.isEmpty
            ? null
            : Button(
                icon: 'close',
                type: ButtonType.flat,
                onPressed: () {
                  setState(() {
                    //텍스트와 버튼이 삭제버튼 누를 시 사라짐
                    controller.clear();
                    widget.onClear?.call();
                  });
                },
              ),
      ),
    );
  }
}
