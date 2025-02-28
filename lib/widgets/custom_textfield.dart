// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.title,
    this.inputType = TextInputType.text,
    this.obscure = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLine = 1,
    this.minLine,
    this.maxLength,
    this.borderRadius = 25,
    this.ontap,
    this.readOnly = false,
    this.autofocus = false,
    this.enabled,
    this.fillColor,
    this.onChanged,
    this.inputFormatters,
    this.counterText,
    this.onEditingComplete,
    this.focusNode,
    this.upValidator,
  });

  final TextEditingController controller;
  final String hintText;
  final String? title;
  final String? Function(String?)? validator;
  Function(String)? onChanged;
  int maxLine;
  int? minLine;
  int? maxLength;
  bool obscure;
  TextInputType inputType;
  Widget? suffixIcon;
  Widget? prefixIcon;
  VoidCallback? ontap, onEditingComplete;
  bool readOnly;
  bool autofocus;
  bool? enabled, counterText, upValidator;
  Color? fillColor;
  double borderRadius;
  FocusNode? focusNode;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        title != null
            ? Text(title!, style: AppFontStyle.greyRegular16pt)
            : SizedBox(),
        vSpace(title != null ? 10 : 0),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          style: TextStyle(color: AppColors.black),
          cursorColor: AppColors.black,
          validator: validator,
          textCapitalization: TextCapitalization.sentences,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTap: ontap,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          autofocus: autofocus,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          enabled: enabled,
          autocorrect: true,
          readOnly: readOnly,
          maxLength: maxLength,
          decoration: decoration(hintText, fillColor,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              borderRadius: borderRadius,
              counterText: counterText ?? false),
          maxLines: maxLine,
          minLines: minLine,
          obscureText: obscure,
        ),
      ]),
    );
  }
}

decoration(String hint, Color? fillColor,
    {Widget? suffixIcon,
    Widget? prefixIcon,
    double borderRadius = 100.0,
    bool counterText = false}) {
  return InputDecoration(
    hintText: hint,
    counterText: counterText ? null : "",
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    hintStyle: AppFontStyle.hintText,
    errorMaxLines: 6,
    suffixIcon: suffixIcon,
    filled: fillColor != null ? true : false,
    fillColor: fillColor,
    prefixIcon: prefixIcon,
    errorStyle: AppFontStyle.errorStyle,
    focusColor: AppColors.primaryRed,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: AppColors.greyBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: AppColors.greyBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: AppColors.greyBorder),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: AppColors.redError),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: AppColors.greyBorder),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: AppColors.redError),
    ),
  );
}
