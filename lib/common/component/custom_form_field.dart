import 'package:flutter/material.dart';
import 'package:restaurant/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField(
      {    required this.onChanged,
        this.autofocus = false,
        this.obscureText = false,
        this.hintText,
        this.errorText,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      )
    ); //테두리가 있는 입력칸의 border(underlineinputborder도 있음)
    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      obscureText: obscureText, //비밀번호 입력칸
      autofocus: autofocus, //초기 자동 커서 설정
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20), //입력창 내의 패딩
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        fillColor: INPUT_BG_COLOR,
        filled: true, //false-배경색 없음, true-배경색 있음
        border: baseBorder, //모든 input 상태의 기본 스타일 세팅
          enabledBorder: baseBorder, //선택되었을 때?? border
        focusedBorder: baseBorder.copyWith( //와우
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR
          )
        )
      ),
    );
  }
}
