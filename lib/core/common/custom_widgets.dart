import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class Custom {
  static AppBar appBar(
          {String title = "",
          VoidCallback? onTap,
          Color? titleColor,
          bool backButton = true,
          Widget? actions}) =>
      AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        // toolbarHeight: 70,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: false,
        leadingWidth: backButton ? 60 : 0,
        leading: backButton
            ? Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: CustomBgRoundedIcons(
                    icon: AppSvgIcons.backArrow,
                    onTap: () {
                      Get.back();
                      if (onTap != null) onTap();
                    }),
              )
            : SizedBox(),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Text(title,
                style: AppFontStyle.heading4
                    .copyWith(fontWeight: FontWeight.w500, color: titleColor)),
          ),
          actions ?? SizedBox(),
        ]),
      );

  static Widget svgIconData(String svg,
      {VoidCallback? ontap, double? size, Color? color, BoxFit? fit}) {
    return GestureDetector(
      onTap: ontap,
      child: SvgPicture.asset(
        svg,
        height: size,
        width: size,
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        fit: fit ?? (size == null ? BoxFit.scaleDown : BoxFit.contain),
      ),
    );
  }

  static Widget lottieAsset(String path, {double? size, bool? loop}) {
    return Lottie.asset(
      path,
      height: size,
      width: size,
      repeat: loop,
      fit: BoxFit.contain,
    );
  }

  static divider({double? padding}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 20),
        child: Divider(thickness: 1.5, color: AppColors.greyCardBorder),
      );

  static dottedDivider() {
    return Row(
      children: List.generate(
        1000 ~/ 10,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : AppColors.greyBorder,
            height: 1,
          ),
        ),
      ),
    );
  }

  static Widget loader({Color? loaderColor}) {
    return Center(
        child: CircularProgressIndicator(
      strokeWidth: 3,
      color: loaderColor ?? AppColors.primaryRed,
    ));
  }

  static Widget imgLoader({double size = 35}) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.primaryRed, size: size),
    );
    // return lottieAsset(Lotties.loader);
  }
}

class CustomBgRoundedIcons extends StatelessWidget {
  const CustomBgRoundedIcons({
    super.key,
    required this.icon,
    required this.onTap,
    this.bgColor,
    this.borderColor,
    this.padding = EdgeInsets.zero,
    this.iconColor,
    this.size,
    this.isGradient = false,
  });
  final VoidCallback? onTap;
  final String icon;
  final Color? bgColor, iconColor, borderColor;
  final EdgeInsets padding;
  final double? size;
  final bool isGradient;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: size ?? 50,
        height: size ?? 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? AppColors.lightPink,
          gradient: isGradient ? buttonGradient : null,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 1)
              : null,
        ),
        alignment: Alignment.center,
        child: Custom.svgIconData(icon, color: iconColor),
      ),
    );
  }
}

class CustomNetWorkImage extends StatelessWidget {
  const CustomNetWorkImage({
    super.key,
    required this.image,
    this.placeholder,
    this.borderRadius = 10,
    this.placeholderFit,
  });

  final String image;
  final String? placeholder;
  final double borderRadius;
  final BoxFit? placeholderFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: CustomText.imgEndPoint + image,
      errorListener: (value) {},
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
      ),
      placeholder: (context, url) => Custom.imgLoader(),
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: AppColors.lightPink,
              image: DecorationImage(
                image: AssetImage(placeholder ?? AppImage.placeholderImg),
                fit: placeholderFit ?? BoxFit.cover,
              )),
        );
      },
    );
  }
}

class CustomEmptyScreen extends StatelessWidget {
  const CustomEmptyScreen({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    this.iconSize = 80,
    this.child,
  });
  final String title, icon;
  final double iconSize;
  final String? subTitle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Custom.svgIconData(icon, size: iconSize),
          vSpace(10),
          Text(
            "${title}",
            textAlign: TextAlign.center,
            style: AppFontStyle.heading3.copyWith(fontWeight: FontWeight.w500),
          ),
          if (subTitle != null) ...[
            vSpace(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                subTitle!,
                textAlign: TextAlign.center,
                style: AppFontStyle.greyRegular14pt,
              ),
            ),
          ],
          if (child != null) ...[vSpace(10), child!]
        ],
      ),
    );
  }
}
