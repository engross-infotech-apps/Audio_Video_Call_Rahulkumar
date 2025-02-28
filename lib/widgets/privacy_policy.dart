import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyCard extends StatelessWidget {
  const PrivacyPolicyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://gokidu.com/privacypolicy');
    Future<void> _launchUrl() async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    return Container(
      child: Card(
        color: AppColors.greyBlue,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            titleAlignment: ListTileTitleAlignment.center,
            leading: Custom.svgIconData(AppSvgIcons.privacy),
            title: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                  // text: "Your ID will be handled according to our ",
                  style: AppFontStyle.greyRegular14pt,
                  children: <InlineSpan>[
                    const TextSpan(
                        text: "Your ID will be handled according to our "),
                    WidgetSpan(
                        child: GestureDetector(
                      onTap: () async => await _launchUrl(),
                      child: Text('Privacy Policy',
                          style: AppFontStyle.greyRegular14pt.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          )),
                    )),
                    TextSpan(
                      text: " and won't be shared with any other entities.",
                      style: AppFontStyle.greyRegular14pt,
                    ),
                  ]),
            )),
      ),
    );
  }
}
