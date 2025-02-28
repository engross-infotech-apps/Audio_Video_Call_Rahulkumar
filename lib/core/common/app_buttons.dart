import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import '../theme/app_style.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String textValue;
  final Color? buttonColor, textColor, overlayColor;
  final VoidCallback? callback;
  final double? height, textSize;

  const CustomPrimaryButton({
    super.key,
    required this.textValue,
    this.buttonColor,
    this.overlayColor,
    this.textColor,
    this.callback,
    this.height = 50,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25.0),
      elevation: 0,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: buttonColor,
            gradient: buttonColor == null ? buttonGradient : null,
            borderRadius: BorderRadius.circular(100.0)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: callback,
            overlayColor: MaterialStateColor.resolveWith(
                (states) => overlayColor ?? Colors.transparent),
            highlightColor: MaterialStateColor.resolveWith(
                (states) => overlayColor ?? Colors.transparent),
            splashColor: MaterialStateColor.resolveWith(
                (states) => overlayColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(25.0),
            child: Center(
              child: Text(
                textValue,
                style: AppFontStyle.buttonText
                    .copyWith(color: textColor, fontSize: textSize),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconWithButton extends StatelessWidget {
  final String textValue;
  final String icon;
  final Color? buttonColor, textColor;
  final VoidCallback? callback;
  final double? height, textSize;

  const IconWithButton({
    super.key,
    required this.textValue,
    required this.icon,
    this.buttonColor,
    this.textColor,
    this.callback,
    this.height = 50,
    this.textSize = 14,
  });

// var data = MaskTextInputFormatter( mask: '+### ###-##-##');

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(25.0),
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: height,
        decoration: BoxDecoration(
            color: buttonColor ?? AppColors.lightPink,
            borderRadius: BorderRadius.circular(100.0)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: callback,
            borderRadius: BorderRadius.circular(25.0),
            child: Row(children: [
              Custom.svgIconData(icon),
              hSpace(10),
              Expanded(
                child: Text(
                  textValue,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: AppFontStyle.blackRegular16pt
                      .copyWith(color: textColor, fontWeight: FontWeight.w500),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// iconButton(String icon, String textValue, VoidCallback callback) {

class CustomPrimaryButtonWithIcon extends StatelessWidget {
  final String textValue;
  final String icon;
  final Color? buttonColor, textColor, iconColor;
  final VoidCallback? callback;
  final double? height, textSize, iconSize;

  const CustomPrimaryButtonWithIcon({
    super.key,
    required this.textValue,
    required this.icon,
    this.buttonColor,
    this.textColor,
    this.iconColor,
    this.callback,
    this.height = 50,
    this.textSize = 14,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: height,
      decoration: BoxDecoration(
        gradient: buttonGradient,
        borderRadius: BorderRadius.circular(100.0),
        // color: Colors.transparent,
      ),
      child: InkWell(
        onTap: callback,
        borderRadius: BorderRadius.circular(25.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Custom.svgIconData(icon, color: iconColor, size: iconSize),
          hSpace(10),
          Text(
            textValue,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppFontStyle.blackRegular16pt.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: textSize),
          ),
        ]),
      ),
    );
  }
}

class ChatButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String textValue;
  final Color? btnColor, textColor;

  const ChatButton({
    super.key,
    required this.textValue,
    required this.onTap,
    this.btnColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 7, 13, 2),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5.5),
          decoration: BoxDecoration(
              color: btnColor ?? AppColors.primaryRed,
              borderRadius: BorderRadius.circular(50)),
          child: Text(
            textValue,
            style: AppFontStyle.greyRegular16pt.copyWith(
              color: textColor ?? AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CardIconButton extends StatelessWidget {
  final String? icon, text;
  final VoidCallback? onTap;
  final Color? iconColor, bgColor;
  final bool useMargin;

  const CardIconButton({
    this.icon,
    this.text,
    this.onTap,
    this.iconColor,
    this.bgColor,
    this.useMargin = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[
          Container(
            height: 35,
            margin:
                useMargin ? const EdgeInsets.symmetric(horizontal: 15) : null,
            width: 35,
            padding: const EdgeInsets.symmetric(vertical: 7),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
              gradient: bgColor == null ? buttonGradient : null,
              // borderRadius: BorderRadius.circular(100),
            ),
            child: Custom.svgIconData(icon!, color: Colors.white, size: 20),
          ),
          vSpace(5),
        ],
        if (text != null) ...[
          Text(
            text!,
            style: AppFontStyle.blackRegular14pt.copyWith(
                color: AppColors.primaryRed, fontWeight: FontWeight.w600),
          ),
        ],
      ]),
    );
  }
}
