import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/function/app_function.dart';
import 'package:gokidu_app_tour/core/helper/app_intl_formatter.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/recipient_list/controller/recipient_list_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/recipient_list/model/recipient_profile_model.dart';
import 'package:gokidu_app_tour/widgets/gradient_border_container.dart';

// ignore: must_be_immutable
class ViewRecipientWidget extends StatefulWidget {
  ViewRecipientWidget({super.key, required this.recipientData});
  RecipientProfileDetails recipientData;
  @override
  State<ViewRecipientWidget> createState() => ViewRecipientWidgetState();
}

class ViewRecipientWidgetState extends State<ViewRecipientWidget> {
  var likeLoader = false.obs;

  final CarouselSliderController _controller = CarouselSliderController();
  final cntrl = Get.find<RecipientListController>(tag: "exploreRecipient");

  var current = 0.obs;
  var country = AppStorage.getUserData()?.countryId;

  String getUsername() {
    var name = "";
    if (widget.recipientData.displayName != null &&
        widget.recipientData.displayName!.isNotEmpty) {
      name = widget.recipientData.displayName ?? "";
    } else if (widget.recipientData.fullName != null &&
        widget.recipientData.fullName!.isNotEmpty) {
      name = widget.recipientData.fullName ?? "";
    }
    return name;
  }

  Widget nameProfile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(getUsername(), style: AppFontStyle.heading5),
              hSpace(5),
              widget.recipientData.isVerified ?? false
                  ? Custom.svgIconData(AppSvgIcons.verify, size: 18)
                  : SizedBox(),
            ]),
            Text(widget.recipientData.country ?? "N/A",
                style: AppFontStyle.greyRegular16pt)
          ]),
        ),
        profileImg(),
      ]),
    );
  }

  Widget listView() {
    return SizedBox(
      width: double.maxFinite,
      height: 30,
      child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            hSpace(20),
            Obx(
              () => GestureDetector(
                  // onTap: () async {
                  //   if (!likeLoader.value) {
                  //     await likeDislikeRecipient();
                  //   }
                  //   setState(() {});
                  // },
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: widget.recipientData.isLiked
                        ? AppColors.lightPink
                        : null,
                    border: Border.all(
                        color: widget.recipientData.isLiked
                            ? AppColors.lightPink2
                            : AppColors.greyBorder)),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      likeLoader.value
                          ? Container(
                              height: 20, width: 20, child: Custom.loader())
                          : Custom.svgIconData(
                              widget.recipientData.isLiked
                                  ? AppSvgIcons.heartFill
                                  : AppSvgIcons.heartBorder,
                              size: 15,
                              color: widget.recipientData.isLiked
                                  ? AppColors.primaryRed
                                  : Colors.black),
                      if (widget.recipientData.likesCount != null &&
                          ((widget.recipientData.likesCount ?? 0) > 0)) ...[
                        hSpace(7),
                        Text("${widget.recipientData.likesCount ?? ""}",
                            style: AppFontStyle.heading6),
                      ]
                    ]),
              )),
            ),
            hSpace(7),
            listCard("${widget.recipientData.age ?? "N/A"}",
                svg: AppSvgIcons.cake),
            hSpace(7),
            listCard(
              country != null && country == 2
                  ? "${mileToKM(widget.recipientData.distance?.toDouble() ?? 0.0)} km"
                  : "${widget.recipientData.distance?.ceil() ?? "0"} mi",
            ),
            hSpace(7),
            // listCard(getCityState(), svg: AppSvgIcons.location),
            // hSpace(20),
          ]),
    );
  }

  Widget likesAndRatingListView() {
    return SizedBox(
      width: double.maxFinite,
      height: 30,
      child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            hSpace(20),
            if (widget.recipientData.ratingCount != null &&
                (widget.recipientData.ratingCount ?? 0) != 0 &&
                (widget.recipientData.averageRating) != 0) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.greyBG,
                    border: Border.all(color: AppColors.greyBorder)),
                child: Row(children: [
                  SizedBox(
                    height: 15,
                    child: RatingBar.builder(
                      ignoreGestures: true,
                      updateOnDrag: false,
                      itemSize: 15,
                      itemPadding: EdgeInsets.only(right: 2),
                      minRating: 1,
                      initialRating:
                          widget.recipientData.averageRating.toDouble(),
                      itemCount: 5,
                      unratedColor: AppColors.greyBorder,
                      allowHalfRating: true,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => Custom.svgIconData(
                        AppSvgIcons.ratingStar,
                        color: ratingStarColor(
                            widget.recipientData.averageRating.toDouble()),
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                  ),
                  hSpace(5),
                  Text("(${widget.recipientData.ratingCount ?? "N/A"})",
                      style: AppFontStyle.heading6),
                ]),
              ),
            ],
            hSpace(20),
          ]),
    );
  }

  listCard(String text, {String? svg, Color? color, bgColor, borderColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: bgColor ?? AppColors.greyBG,
          border: Border.all(color: borderColor ?? AppColors.greyBorder)),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            svg == null
                ? SizedBox()
                : Custom.svgIconData(svg, size: 15, color: color),
            hSpace(svg == null ? 0 : 7),
            Text(text, style: AppFontStyle.heading6),
          ]),
    );
  }

  Widget profileImg() {
    return GradientBorderContainer(
      boxShape: BoxShape.circle,
      borderWidth: 4,
      child: Container(
        width: 50,
        height: 50,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColors.lightPink),
        child: CustomNetWorkImage(
          image: widget.recipientData.profilePicture ?? "",
          placeholder: AppImage.emptyProfile,
          placeholderFit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget aboutUs() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AutoSizeText(
          widget.recipientData.aboutMe != null &&
                  widget.recipientData.aboutMe!.isNotEmpty
              ? widget.recipientData.aboutMe!
              : "N/A",
          style: AppFontStyle.greyRegular14pt,
          //.copyWith(height: MediaQuery.of(context).size.width * 0.003),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  /*likeDislikeRecipient() async {
    try {
      likeLoader.value = true;
      await UserApi().likeDislike(widget.recipientData.userId);
      widget.recipientData.isLiked = !widget.recipientData.isLiked;
      widget.recipientData.likesCount = widget.recipientData.isLiked
          ? (widget.recipientData.likesCount! + 1)
          : (widget.recipientData.likesCount! - 1);
      likeLoader.value = false;

      setState(() {});
    } catch (e) {
      debugPrint("----error---$e");
      // showAppToast(e);
    }
  }*/

  Widget sliderImage() {
    return Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          CarouselSlider(
            items: widget.recipientData.userImage!.map((item) {
              return Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: CachedNetworkImage(
                  imageUrl: (CustomText.imgEndPoint + item.trim()).trim(),
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
                enableInfiniteScroll:
                    widget.recipientData.userImage!.length > 1,
                autoPlay: widget.recipientData.userImage!.length > 1,
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
          widget.recipientData.userImage!.length > 1
              ? Positioned(
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.recipientData.userImage!.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(
                              widget.recipientData.userImage!.indexOf(entry)),
                          child: Container(
                            width: 15.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: current.value ==
                                      widget.recipientData.userImage!
                                          .indexOf(entry)
                                  ? Colors.white
                                  : Colors.white.withOpacity(current.value ==
                                          widget.recipientData.userImage!
                                              .indexOf(entry)
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

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          // Get.to(ViewRecipient(recipientId: widget.recipientData.userId!))
          //     ?.then((value) async {
          //   if ((value["isBookmark"] ?? false) ||
          //       (value["isLiked"] ?? false) ||
          //       (value["isDislike"] ?? false)) {
          //     await cntrl.successAction();
          //   }
          //   setState(() {});
          // });
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
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.recipientData.userImage!.isNotEmpty
                  ? Expanded(
                      child: sliderImage(),
                    )
                  : Expanded(
                      child: Container(
                        // height: AppScreenSize.height / 2.4,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: AppColors.lightPink,
                        ),
                        child: CustomNetWorkImage(
                          image: "",
                          placeholder: AppImage.placeholderImg,
                          borderRadius: 0,
                        ),
                      ),
                    ),
              vSpace(10),
              nameProfile(),
              vSpace(10),
              listView(),
              vSpace(10),
              if ((widget.recipientData.ratingCount ?? 0) > 0) ...[
                likesAndRatingListView(),
                vSpace(10),
              ],
              if (widget.recipientData.aboutMe != null &&
                  widget.recipientData.aboutMe!.isNotEmpty) ...[
                aboutUs(),
                vSpace(10),
              ],
              // Padding(
              //   padding: EdgeInsets.only(
              //       bottom: MediaQuery.of(context).size.height / 50,
              //       left: 20,
              //       right: 20),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Material(
              //       borderRadius: BorderRadius.circular(25.0),
              //       elevation: 0,
              //       child: Container(
              //         height: MediaQuery.of(context).size.height / 19,
              //         decoration: BoxDecoration(
              //             // color: buttonColor,
              //             gradient: buttonGradient,
              //             borderRadius: BorderRadius.circular(100.0)),
              //         child: InkWell(
              //           onTap: () async {
              //             // if (widget.recipientData!.isLikedByRecipient ??
              //             //     false) {
              //             await chatOnPressed(
              //                 widget.recipientData.userId.toString(),
              //                 isLikedByRecipient:
              //                     widget.recipientData.isLikedByRecipient,
              //                 context);
              //             // } else {
              //             // }
              //           },
              //           borderRadius: BorderRadius.circular(25.0),
              //           child: Center(
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Custom.svgIconData(AppSvgIcons.chatBorder,
              //                     size: 20, color: AppColors.white),
              //                 hSpace(10),
              //                 Text(
              //                   "Chat",
              //                   style: AppFontStyle.buttonText,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CardIconButton(
                    icon: AppSvgIcons.likeOutline,
                    text: "Like",
                    onTap: () async {
                      cntrl.isAction.value = true;
                      // await cntrl.actionDonor(
                      //     widget.recipientData.userId, UserActions.like);

                      // await Future.delayed(Duration(seconds: 2), () async {
                      //   cntrl.isAction.value = false;
                      //   await cntrl.controller.reactive();
                      //   setState(() {});
                      // });
                      setState(() {});
                    },
                  ),
                  CardIconButton(
                    icon: widget.recipientData.isBookmark
                        ? AppSvgIcons.mayBeFilled
                        : AppSvgIcons.mayBeOutline,
                    text: "Maybe",
                    // onTap: () async => cntrl.actionDonor(
                    //     widget.recipientData.userId, UserActions.maybe),
                  ),
                  CardIconButton(
                    icon: AppSvgIcons.disLikeOutline,
                    text: "Dislike",
                    // onTap: () async => cntrl.actionDonor(
                    //     widget.recipientData.userId, UserActions.dislike),
                  ),
                  CardIconButton(
                      icon: AppSvgIcons.chatBorder,
                      text: "Chat",
                      onTap: () async {
                        // await chatOnPressed(
                        //     widget.recipientData.userId.toString(),
                        //     isLikedByRecipient:
                        //         widget.recipientData.isLikedByRecipient,
                        //     context);
                      }),
                ]),
              ),
              vSpace(20)
            ],
          ),
        ),
      );
}
