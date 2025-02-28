import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/helper/app_intl_formatter.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/helper/validation_helper.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/controller/recipient_nav_bar_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/home/controller/recipient_home_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/image_name_view.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/verify_profile.dart';
import 'package:gokidu_app_tour/widgets/feedback_card.dart';

class RecipientHomePage extends StatefulWidget {
  const RecipientHomePage({super.key});

  @override
  State<RecipientHomePage> createState() => _RecipientHomePageState();
}

class _RecipientHomePageState extends State<RecipientHomePage> {
  final cntrl = Get.put(RecipientHomeController());
  final RecipientBottomBarController bottomBarCntrl =
      Get.find<RecipientBottomBarController>(tag: "bottombar");

  List widgetList = [];
  List otherWidgetList = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await cntrl.getRecipientHomeData();
    await addWidgetInList();
    await addOtherWidgetInList();
    // if ((cntrl.recipientHomeData.value?.ethnicityId == null &&
    //         cntrl.recipientHomeData.value?.otherEthnicity == null) ||
    //     cntrl.recipientHomeData.value?.nationalityId == null) {
    //   await editProfileDialog();
    // }
  }

  editProfileDialog() async {
    await showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: Get.context!,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertMsgDialog(
            title: "Profile",
            msg:
                "Enter your ethnicity and nationality to help donors find you more easily.",
            primaryText: "Complete",
            image: AppSvgIcons.editProfile,
            imgColor: AppColors.primaryRed,
            primaryBtnTap: () async {
              // Get.back();
              // await Get.put(RecipientProfileController(),
              //     tag: 'recipientProfile');
              // await Get.to(EditRecipientProfile(isHome: true));
            }),
      ),
    );
  }

  Widget donorPreferencesView() {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyCardBorder),
          borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Flexible(
            child: Column(
              children: [
                Text("Customize your donor preferences",
                    style: AppFontStyle.heading4),
                vSpace(7),
                Text(
                  "Complete the setup by answering a few questions about your donor preferences.",
                  style: AppFontStyle.greyRegular14pt,
                ),
              ],
            ),
          ),
          hSpace(10),
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                AppImage.donorPreferences,
                height: 50,
              )),
        ]),
        vSpace(8),
        Row(children: [
          Expanded(
            child: CustomPrimaryButton(
              callback: () {
                // Get.to(DonorPreferences())?.then((value) async {
                //   if (value != null && value['success'] == true) {
                //     await cntrl.getRecipientHomeData();
                //     if (!(cntrl
                //             .recipientHomeData.value?.isDonorPreferencesAdded ??
                //         false)) {
                //       await addWidgetInList();
                //       await addOtherWidgetInList();
                //     }
                //   }
                //   setState(() {});
                // });
              },
              height: 40,
              textValue: "Start",
              textSize: 15,
            ),
          ),
          hSpace(10),
          Expanded(
            child: CustomPrimaryButton(
              height: 40,
              textValue: "Do this later",
              textSize: 15,
              callback: () async {
                // setState(() {
                ValidationHelper.preferencesSet = true;
                await addWidgetInList();
                await addOtherWidgetInList();
                setState(() {});
                // });
              },
              buttonColor: AppColors.lightPink,
              textColor: AppColors.black,
            ),
          ),
        ]),
      ]),
    );
  }

  Widget exploreDonorsView() {
    return GestureDetector(
      onTap: () {
        bottomBarCntrl.selectedIndex.value = 2;
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), gradient: boxGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Donors near you",
              style: AppFontStyle.heading4.copyWith(
                  color: AppColors.white, fontWeight: FontWeight.w500),
            ),
            vSpace(10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cntrl.nearByUserList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Get.to(ExploreDonorDetailsPage(
                            //     id: cntrl.nearByUserList[index].userId!));
                          },
                          child: Align(
                            widthFactor: 0.80,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: AppColors.lightPink,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.white, width: 2),
                              ),
                              child: ClipOval(
                                child: CustomNetWorkImage(
                                  image: (cntrl.nearByUserList[index]
                                          .profilePicture ??
                                      ""),
                                  placeholder: AppImage.emptyProfile,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    bottomBarCntrl.selectedIndex.value = 2;
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white54,
                      shape: BoxShape.circle,
                    ),
                    child: Custom.svgIconData(AppSvgIcons.arrowToRight),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget guidanceView({other = false}) {
    return GestureDetector(
      // onTap: () => Get.to(LegalGuidance()),
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
        padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: other ? null : boxGradient,
            border: other ? Border.all(color: AppColors.greyCardBorder) : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Seeking legal guidance?",
                style: AppFontStyle.heading4
                    .copyWith(color: other ? null : AppColors.white)),
            vSpace(5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      // "Connect with nearby fertility lawyers for expert legal assistance in family-building matters.",
                      "Get access to legal contract template and connect with nearby expert fertility lawyers.",
                      style: AppFontStyle.greyRegular16pt
                          .copyWith(color: other ? null : AppColors.white),
                    ),
                  ),
                ),
                Custom.svgIconData(
                    /*other ? AppSvgIcons.gavelGradient : */
                    AppSvgIcons.gavelGradient,
                    color: other ? null : AppColors.white,
                    size: 70),
              ],
            ),
          ],
        ),
      ),
    );
  }

  likeDonorView() {
    return GestureDetector(
      onTap: () {
        // Get.to(LikeScreen());
        bottomBarCntrl.selectedIndex.value = 3;
      },
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyCardBorder),
            borderRadius: BorderRadius.circular(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Donors Liked you",
                      style: AppFontStyle.heading4
                          .copyWith(fontWeight: FontWeight.w500)),
                  Text("View all",
                      style: AppFontStyle.greyRegular14pt
                          .copyWith(fontWeight: FontWeight.w400)),
                ]),
          ),
          vSpace(10),
          Container(
            constraints: BoxConstraints(maxHeight: 130),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: cntrl.likeUserList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  // await Get.to(ExploreDonorDetailsPage(
                  //         id: cntrl.likeUserList[index].userId!))
                  //     ?.then((value) async {
                  //   if (value["isUpdate"]) {
                  //     cntrl.getRecipientHomeData();
                  //     cntrl.getRecentChatData();

                  //     await addWidgetInList();
                  //     await addOtherWidgetInList();
                  //   }
                  // });
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 10 : 0,
                      right: index == cntrl.likeUserList.length - 1 ? 10 : 0),
                  child: ImageWithNameView(
                    image: cntrl.likeUserList[index].profilePicture ?? "",
                    name: (cntrl.likeUserList[index].displayName != null &&
                            cntrl.likeUserList[index].displayName!.isNotEmpty
                        ? cntrl.likeUserList[index].displayName!
                        : cntrl.likeUserList[index].fullName ?? ""),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  bookmarkDonorView() {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyCardBorder),
          borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Maybe donors",
                style: AppFontStyle.heading4
                    .copyWith(fontWeight: FontWeight.w500)),
            InkWell(
              onTap: () {
                bottomBarCntrl.selectedIndex.value = 3;
                bottomBarCntrl.selectedAction.value = UserActions.maybe;
              },
              child: Text("View all",
                  style: AppFontStyle.greyRegular14pt
                      .copyWith(fontWeight: FontWeight.w400)),
            ),
          ]),
        ),
        vSpace(10),
        Container(
          constraints: BoxConstraints(maxHeight: 130),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: cntrl.userBookmarksList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    left: index == 0 ? 10 : 0,
                    right:
                        index == cntrl.userBookmarksList.length - 1 ? 10 : 0),
                child: ImageWithNameView(
                  image: cntrl.userBookmarksList[index].profilePicture ?? "",
                  name: cntrl.userBookmarksList[index].displayName != null &&
                          cntrl.userBookmarksList[index].displayName!.isNotEmpty
                      ? cntrl.userBookmarksList[index].displayName!
                      : cntrl.userBookmarksList[index].fullName ?? "",
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  likeRatingView() {
    return FittedBox(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // Get.to(LikeScreen());
              bottomBarCntrl.selectedIndex.value = 3;
            },
            child: Container(
              // constraints:
              //     BoxConstraints(minHeight: AppScreenSize.width *0.32),
              width: MediaQuery.of(context).size.width * 0.45,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.greyCardBorder,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 20,
                      child: Custom.svgIconData(
                          cntrl.recipientHomeData.value?.userLikesCount == 0
                              ? AppSvgIcons.heartBorder
                              : AppSvgIcons.heartFill,
                          size: 20)),
                  vSpace(10),
                  Text(
                      "${cntrl.recipientHomeData.value?.userLikesCount == 0 || cntrl.recipientHomeData.value?.userLikesCount == null ? "00" : cntrl.recipientHomeData.value?.userLikesCount}",
                      style: AppFontStyle.heading4
                          .copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          hSpace(10),
          GestureDetector(
            onTap: () {},
            child: Container(
              // constraints:
              //     BoxConstraints(minHeight: AppScreenSize.width *0.32),
              width: MediaQuery.of(context).size.width * 0.45,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.greyCardBorder,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    child: RatingBar.builder(
                      ignoreGestures: true,
                      updateOnDrag: false,
                      itemSize: 20,
                      minRating: 1,
                      initialRating:
                          (cntrl.recipientHomeData.value?.averageRating ?? 0)
                              .toDouble(),
                      itemCount: cntrl.recipientHomeData.value?.averageRating ==
                                  0 ||
                              cntrl.recipientHomeData.value?.averageRating ==
                                  null
                          ? 1
                          : cntrl.recipientHomeData.value?.averageRating
                                  ?.ceil() ??
                              0,
                      allowHalfRating: true,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => Custom.svgIconData(
                        cntrl.recipientHomeData.value?.averageRating == 0 ||
                                cntrl.recipientHomeData.value?.averageRating ==
                                    null
                            ? AppSvgIcons.ratingBorder
                            : AppSvgIcons.starFill,
                        color: ratingStarColor(
                            cntrl.recipientHomeData.value?.averageRating ?? 0),
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                  ),
                  // Custom.svgIconData(AppSvgIcons.heartFill, size: 20),
                  vSpace(10),
                  Text(
                      cntrl.recipientHomeData.value!.averageRating! <= 0.5 ||
                              cntrl.recipientHomeData.value?.averageRating ==
                                  null
                          ? "0.0"
                          : "${cntrl.recipientHomeData.value?.averageRating?.toStringAsFixed(1) ?? 0.0}",
                      style: AppFontStyle.heading4
                          .copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  addWidgetInList() {
    widgetList.clear();
    widgetList.add(exploreDonorsView());
    if (cntrl.recipientHomeData.value?.isFeedbackShow ?? false) {
      widgetList.add(FeedBackCard());
    }
    widgetList.add(guidanceView());
    if (!(cntrl.recipientHomeData.value?.isUploadDocumentStatus ?? false)) {
      var view = VerifyProfileView(
        marginHorizontal: 0,
        callback: () {
          // Get.to(IdDetailsScreen())?.then((value) async {
          //   await cntrl.getRecipientHomeData();
          //   if (cntrl.recipientHomeData.value?.isUploadDocumentStatus ??
          //       false) {
          //     await addWidgetInList();
          //     await addOtherWidgetInList();
          //   }
          // });
        },
      );
      widgetList.add(view);
    }
    if (!(cntrl.recipientHomeData.value?.isDonorPreferencesAdded ?? false)) {
      if (!ValidationHelper.preferencesSet)
        widgetList.add(donorPreferencesView());
    }
    widgetList.add(likeRatingView());
    if (cntrl.likeUserList.isNotEmpty) {
      widgetList.add(likeDonorView());
    }

    if (cntrl.userBookmarksList.isNotEmpty) {
      widgetList.add(bookmarkDonorView());
    }

    setState(() {});
  }

  addOtherWidgetInList() {
    otherWidgetList.clear();
    otherWidgetList.add(exploreDonorsView());
    if (cntrl.recipientHomeData.value?.isFeedbackShow ?? false) {
      otherWidgetList.add(FeedBackCard(isOtherWidget: true));
    }
    otherWidgetList.add(guidanceView(other: true));
    if (!(cntrl.recipientHomeData.value?.isUploadDocumentStatus ?? false)) {
      var view = VerifyProfileView(
        marginHorizontal: 0,
        callback: () {
          // Get.to(IdDetailsScreen())?.then((value) async {
          //   await cntrl.getRecipientHomeData();
          //   if (cntrl.recipientHomeData.value?.isUploadDocumentStatus ??
          //       false) {
          //     await addWidgetInList();
          //     await addOtherWidgetInList();
          //   }
          // });
        },
        other: true,
      );
      otherWidgetList.add(view);
    }
    if (!(cntrl.recipientHomeData.value?.isDonorPreferencesAdded ?? false)) {
      if (!ValidationHelper.preferencesSet)
        otherWidgetList.add(donorPreferencesView());
    }
    otherWidgetList.add(likeRatingView());
    if (cntrl.likeUserList.isNotEmpty) {
      otherWidgetList.add(likeDonorView());
    }

    if (cntrl.userBookmarksList.isNotEmpty) {
      otherWidgetList.add(bookmarkDonorView());
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widgetList.isEmpty && widgetList.isEmpty
        ? SizedBox()
        : ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemBuilder: (context, index) {
              // return Obx(() {
              // if (cntrl.recentChatList.isNotEmpty) {
              //   if (cntrl.userBookmarksList.isNotEmpty) {
              //     if (index == widgetList.length - 2) {
              //       return Column(children: [
              //         Container(
              //           child: (index % 2) == 0
              //               ? widgetList[index]
              //               : otherWidgetList[index],
              //         ),
              //         vSpace(15),
              //         recentChat(),
              //       ]);
              //     }
              //   } else {
              //     if (index == widgetList.length - 1) {
              //       return Column(children: [
              //         Container(
              //           child: (index % 2) == 0
              //               ? widgetList[index]
              //               : otherWidgetList[index],
              //         ),
              //         vSpace(15),
              //         recentChat(),
              //       ]);
              //     }
              //   }
              // }
              //   return Container(
              //     child: (index % 2) == 0
              //         ? widgetList[index]
              //         : otherWidgetList[index],
              //   );
              // });
              return Container(
                child: (index % 2) == 0
                    ? widgetList[index]
                    : otherWidgetList[index],
              );
            },
            separatorBuilder: (context, index) => vSpace(15),
            itemCount: widgetList.length,
          );

    // return SingleChildScrollView(
    //   padding: EdgeInsets.symmetric(horizontal: 20),
    //   physics: BouncingScrollPhysics(),
    //   child: Obx(
    //     () => Column(children: [
    //       if (!(cntrl.recipientHomeData.value?.isDonorPreferencesAdded ??
    //           false)) ...[
    //         donorPreferencesView(),
    //         vSpace(20),
    //       ],
    //       exploreDonorsView(),
    //       vSpace(20),
    //       if (!(cntrl.recipientHomeData.value?.isUploadDocumentStatus ??
    //           false)) ...[
    //         VerifyProfileView(
    //           marginHorizontal: 0,
    //           callback: () {
    //             Get.to(IdDetailsScreen())!.then((value) async {
    //               cntrl.getRecipientHomeData();
    //             });
    //           },
    //         ),
    //         vSpace(20),
    //       ],
    //       likeRatingView(),
    //       vSpace(20),
    //       if (cntrl.likeUserList.isNotEmpty) ...[
    //         likeDonorView(),
    //         vSpace(20),
    //       ],
    //       cntrl.recentChatList.isNotEmpty ? recentChat() : SizedBox(),
    //       cntrl.recentChatList.isNotEmpty ? vSpace(20) : SizedBox(),
    //       guidanceView(),
    //       vSpace(20),
    //       if (cntrl.userBookmarksList.isNotEmpty) ...[
    //         bookmarkDonorView(),
    //         vSpace(20),
    //       ],
    //     ]),
    //   ),
    // );
  }
}
