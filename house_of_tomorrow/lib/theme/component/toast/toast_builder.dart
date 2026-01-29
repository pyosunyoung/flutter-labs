import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

class ToastBuilder extends StatefulWidget {
  const ToastBuilder({
    super.key,
    required this.text,
    required this.animDuration,
  });

  final String text;
  final Duration animDuration;

  @override
  State<ToastBuilder> createState() => ToastBuilderState();
}

//Dart에서 _로 시작하는 모든 변수, 함수, 클래스는 해당 파일 내에서만 접근 가능한 비공개 (Private) 변수, 함수, 클래스로 선언됩니다.
class ToastBuilderState extends State<ToastBuilder> {
  bool _isShow = false; //isShow를 통해 이 값이 변경되면 투명도를 0 -> 1로 변경하기 위함으로 사용

  bool get isShow =>
      _isShow; // isShow 전구 모양 encapsulate field하면 getter, setter 생성됨.

  set isShow(bool value) {
    setState(() {
      _isShow = value;
    });
  } //화면에 보이는지 안보이는지 여부

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; //화면의 크기를 가져와
    return Positioned(
      bottom: screenSize.height * 0.25,
      left: 0,
      right: 0,
      child: Center(
        // Center로 감싸줘서 가운데에 글짜가 표시되어지게 전엔 박스 화면 양쪽을 모두 차지한 상태로 출력됨.
        child: AnimatedOpacity(
          // AnimatedOpactiy로 감싸서 애니메이션 적용
          duration: widget.animDuration,
          opacity: isShow ? 1 : 0,
          child: Container(
            decoration: BoxDecoration(
              color: context.color.toastContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: DefaultTextStyle(
              style: context.typo.headline6.copyWith(
                color: context.color.onToastContainer,
              ),
              child: Text(widget.text),
            ),
          ),
        ),
      ),
    );
  }
}
