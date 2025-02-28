import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';

class ConnectedSCreen extends StatelessWidget {
  const ConnectedSCreen({super.key, required this.retry});
  final Function() retry;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: AppColors.white,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Custom.lottieAsset(Lotties.noInternetLottie,
                    size: 150, loop: true),
                // vSpace(30),
                Text(
                  "No internet connection!",
                  style: AppFontStyle.heading4,
                  textAlign: TextAlign.center,
                ),
                vSpace(10),
                Text(
                  "Your internet connection is down. please fix it and then you can continue using GoKidu!",
                  style: AppFontStyle.greyRegular14pt,
                  textAlign: TextAlign.center,
                ),
                vSpace(30),
                CustomPrimaryButton(
                  textValue: "Retry",
                  textSize: 14,
                  callback: () async {
                    retry();
                  },
                )
              ]),
        ));
  }
}
