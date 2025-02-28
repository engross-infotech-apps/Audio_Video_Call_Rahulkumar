import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/filter_screen/view/filter_page.dart';

class FilterInitialScreen extends StatelessWidget {
  const FilterInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(maxHeight: AppScreenSize.height / 1.3),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Custom.svgIconData(AppSvgIcons.filterEmpty),
              vSpace(20),
              Text("No matching donors!",
                  style: AppFontStyle.heading3
                      .copyWith(fontWeight: FontWeight.w500)),
              vSpace(10),
              AutoSizeText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  "Your search criteria didn't match any donors.\nTry adjusting preference for better results.",
                  style: AppFontStyle.greyBlueRegular16pt
                      .copyWith(fontWeight: FontWeight.w500)),
              TextButton(
                onPressed: () => showLookupBottomSheet(child: FilterPage()),
                child: Text(
                  "Explore more",
                  style: AppFontStyle.greyBlueRegular16pt
                      .copyWith(color: AppColors.primaryRed),
                ),
              ),
            ]),
      ),
    );
  }
}
