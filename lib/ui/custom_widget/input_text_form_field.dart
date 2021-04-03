import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/constant/text_style.dart';
import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPasswordActive;
  final Function validation;
  final TextEditingController controller;
  final Function onChanged;
  final int maxLength;
  final int maxLine;
  InputTextFormField({
    this.hintText, this.isPasswordActive = false, this.validation, this.controller, this.onChanged, this.maxLength, this.maxLine = 1});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLine,
      controller: this.controller ?? TextEditingController(),
      validator: validation,
      obscureText: isPasswordActive,
      onChanged: onChanged,
      onSaved: onChanged,
      cursorColor: primaryColor,
      decoration: InputDecoration(
//                      labelText: "Name",
//      suffixIcon: isPasswordActive,
          hintText: "$hintText",
          hintStyle: subHeadingTextStyle.copyWith(fontSize: 15),
          filled: true,
          fillColor: backgroundColor,
          focusColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          disabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: primaryColor
            ),


          )
      ),
    );
  }
}
