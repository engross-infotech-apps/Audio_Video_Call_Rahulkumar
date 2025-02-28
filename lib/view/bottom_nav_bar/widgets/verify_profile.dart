import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';

class VerifyProfileView extends StatelessWidget {
  final double marginHorizontal;
  final VoidCallback callback;
  final bool other;

  const VerifyProfileView({
    super.key,
    required this.callback,
    required this.marginHorizontal,
    this.other = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: other ? null : boxGradient,
            border: other ? Border.all(color: AppColors.greyCardBorder) : null),
        child: Row(children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              vSpace(5),
              AutoSizeText("Verify your profile!",
                  maxLines: 1,
                  style: AppFontStyle.heading4.copyWith(
                    color: other ? null : AppColors.white,
                  )),
              vSpace(7),
              Text(
                  // "Upload your government phot
                  //o ID so we can be sure it's really you and We'll give you a verified mark that adds credibility to your profile.",
                  "Upload your government ID",
                  style: AppFontStyle.greyRegular16pt
                      .copyWith(color: other ? null : AppColors.white)),
              /* TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                onPressed: callback,
                child: Text("Upload documents",
                    style: AppFontStyle.greyBlueRegular16pt.copyWith(
                        color: other ? null : AppColors.white,
                        fontWeight: FontWeight.w700)),
              ),*/
            ]),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: Custom.svgIconData(other
                ? AppSvgIcons.docVerificationRed
                : AppSvgIcons.docVerificationWhite),
          ),
        ]),
      ),
    );
  }
}
