import 'package:demo_agora/helpers/app_colors.dart';
import 'package:flutter/material.dart';

class AppFontStyle {
  static String headingFont = 'Nunito';
  static String regularFont = 'Nunito';
  static List<FontFeature> fontFeature = [
    FontFeature.stylisticSet(1),
    FontFeature.stylisticSet(2),
  ];

  static TextStyle heading1 = TextStyle(
    color: AppColors.black,
    fontSize: 32,
    fontFamily: headingFont,
    fontWeight: FontWeight.w400,
    fontFeatures: fontFeature,
    height: 0,
  );
  static TextStyle heading2 = TextStyle(
    color: AppColors.black,
    fontSize: 30,
    fontFamily: headingFont,
    fontFeatures: fontFeature,
    fontWeight: FontWeight.w500,
    height: 0,
  );
  static TextStyle heading3 = TextStyle(
    color: AppColors.black,
    fontFeatures: fontFeature,
    fontSize: 28,
    fontFamily: headingFont,
    fontWeight: FontWeight.w600,
    height: 0,
  );

  static TextStyle heading4 = TextStyle(
    color: AppColors.black,
    fontFeatures: fontFeature,
    fontSize: 22,
    fontFamily: headingFont,
    fontWeight: FontWeight.w600,
    height: 0,
  );

  static TextStyle subHeading4 = TextStyle(
    color: AppColors.black,
    fontFeatures: fontFeature,
    fontSize: 20,
    fontFamily: headingFont,
    fontWeight: FontWeight.w600,
    height: 0,
  );

  static TextStyle heading5 = TextStyle(
    fontFeatures: fontFeature,
    color: AppColors.black,
    fontSize: 20,
    fontFamily: headingFont,
    fontWeight: FontWeight.w600,
    height: 0,
  );

  static TextStyle heading5nHalf = TextStyle(
    fontFeatures: fontFeature,
    color: AppColors.black,
    fontSize: 18,
    fontFamily: headingFont,
    fontWeight: FontWeight.w600,
    height: 0,
  );

  static TextStyle heading6 = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    fontFeatures: fontFeature,
    fontFamily: headingFont,
    fontWeight: FontWeight.w600,
    height: 0,
  );

  static TextStyle greyBlueRegular16pt = TextStyle(
    fontFeatures: fontFeature,
    color: AppColors.greyBlueText,
    fontFamily: regularFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle whiteRegular16pt = TextStyle(
    color: AppColors.white,
    fontFamily: regularFont,
    fontFeatures: fontFeature,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle greyRegular16pt = TextStyle(
    fontFeatures: fontFeature,
    color: AppColors.greyText,
    fontFamily: regularFont,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle blackRegular16pt = TextStyle(
    color: Colors.black,
    fontFamily: regularFont,
    fontFeatures: fontFeature,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle blackRegular18pt = TextStyle(
    color: Colors.black,
    fontFamily: regularFont,
    fontFeatures: fontFeature,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle skipButtonText = TextStyle(
    color: AppColors.primaryRed,
    fontFamily: regularFont,
    fontFeatures: fontFeature,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle whiteRegular14pt = TextStyle(
    color: AppColors.white,
    fontFamily: regularFont,
    fontFeatures: fontFeature,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static TextStyle greyRegular14pt = TextStyle(
    color: AppColors.greyText,
    fontFamily: regularFont,
    fontFeatures: fontFeature,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static TextStyle blackRegular14pt = TextStyle(
    color: AppColors.black,
    fontFeatures: fontFeature,
    fontFamily: regularFont,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonText = TextStyle(
    color: Colors.white,
    fontFeatures: fontFeature,
    fontFamily: regularFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle hintText = TextStyle(
    fontSize: 16,
    color: AppColors.greyHintText,
    fontFeatures: fontFeature,
    fontWeight: FontWeight.w400,
  );

  static TextStyle greyRegular10pt = TextStyle(
    fontFeatures: fontFeature,
    color: AppColors.greyHintText,
    fontSize: 12,
    fontFamily: regularFont,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.80,
  );
  static TextStyle errorStyle =
      TextStyle(color: AppColors.redError, fontSize: 13);

  static TextStyle greyRegular12pt = TextStyle(
    fontFeatures: fontFeature,
    color: AppColors.greyHintText,
    fontSize: 12,
    fontFamily: regularFont,
    fontWeight: FontWeight.w600,
  );
  static TextStyle blackRegular12pt = TextStyle(
    color: AppColors.black,
    fontFeatures: fontFeature,
    fontFamily: regularFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static List<Shadow>? textShadow({double offset = 2}) => [
        Shadow(
          color: Colors.black,
          offset: Offset(offset, offset),
          blurRadius: 0.5,
        )
      ];
}
