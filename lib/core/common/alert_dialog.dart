// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/media_button.dart';

class AlertMsgDialog extends StatelessWidget {
  const AlertMsgDialog({
    super.key,
    required this.title,
    required this.msg,
    this.image,
    this.primaryText,
    this.secondaryText,
    this.primaryBtnTap,
    this.secondaryBtnTap,
    this.primaryBtnColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.imgColor,
    this.textAlign = TextAlign.center,
  });

  final String title, msg;
  final String? primaryText, secondaryText, image;
  final VoidCallback? primaryBtnTap, secondaryBtnTap;
  final Color? primaryBtnColor, primaryTextColor, secondaryTextColor, imgColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image != null
                ? Custom.svgIconData(image!, size: 35, color: imgColor)
                : SizedBox(),
            SizedBox(height: image != null ? 20 : 0),
            if (title.isNotEmpty)
              Text(
                title,
                style: AppFontStyle.blackRegular16pt
                    .copyWith(fontWeight: FontWeight.w600),
              ),
          ]),
      content: msg.isNotEmpty
          ? Text(
              msg,
              style: AppFontStyle.greyRegular14pt,
              textAlign: textAlign,
            )
          : null,
      actions: [
        secondaryText != null
            ? MediaButton(
                textValue: secondaryText!,
                height: 40,
                textSize: 14,
                textColor: secondaryTextColor,
                callback: secondaryBtnTap,
                borderColor: AppColors.greyBorder,
              )
            : SizedBox(),
        SizedBox(height: secondaryText != null ? 10 : 0),
        primaryText != null
            ? CustomPrimaryButton(
                textValue: primaryText!,
                height: 40,
                textSize: 14,
                callback: primaryBtnTap,
                buttonColor: primaryBtnColor,
                textColor: primaryTextColor,
              )
            : SizedBox(),
        SizedBox(height: primaryText != null ? 10 : 0),
      ],
    );
  }
}

class ConfirmMsgDialog extends StatelessWidget {
  const ConfirmMsgDialog({
    super.key,
    required this.title,
    required this.msg,
    this.image,
    this.primaryText,
    this.secondaryText,
    this.primaryBtnTap,
    this.secondaryBtnTap,
    this.primaryBtnColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.secondaryBtnColor,
    this.imgColor,
    this.textAlign,
  });

  final String title, msg;
  final String? primaryText, secondaryText, image;
  final VoidCallback? primaryBtnTap, secondaryBtnTap;
  final Color? primaryBtnColor,
      primaryTextColor,
      secondaryTextColor,
      secondaryBtnColor,
      imgColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      titlePadding: EdgeInsets.only(top: 15, left: 20, right: 20),
      title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image != null
                ? Custom.svgIconData(image!, size: 35, color: imgColor)
                : SizedBox(),
            if (title.isNotEmpty) ...[
              SizedBox(height: image != null ? 20 : 0),
              Text(
                title,
                textAlign: textAlign ?? TextAlign.center,
                style: AppFontStyle.blackRegular16pt
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ]
          ]),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        msg.isNotEmpty
            ? Text(
                msg,
                style: AppFontStyle.greyRegular14pt,
                textAlign: textAlign ?? TextAlign.center,
              )
            : SizedBox(),
        vSpace(10),
        Container(
          width: double.maxFinite,
          child: Row(children: [
            secondaryText != null
                ? Expanded(
                    child: CustomPrimaryButton(
                    textValue: secondaryText!,
                    height: 40,
                    textSize: 14,
                    buttonColor: secondaryBtnColor ?? AppColors.lightPink,
                    callback: secondaryBtnTap,
                    textColor: secondaryTextColor ?? Colors.black,
                  ))
                : SizedBox(),
            SizedBox(width: primaryText != null ? 10 : 0),
            primaryText != null
                ? Expanded(
                    child: CustomPrimaryButton(
                    textValue: primaryText!,
                    height: 40,
                    textSize: 14,
                    callback: primaryBtnTap,
                    buttonColor: primaryBtnColor,
                    textColor: primaryTextColor,
                  ))
                : SizedBox(),
          ]),
        ),
        SizedBox(height: 10),
      ]),
    );
  }
}
