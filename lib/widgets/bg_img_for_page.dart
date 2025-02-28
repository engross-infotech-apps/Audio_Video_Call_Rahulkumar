import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';

class BgImageWIthOpacity extends StatefulWidget {
  const BgImageWIthOpacity({super.key});

  @override
  State<BgImageWIthOpacity> createState() => _BgImageWIthOpacityState();
}

class _BgImageWIthOpacityState extends State<BgImageWIthOpacity> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.10,
      child: Container(
        width: 200.w,
        height: 300.h,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImage.backgroundImg,
            ),
          ),
        ),
      ),
    );
  }
}
