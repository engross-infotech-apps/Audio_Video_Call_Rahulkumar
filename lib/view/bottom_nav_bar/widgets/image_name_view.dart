import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';

class ImageWithNameView extends StatelessWidget {
  const ImageWithNameView({super.key, required this.image, required this.name});

  final String image, name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: EdgeInsets.all(5),
      child: Column(children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: CustomText.imgEndPoint + image,
              errorListener: (value) {},
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ),
              placeholder: (context, url) => Container(
                  // height: 10,
                  // width: 10,
                  alignment: Alignment.center,
                  child: Custom.loader()),
              errorWidget: (context, url, error) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightPink,
                    image: DecorationImage(
                      image: AssetImage(AppImage.emptyProfile),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        vSpace(7),
        Container(
          constraints: const BoxConstraints(maxWidth: 70),
          alignment: Alignment.center,
          child: Text(
            name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: AppFontStyle.blackRegular14pt,
          ),
        )
      ]),
    );
  }
}
