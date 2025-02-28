import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BoostProfileView extends StatelessWidget {
  final double marginHorizontal;
  final int profileCompletionPercentage;
  final VoidCallback callback;
  final bool other;

  const BoostProfileView({
    super.key,
    required this.marginHorizontal,
    required this.profileCompletionPercentage,
    required this.callback,
    this.other = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.30),
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
              AutoSizeText("Boost your profile",
                  maxLines: 1,
                  style: AppFontStyle.subHeading4.copyWith(
                      color: other ? null : AppColors.white,
                      fontWeight: FontWeight.w500)),
              vSpace(7),
              Text(
                  // "It's $profileCompletionPercentage% complete. Add more details for better connections.",
                  "Complete your profile to find better connections.",
                  style: AppFontStyle.greyRegular14pt
                      .copyWith(color: other ? null : AppColors.white)),
              GestureDetector(
                onTap: callback,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  color: Colors.transparent,
                  child: Text("Add details",
                      style: AppFontStyle.greyRegular14pt.copyWith(
                          color: other ? null : AppColors.white,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ]),
          ),
          SizedBox(
            width: 90,
            height: 90,
            child: SfRadialGauge(animationDuration: 50000, axes: <RadialAxis>[
              RadialAxis(
                  startAngle: 90,
                  endAngle: 450,
                  axisLineStyle: AxisLineStyle(thickness: 10),
                  showTicks: false,
                  showLabels: false,
                  showFirstLabel: false,
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: profileCompletionPercentage.toDouble(),
                      width: 10,
                      cornerStyle: CornerStyle.bothCurve,
                      enableAnimation: true,
                      color: other ? AppColors.primaryRed : Colors.white,
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      axisValue: 50,
                      positionFactor: 0.07,
                      widget: Container(
                        height: 90,
                        width: 90,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: callback,
                          child: Text('${profileCompletionPercentage}%',
                              textAlign: TextAlign.center,
                              style: AppFontStyle.heading3.copyWith(
                                  color: other
                                      ? AppColors.primaryRed
                                      : AppColors.white,
                                  fontSize: 20)),
                        ),
                      ),
                    ),
                  ]),
            ]),
          ),
        ]),
      ),
    );
  }
}
