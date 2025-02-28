// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewView extends StatefulWidget {
  const ImagePreviewView({super.key, required this.imgList});

  final List<String> imgList;

  @override
  State<ImagePreviewView> createState() => _ImagePreviewViewState();
}

class _ImagePreviewViewState extends State<ImagePreviewView> {
  final CarouselSliderController _controller = CarouselSliderController();
  var current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SafeArea(
        child:
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: PhotoViewGestureDetectorScope(
              axis: Axis.horizontal,
              child: CarouselSlider(
                items: widget.imgList
                    .map((item) => Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: PhotoView(
                            backgroundDecoration:
                                BoxDecoration(color: Colors.transparent),
                            imageProvider: CachedNetworkImageProvider(
                                CustomText.imgEndPoint + item),
                            minScale: PhotoViewComputedScale.contained,
                            // maxScale: PhotoViewComputedScale.covered,
                            loadingBuilder: (context, url) =>
                                Custom.imgLoader(size: 50),
                            errorBuilder: (context, url, error) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.lightPink,
                                  image: DecorationImage(
                                    image: AssetImage(AppImage.placeholderImg),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          ),
                        ))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    enableInfiniteScroll: widget.imgList.length > 1,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    aspectRatio: 9 / 16,
                    enlargeFactor: 0.2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        current = index;
                      });
                    }),
              ),
            ),
          ),
          widget.imgList.length > 1
              ? Positioned(
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.imgList.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller
                              .animateToPage(widget.imgList.indexOf(entry)),
                          child: Container(
                            width: 15.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: current == widget.imgList.indexOf(entry)
                                    ? Colors.white
                                    : Colors.grey.withOpacity(
                                        current == widget.imgList.indexOf(entry)
                                            ? 1
                                            : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : SizedBox(),
          Positioned(
            right: 10,
            top: 10,
            child: Align(
              alignment: Alignment.centerRight,
              child: Custom.svgIconData(AppSvgIcons.cancel,
                  size: 50, color: AppColors.white, ontap: () => Get.back()),
            ),
          )
        ]),
      ),
    );
  }
}
