import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MultipleImgMsg extends StatefulWidget {
  const MultipleImgMsg(
      {super.key,
      this.isLastMsg = false,
      required this.urlList,
      this.isSend = true});
  final List<String> urlList;
  final bool isSend, isLastMsg;
  @override
  State<MultipleImgMsg> createState() => MultipleImgMsgState();
}

class MultipleImgMsgState extends State<MultipleImgMsg> {
  // final CarouselController _controller = CarouselController();
  var current = 0;

  void initState() {
    super.initState();
  }

  imagePreview(indexPage) {
    return showDialog(
        context: context,
        builder: (context) {
          // return ChatImagePreviewView(list: widget.urlList);
          return Stack(
            alignment: Alignment.topLeft,
            children: [
              PhotoViewGallery.builder(
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.urlList[index]),
                    initialScale: PhotoViewComputedScale.contained,
                    tightMode: true,
                    minScale: PhotoViewComputedScale.contained,
                    heroAttributes: PhotoViewHeroAttributes(tag: index),
                  );
                },
                itemCount: widget.urlList.length,
                loadingBuilder: (context, event) => Container(
                  height: 10,
                  width: 10,
                  alignment: Alignment.center,
                  child: Custom.loader(),
                ),
                backgroundDecoration:
                    BoxDecoration(color: AppColors.black.withOpacity(0.5)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.darkWhite.withOpacity(0.5),
                        shape: BoxShape.circle),
                    child: Custom.svgIconData(
                      AppSvgIcons.backArrow,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  catchImage({String? url, BorderRadius? radius, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: CustomText.imgEndPoint + (url ?? ""),
      errorListener: (value) {},
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            borderRadius: radius,
            color: Colors.white,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
      ),
      placeholder: (context, url) => Custom.imgLoader(),
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: radius,
              color: AppColors.lightPink,
              image: DecorationImage(
                image: AssetImage("assets/icon-document.png"),
                fit: fit ?? BoxFit.scaleDown,
              )),
        );
      },
    );
  }

  twoImg(index) {
    return GestureDetector(
      onTap: () {
        imagePreview(index);
      },
      child: Container(
        height: (MediaQuery.of(context).size.width * 0.40),
        width: (MediaQuery.of(context).size.width * 0.50),
        decoration: BoxDecoration(
            borderRadius: index == 0
                ? BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    bottomLeft: Radius.circular(
                        widget.isSend || widget.isLastMsg ? 20 : 0))
                : BorderRadius.only(
                    topRight: const Radius.circular(20),
                    bottomRight: Radius.circular(
                        widget.isSend && !widget.isLastMsg ? 0 : 20))),
        child: catchImage(
          url: widget.urlList[index],
          radius: index == 0
              ? BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  bottomLeft: Radius.circular(
                      widget.isSend || widget.isLastMsg ? 20 : 0))
              : BorderRadius.only(
                  topRight: const Radius.circular(20),
                  bottomRight: Radius.circular(
                      widget.isSend && !widget.isLastMsg ? 0 : 20)),
        ),
      ),
    );
  }

  mThFour(index) {
    return GestureDetector(
      onTap: () {
        imagePreview(index);
      },
      child: Container(
          // height: (MediaQuery.of(context).size.width * 0.40),
          // width: index != 1
          //     ? (MediaQuery.of(context).size.width * 0.60)
          //     : (MediaQuery.of(context).size.width + 10),
          decoration: BoxDecoration(
              borderRadius: index != 0 && index != 2
                  ? BorderRadius.only(
                      topLeft: Radius.circular(index == 1 ? 20 : 20),
                      topRight: Radius.circular(index == 3 ? 20 : 0),
                    )
                  : index == 2
                      ? BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          bottomLeft: Radius.circular(widget.isSend ? 20 : 0))
                      : BorderRadius.only(
                          bottomRight: Radius.circular(widget.isSend ? 20 : 0),
                        )),
          child: Stack(children: [
            catchImage(
                url: widget.urlList[index],
                radius: index != 0 && index != 2
                    ? index == 1
                        ? const BorderRadius.only(
                            topRight: Radius.circular(20),
                          )
                        : BorderRadius.only(
                            bottomRight: Radius.circular(
                                widget.isSend && !widget.isLastMsg ? 0 : 20),
                          )
                    : index == 2
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(
                                widget.isSend || widget.isLastMsg ? 20 : 0))
                        : const BorderRadius.only(
                            topLeft: Radius.circular(20),
                          )),
            widget.urlList.length > 4 && index == 3
                ? Padding(
                    padding: const EdgeInsets.only(left: 1.5, top: 1.5),
                    child: Container(
                      // height: MediaQuery.of(context).size.width * 0.32,
                      // width: MediaQuery.of(context).size.width * 0.32,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                                widget.isSend && !widget.isLastMsg ? 0 : 20)),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "+${(widget.urlList.length - 3).toString()}",
                          style: AppFontStyle.heading3.copyWith(
                              color: AppColors.darkWhite,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ])),
    );
  }

  threeImg() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.width * 0.33,
                // width: MediaQuery.of(context).size.width * 0.322,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                  // image: DecorationImage(
                  //     image: NetworkImage(widget.urlList[0]))
                ),
                child: catchImage(
                    url: widget.urlList[0],
                    radius:
                        const BorderRadius.only(topLeft: Radius.circular(20))),
              ),
            ),
            SizedBox(width: 1.5),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  imagePreview(1);
                },
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.33,
                  // width: MediaQuery.of(context).size.width * 0.322,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(20)),
                  ),
                  child: catchImage(
                      url: widget.urlList[1],
                      radius: const BorderRadius.only(
                          topRight: Radius.circular(20))),
                ),
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            imagePreview(2);
          },
          child: Container(
            height: MediaQuery.of(context).size.width * 0.33,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              // color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      widget.isLastMsg || widget.isSend ? 20 : 0),
                  bottomRight: Radius.circular(
                      widget.isSend && !widget.isLastMsg ? 0 : 20)),
            ),
            child: catchImage(
                fit: BoxFit.cover,
                url: widget.urlList[2],
                radius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      widget.isLastMsg || widget.isSend ? 20 : 0),
                  bottomRight: Radius.circular(
                      widget.isSend && !widget.isLastMsg ? 0 : 20),
                )),
          ),
        ),
      ],
    );
  }

  gridViewBody() {
    return GridView.builder(
      cacheExtent: MediaQuery.of(context).size.width,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1.5,
        crossAxisSpacing: 1.5,
        childAspectRatio:
            ((MediaQuery.of(context).size.width - (10 + 20 + 20)) / 2) /
                (MediaQuery.of(context).size.width * 0.45),
      ),
      itemCount: widget.urlList.length < 4 ? widget.urlList.length : 4,
      itemBuilder: (context, index) {
        if (widget.urlList.length == 2) {
          return twoImg(index);
        } else if (widget.urlList.length > 3) {
          return mThFour(index);
        }
        return null;
      },
    );
  }

  singleImgView() {
    return Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width * 0.66,
          maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        borderRadius: widget.isLastMsg
            ? BorderRadius.circular(20)
            : widget.isSend
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
        image: DecorationImage(
          image: NetworkImage(CustomText.imgEndPoint + (widget.urlList[0])),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(3),
      height: widget.urlList.length >= 3
          ? MediaQuery.of(context).size.width * 0.68
          : (MediaQuery.of(context).size.width * 0.35),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.665,
      ),
      alignment: Alignment.center,
      // decoration: BoxDecoration(color: ),

      child: widget.urlList.length != 3 ? gridViewBody() : threeImg());
}
