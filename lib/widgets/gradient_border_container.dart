import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';

class GradientBorderContainer extends StatelessWidget {
  const GradientBorderContainer(
      {super.key,
      this.height,
      this.width,
      this.borderWidth,
      this.boxShape,
      this.borderRadius,
      this.padding,
      this.color,
      required this.child,
      this.gradientColor});
  final double? height;
  final double? width;
  final double? borderWidth;
  final double? borderRadius;
  final BoxShape? boxShape;
  final Color? color;
  final Widget child;
  final EdgeInsets? padding;
  final LinearGradient? gradientColor;
  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(borderWidth ?? 10),
        decoration: BoxDecoration(
            borderRadius: boxShape == BoxShape.circle
                ? null
                : BorderRadius.circular(borderRadius ?? 00.00),
            gradient: gradientColor ?? boxGradient,
            shape: boxShape ?? BoxShape.rectangle),
        child: Container(
          padding: padding ?? EdgeInsets.all(00),
          decoration: BoxDecoration(
              borderRadius: boxShape == BoxShape.circle
                  ? null
                  : BorderRadius.circular(borderRadius ?? 00),
              shape: boxShape ?? BoxShape.rectangle,
              color: color ?? AppColors.white),
          child: boxShape == BoxShape.circle ? ClipOval(child: child) : child,
        ),
      );
}
