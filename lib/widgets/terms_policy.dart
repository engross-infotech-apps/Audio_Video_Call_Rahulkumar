import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class TermsAndCondition extends StatelessWidget {
  TermsAndCondition(
      {Key? key,
      required this.text,
      required this.alignment,
      this.textSize = 14})
      : super(key: key);
  final String text;
  final TextAlign alignment;
  double? textSize;
  @override
  Widget build(BuildContext context) {
    // final Uri url = Uri.parse('https://gokidu.com/termcondition');
    Future<void> _launchUrl(url) async {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    return Text.rich(
      textAlign: alignment,
      TextSpan(
          text: "$text, I agree to GoKidu's ",
          style: AppFontStyle.greyRegular14pt.copyWith(fontSize: this.textSize),
          children: <InlineSpan>[
            WidgetSpan(
                child: GestureDetector(
              onTap: () async =>
                  await _launchUrl("https://gokidu.com/termcondition"),
              child: Text('Terms of service',
                  style: AppFontStyle.greyRegular14pt.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryRed,
                      fontSize: this.textSize)),
            )),
            WidgetSpan(
              child: Text(
                ' and ',
                style: AppFontStyle.greyRegular14pt
                    .copyWith(fontSize: this.textSize),
              ),
            ),
            WidgetSpan(
                child: GestureDetector(
              onTap: () async =>
                  await _launchUrl("https://gokidu.com/privacypolicy"),
              child: Text('Privacy Policy.',
                  style: AppFontStyle.greyRegular14pt.copyWith(
                      color: AppColors.primaryRed,
                      fontWeight: FontWeight.bold,
                      fontSize: this.textSize)),
            )),
          ]),
    );
  }
}
