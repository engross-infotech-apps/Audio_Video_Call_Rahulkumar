import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';

class MediaButton extends StatelessWidget {
  final Color? borderColor;
  final String textValue;
  final String? imagePath;
  final Color? textColor, iconColor;
  final VoidCallback? callback;
  final double? height;
  final double? textSize;

  const MediaButton({
    super.key,
    this.borderColor,
    required this.textValue,
    this.imagePath,
    this.textColor,
    this.callback,
    this.iconColor,
    this.height = 52,
    this.textSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(25.0),
      elevation: 0,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: AppColors.darkWhite,
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(color: borderColor ?? AppColors.darkWhite)),
        child: InkWell(
          onTap: callback,
          borderRadius: BorderRadius.circular(25.0),
          child: Stack(children: [
            Center(
              child: Text(
                textValue,
                style: AppFontStyle.blackRegular16pt
                    .copyWith(fontSize: textSize, color: textColor),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: imagePath != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 0),
                      child: Custom.svgIconData(imagePath!, size: 30),
                    )
                  : SizedBox(),
            ),
          ]),
        ),
      ),
    );
  }
}
