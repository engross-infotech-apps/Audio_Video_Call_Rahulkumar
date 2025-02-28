import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';

class FeedBackCard extends StatefulWidget {
  const FeedBackCard({super.key, this.isOtherWidget = false});
  final bool isOtherWidget;

  @override
  State<FeedBackCard> createState() => _FeedBackCardState();
}

class _FeedBackCardState extends State<FeedBackCard> {
  var feedbackTextCtrl = TextEditingController();
  // var userData = AppStorage.getUserData();
  var error = Rxn<String>();
  var showLoader = Rxn<bool>();
  var resString = Rxn<String>();
  feedBackDialog() {
    error.value = null;
    feedbackTextCtrl.clear();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.70),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(20)),
      child: Obx(
        () => showLoader.value == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How do you feel about GoKidu?",
                    style: AppFontStyle.heading4,
                  ),
                  vSpace(10),
                  CustomTextField(
                    controller: feedbackTextCtrl,
                    hintText: "Feedback, praise, bugs - we're all ears!",
                    validator: null,
                    onChanged: (value) {
                      error.value = value.trim().isNotEmpty
                          ? null
                          : "Enter your feedback";
                    },
                    minLine: 5,
                    maxLine: 5,
                    maxLength: 1000,
                  ),
                  Obx(() => error.value != null
                      ? Text(
                          error.value!,
                          style: AppFontStyle.errorStyle,
                        )
                      : SizedBox()),
                  vSpace(10),
                  CustomPrimaryButton(
                    textValue: "Submit",
                    callback: () async {
                      if (feedbackTextCtrl.text.isNotEmpty) {
                        try {
                          error.value = null;
                          showLoader.value = true;

                          // var parameter = {
                          //   "Description": feedbackTextCtrl.text.trim(),
                          // };
                          Timer(
                            Duration(seconds: 2),
                            () {
                              showLoader.value = false;
                            },
                          );
                          showLoader.value = true;
                          // var res = await UserApi().submitFeedback(parameter);
                          // if (res != null) {
                          //   showLoader.value = false;
                          //   resString.value = res.message;
                          // } else {
                          //   showLoader.value = null;
                          // }
                        } catch (e) {
                          showLoader.value = null;
                        }
                      } else {
                        error.value = "Enter your feedback";
                        // Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              )
            : Container(
                width: double.maxFinite,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showLoader.value ?? true
                          ? Custom.loader()
                          : Custom.lottieAsset(Lotties.successLottie,
                              loop: false, size: 140),
                      if (!(showLoader.value ?? true)) ...[
                        Text(
                          "Thank you!",
                          style: AppFontStyle.heading2,
                        ),
                        vSpace(5),
                        Text(
                          resString.value ?? "Your feedback is submitted.",
                          textAlign: TextAlign.center,
                          style: AppFontStyle.heading5nHalf,
                        ),
                        vSpace(20),
                        CustomPrimaryButton(
                          textValue: CustomText.ok,
                          callback: () {
                            Navigator.of(context).pop();
                            showLoader.value = null;
                          },
                        )
                      ]
                    ]),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () async {
          await animatedDialog(
            child: feedBackDialog(),
          );
          showLoader.value = null;
        },
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: widget.isOtherWidget ? null : boxGradient,
              border: widget.isOtherWidget
                  ? Border.all(color: AppColors.greyCardBorder)
                  : null),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text("Share your feedback",
                        style: AppFontStyle.heading4.copyWith(
                            color:
                                widget.isOtherWidget ? null : AppColors.white)),
                    vSpace(7),
                    Text(
                      "Let us know about your experience with our app and services.",
                      style: AppFontStyle.greyRegular16pt.copyWith(
                          color: widget.isOtherWidget ? null : AppColors.white),
                    ),
                  ])),
              Padding(
                padding: EdgeInsets.zero,
                child: Custom.svgIconData(
                  widget.isOtherWidget
                      ? AppSvgIcons.feedbackGradient
                      : AppSvgIcons.feedbackWhite,
                ),
              )
            ],
          ),
        ),
      );
}
