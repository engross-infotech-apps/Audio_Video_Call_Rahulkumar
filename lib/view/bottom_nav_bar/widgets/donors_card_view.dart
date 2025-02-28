// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/model/donor_profile_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/widgets/common_widgets.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/controller/donor_controller.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DonorCardView extends StatefulWidget {
  final DonorProfileDetail donor;

  const DonorCardView(this.donor, {super.key});

  @override
  State<DonorCardView> createState() => _DonorCardViewState();
}

class _DonorCardViewState extends State<DonorCardView> {
  final CarouselSliderController _controller = CarouselSliderController();
  final cntrl = Get.find<DonorsListController>(tag: "exploreDonor");

  var current = 0.obs;
  var likeLoader = false.obs;

  @override
  void dispose() {
    super.dispose();
  }

  changeLikeCount() {
    if (widget.donor.isLiked!) {
      widget.donor.likeCount = (widget.donor.likeCount ?? 0) + 1;
    } else {
      widget.donor.likeCount = (widget.donor.likeCount ?? 1) - 1;
    }
  }

  Widget sliderImage() {
    return Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          CarouselSlider(
            items: widget.donor.userImage!.map((item) {
              return Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: CachedNetworkImage(
                  imageUrl: CustomText.imgEndPoint + item,
                  errorListener: (value) {},
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                  placeholder: (context, url) => Container(
                      alignment: Alignment.center, child: Custom.loader()),
                  errorWidget: (context, url, error) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: AppColors.lightPink,
                          image: DecorationImage(
                            image: AssetImage(AppImage.placeholderImg),
                            fit: BoxFit.cover,
                          )),
                    );
                  },
                ),
              );
            }).toList(),
            disableGesture: true,
            carouselController: _controller,
            options: CarouselOptions(
                enableInfiniteScroll: widget.donor.userImage!.length > 1,
                autoPlay: widget.donor.userImage!.length > 1,
                enlargeCenterPage: false,
                aspectRatio: 1,
                enlargeFactor: 0,
                viewportFraction: 1,
                height: double.maxFinite,
                onPageChanged: (index, reason) {
                  setState(() {
                    current.value = index;
                  });
                }),
          ),
          widget.donor.userImage!.length > 1
              ? Positioned(
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.donor.userImage!.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(
                              widget.donor.userImage!.indexOf(entry)),
                          child: Container(
                            width: 15.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: current.value ==
                                      widget.donor.userImage!.indexOf(entry)
                                  ? Colors.white
                                  : Colors.white.withOpacity(current.value ==
                                          widget.donor.userImage!.indexOf(entry)
                                      ? 1
                                      : 0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : SizedBox(),
        ]);
  }

  Widget nameProfile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              AutoSizeText(
                  widget.donor.displayName != null &&
                          widget.donor.displayName!.isNotEmpty
                      ? widget.donor.displayName!
                      : widget.donor.fullName ?? "",
                  style: AppFontStyle.heading5),
              hSpace(5),
              widget.donor.isVerified ?? false
                  ? Custom.svgIconData(AppSvgIcons.verify, size: 18)
                  : SizedBox(),
            ]),
            vSpace(5),
            Text(
              // maxLines: 1,
              "${widget.donor.professionName != null && widget.donor.professionName!.isNotEmpty ? "${widget.donor.professionName} • " : ""}${widget.donor.city} ${widget.donor.state != null && widget.donor.state!.isNotEmpty ? " • ${widget.donor.state}" : ""}",
              style: AppFontStyle.greyRegular14pt
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ]),
        ),
        profileImg(),
      ]),
    );
  }

  Widget profileImg() {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        margin: EdgeInsets.only(bottom: 8),
        width: 60,
        height: 60,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              startAngle: 90,
              endAngle: 450,
              axisLineStyle: AxisLineStyle(thickness: 10),
              showTicks: false,
              showLabels: false,
              showFirstLabel: false,
              pointers: <GaugePointer>[
                RangePointer(
                  value: (widget.donor.profileCompletionPercentage ?? 0)
                      .toDouble(),
                  width: 5,
                  gradient: SweepGradient(colors: [
                    AppColors.primaryRed,
                    AppColors.primaryDarkYellow,
                    AppColors.primaryDarkYellow,
                    AppColors.primaryRed,
                  ]),
                  cornerStyle: CornerStyle.bothCurve,
                  enableAnimation: true,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  axisValue: 50,
                  positionFactor: 0.17,
                  widget: Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.lightPink),
                      child: Text(
                        "${widget.donor.profileCompletionPercentage ?? 0}%"
                            .toUpperCase(),
                        style: AppFontStyle.blackRegular14pt
                            .copyWith(fontWeight: FontWeight.w600),
                      ) //imgView(),
                      /* */
                      ),
                ),
              ])
        ]),
      ),
      // Positioned(
      //   bottom: 5,
      //   child: Container(
      //     padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(50),
      //       gradient: gradient,
      //     ),
      //     child: Text(
      //       "${widget.donor.profileCompletionPercentage ?? 0}%".toUpperCase(),
      //       style: AppFontStyle.greyRegular10pt
      //           .copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
      //     ),
      //   ),
      // )
    ]);
  }

  Widget imgView() {
    return GestureDetector(
      onTap: () {
        // Get.to(ExploreDonorDetailsPage(id: widget.donor.userId!));
      },
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl:
                CustomText.imgEndPoint + (widget.donor.profilePicture ?? ""),
            errorListener: (value) {},
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            placeholder: (context, url) => Container(
                height: 10,
                width: 10,
                alignment: Alignment.center,
                child: Custom.loader()),
            errorWidget: (context, url, error) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.donor.userId != null) {
          // Get.to(ExploreDonorDetailsPage(id: widget.donor.userId!))
          //     ?.then((value) async {
          //   if ((value["isBookmark"] ?? false) ||
          //       (value["isLiked"] ?? false) ||
          //       (value["isDislike"] ?? false)) {
          //     // widget.donor.isBookmark = value["isBookmark"];
          //     // widget.donor.isLiked = value["isLiked"];
          //     // widget.donor.isDisLiked = value["isDisLiked"];
          //     await cntrl.successAction();
          //     changeLikeCount();
          //   }
          //   setState(() {});
          // });
        }
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          border: Border.all(color: AppColors.greyCardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          widget.donor.userImage!.isNotEmpty
              ? Expanded(child: sliderImage())
              : Expanded(
                  child: Container(
                    // height: AppScreenSize.height / 2.4,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: AppColors.lightPink,
                      image: DecorationImage(
                        image: AssetImage(AppImage.placeholderImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
          vSpace(5),
          nameProfile(),
          vSpace(5),
          CommonWidgets(
            detail: widget.donor,
            likeView: Obx(
              () => GestureDetector(
                // onTap: () async {
                //   if (!likeLoader.value) {
                //     await likeDislikeDonor();
                //     await changeLikeCount();
                //     setState(() {});
                //   }
                // },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: widget.donor.isLiked ?? false
                          ? AppColors.lightPink
                          : AppColors.greyBG,
                      border: Border.all(
                          color: widget.donor.isLiked ?? false
                              ? AppColors.lightPink2
                              : AppColors.greyBorder)),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        likeLoader.value
                            ? Container(
                                height: 15, width: 15, child: Custom.loader())
                            : Custom.svgIconData(
                                widget.donor.isLiked ?? false
                                    ? AppSvgIcons.heartFill
                                    : AppSvgIcons.heartBorder,
                                size: 15,
                                color: widget.donor.isLiked ?? false
                                    ? AppColors.primaryRed
                                    : Colors.black),
                        if (widget.donor.likeCount != null &&
                            (widget.donor.likeCount ?? 0) > 0) ...[
                          hSpace(7),
                          Text(
                              widget.donor.likeCount != null &&
                                      ((widget.donor.likeCount ?? 0) > 0)
                                  ? ("${widget.donor.likeCount ?? ""}")
                                  : "",
                              style: AppFontStyle.heading6),
                        ]
                      ]),
                ),
              ),
            ),
          ).listView(),
          vSpace(10),
          if ((widget.donor.ratingCount ?? 0) > 0) ...[
            CommonWidgets(
              detail: widget.donor,
            ).likesAndRatingListView(),
            vSpace(10)
          ],
          if (widget.donor.aboutMe != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AutoSizeText(
                widget.donor.aboutMe.toString(),
                style: AppFontStyle.greyRegular14pt,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            vSpace(10),
          ],
          // Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CardIconButton(
                icon: widget.donor.isLiked ?? false
                    ? AppSvgIcons.likeFilled
                    : AppSvgIcons.likeOutline,
                text: "Like",
                onTap: () async {
                  // if (!likeLoader.value) {
                  //   await cntrl.actionDonor(
                  //       widget.donor.userId, UserActions.like);
                  //   await changeLikeCount();
                  // }
                },
              ),
              CardIconButton(
                  icon: widget.donor.isBookmark ?? false
                      ? AppSvgIcons.mayBeFilled
                      : AppSvgIcons.mayBeOutline,
                  text: "Maybe",
                  onTap: () async {
                    // await cntrl.actionDonor(
                    //     widget.donor.userId, UserActions.maybe);
                    setState(() {});
                  }),
              CardIconButton(
                  icon: AppSvgIcons.disLikeOutline,
                  text: "Dislike",
                  onTap: () async {
                    // await cntrl.actionDonor(
                    //     widget.donor.userId, UserActions.dislike);
                    // setState(() {});
                  }),
              CardIconButton(
                  icon: AppSvgIcons.chatBorder,
                  text: "Chat",
                  onTap: () async {
                    // await chatOnPressed(
                    //     widget.donor.userId.toString(), context);
                  }),
              // Expanded(
              //     child: CustomPrimaryButtonWithIcon(
              //   icon: widget.donor.isBookmark ?? false
              //       ? AppSvgIcons.bookmarkFill
              //       : AppSvgIcons.bookmarkBorder,
              //   textValue: "Bookmark",
              //   iconSize: 17,
              //   iconColor: AppColors.white,
              //   callback: () => addDeleteBookMar(),
              // )),
              // hSpace(10),
              // Expanded(
              //     child: CustomPrimaryButtonWithIcon(
              //   icon: AppSvgIcons.chatBorder,
              //   iconSize: 17,
              //   textValue: "Chat",
              //   iconColor: AppColors.white,
              //   callback: () async {
              //     await chatOnPressed(widget.donor.userId.toString(), context);
              //   },
              // )),
            ]),
          ),
          vSpace(20),
        ]),
      ),
    );
  }
}
