import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/controller/bottom_nav_bar_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/boost_profile.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/image_name_view.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/verify_profile.dart';
import 'package:gokidu_app_tour/widgets/feedback_card.dart';
import '../controller/donor_home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.onNearbyTap});
  final Function(int?)? onNearbyTap;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ctrl = Get.put(DonorHomeController());

  final BottomNavBarController bottomNavCtrl =
      Get.find<BottomNavBarController>(tag: "bottomNavBar");

  late final AnimationController _controller = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      duration: Duration(milliseconds: 900),
      vsync: this,
      lowerBound: 0.6,
      upperBound: 1)
    ..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  List widgetList = [];
  List otherWidgetList = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    ctrl.isLoading.value = true;
    widgetList = [];
    otherWidgetList = [];

    await ctrl.getHomeDashBoardData();
    await addWidgetInList();
    await addOtherWidgetInList();
  }

  Color? ratingStarColor(x) {
    if (x > 0 && x <= 2.0) {
      return AppColors.redError;
    } else if (x > 2.0 && x <= 3.5) {
      return AppColors.ratingYellow;
    } else if (x == 0) {
      return AppColors.greyBorder;
    } else {
      return null;
    }
  }

  likeRatingView() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            bottomNavCtrl.selectedIndex.value = 3;
          },
          child: Container(
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
                        ctrl.dashboardData.value!.userLikesCount == 0
                            ? AppSvgIcons.heartBorder
                            : AppSvgIcons.heartFill,
                        size: 20)),
                vSpace(10),
                Text(
                    "${ctrl.dashboardData.value!.userLikesCount == 0 ? "00" : ctrl.dashboardData.value!.userLikesCount}",
                    style: AppFontStyle.heading4
                        .copyWith(fontWeight: FontWeight.w500)),
                // vSpace(10),
                // Text(
                //   "Total profile likes",
                //   style: AppFontStyle.greyRegular14pt,
                // )
              ],
            ),
          ),
        ),
      ),
      hSpace(10),
      Expanded(
        child: GestureDetector(
          onTap: () {
            // Get.to(RatingReview());
          },
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greyCardBorder,
                ),
                borderRadius: BorderRadius.circular(15)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
                child: RatingBar.builder(
                  ignoreGestures: true,
                  updateOnDrag: false,
                  itemSize: 20,
                  minRating: 1,
                  initialRating: ctrl.dashboardData.value?.averageRating ?? 0,
                  itemCount: ctrl.dashboardData.value?.averageRating == 0
                      ? 1
                      : ctrl.dashboardData.value?.averageRating.ceil() ?? 0,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  itemBuilder: (context, index) => Custom.svgIconData(
                    ctrl.dashboardData.value!.averageRating == 0
                        ? AppSvgIcons.ratingBorder
                        : AppSvgIcons.starFill,
                    // color: ratingStarColor(
                    //     ctrl.dashboardData.value!.averageRating),
                  ),
                  onRatingUpdate: (double value) {},
                ),
              ),
              // Custom.svgIconData(AppSvgIcons.heartFill, size: 20),
              vSpace(10),
              Text(
                  (ctrl.dashboardData.value?.averageRating ?? 0) <= 0.5
                      ? "0.0"
                      : "${ctrl.dashboardData.value?.averageRating.toStringAsFixed(1) ?? 0}",
                  style: AppFontStyle.heading4
                      .copyWith(fontWeight: FontWeight.w500)),
              // vSpace(10),
              // Text(
              //   "Total profile ratings",
              //   style: AppFontStyle.greyRegular14pt,
              // )
            ]),
          ),
        ),
      ),
    ]);
  }

  nearbyRecipient() {
    return GestureDetector(
      onTap: () {
        widget.onNearbyTap!(2);
      },
      child: Container(
        constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
        alignment: Alignment.center,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), gradient: boxGradient),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recipients near you",
              style: AppFontStyle.heading4.copyWith(
                  color: AppColors.white, fontWeight: FontWeight.w500),
            ),
            // vSpace(10),
            // Text(
            //   "Reach out to possible recipients in your area",
            //   style: AppFontStyle.blackRegular14pt
            //       .copyWith(color: AppColors.white),
            // ),
            vSpace(10),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.dashboardData.value?.users?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // if (ctrl.dashboardData.value?.users?[index]
                            //         .userId !=
                            //     null)
                            //   Get.to(ViewRecipient(
                            //       recipientId: ctrl.dashboardData.value!
                            //           .users![index].userId!));
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
                                      color: AppColors.white, width: 2)),
                              child: ClipOval(
                                child: CustomNetWorkImage(
                                  image: (ctrl.dashboardData.value!
                                          .users![index].profilePicture ??
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
                    widget.onNearbyTap!(2);
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

  recentLikes() {
    return GestureDetector(
      onTap: () {
        bottomNavCtrl.selectedIndex.value = 3;
      },
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
        padding: const EdgeInsets.only(
          top: 20,
        ),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: AppColors.greyCardBorder,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recipients Liked you",
                    style: AppFontStyle.heading4
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  ctrl.dashboardData.value!.userLikes!.isEmpty
                      ? SizedBox()
                      : Text(
                          "View all",
                          style: AppFontStyle.greyRegular14pt,
                        )
                ],
              ),
            ),
            vSpace(10),
            Obx(() => ctrl.dashboardData.value!.userLikes!.isEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Start liking!",
                          style: AppFontStyle.heading4
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        vSpace(10),
                        Text(
                          "Discover Your Preferences View Your Recent Likes Here.",
                          textAlign: TextAlign.center,
                          style: AppFontStyle.greyRegular16pt,
                        )
                      ],
                    ),
                  )
                : Container(
                    constraints: BoxConstraints(maxHeight: 130),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Get.to(ViewRecipient(
                            //     recipientId: ctrl.dashboardData.value!
                            //         .userLikes![index].userId!));
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: index == 0 ? 10 : 0,
                                right: index ==
                                        ctrl.dashboardData.value!.userLikes!
                                                .length -
                                            1
                                    ? 10
                                    : 0),
                            child: ImageWithNameView(
                              image: ctrl.dashboardData.value!.userLikes![index]
                                      .profilePicture ??
                                  "",
                              name: ctrl.dashboardData.value!.userLikes![index]
                                              .displayName !=
                                          null &&
                                      ctrl
                                          .dashboardData
                                          .value!
                                          .userLikes![index]
                                          .displayName!
                                          .isNotEmpty
                                  ? ctrl.dashboardData.value!.userLikes![index]
                                      .displayName!
                                  : ctrl.dashboardData.value!.userLikes![index]
                                          .fullName ??
                                      "",
                            ),
                          ),
                        );
                      },
                      itemCount: ctrl.dashboardData.value!.userLikes!.length,
                    ),
                  ))
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

  AppBar homeAppBar() {
    return Custom.appBar(
      backButton: false,
      title: ctrl.dashboardData.value!.fullName ?? "N/A",
      actions: GestureDetector(
        onTap: () {},
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.lightPink),
            child: Custom.svgIconData(
              AppSvgIcons.notification,
            )),
      ),
    );
  }

  addWidgetInList() {
    widgetList = [];

    widgetList.add(nearbyRecipient());
    if (ctrl.dashboardData.value!.profileCompletionPercentage != null &&
        ctrl.dashboardData.value!.profileCompletionPercentage! < 100) {
      var view = BoostProfileView(
          marginHorizontal: 0,
          profileCompletionPercentage:
              ctrl.dashboardData.value!.profileCompletionPercentage ?? 0,
          callback: () {});
      widgetList.add(view);
    }

    if (!(AppStorage.getUserData()?.isAddedBankAccount ?? false)) {
      widgetList.add(addBankAccountView());
    }
    if (ctrl.dashboardData.value?.isFeedbackShow ?? false) {
      widgetList.add(FeedBackCard());
    }
    widgetList.add(guidanceView());

    if (!(ctrl.dashboardData.value!.isUploadDocumentStatus ?? false)) {
      var view = VerifyProfileView(
        callback: () {},
        marginHorizontal: 0,
      );
      widgetList.add(view);
    }

    widgetList.add(likeRatingView());
    if (ctrl.dashboardData.value!.userLikes!.isNotEmpty) {
      widgetList.add(recentLikes());
    }

    setState(() {});
  }

  addOtherWidgetInList() {
    otherWidgetList = [];

    otherWidgetList.add(nearbyRecipient());
    if (ctrl.dashboardData.value!.profileCompletionPercentage != null &&
        ctrl.dashboardData.value!.profileCompletionPercentage! < 100) {
      var view = BoostProfileView(
        marginHorizontal: 0,
        profileCompletionPercentage:
            ctrl.dashboardData.value!.profileCompletionPercentage ?? 0,
        callback: () {},
        other: true,
      );
      otherWidgetList.add(view);
    }
    if (!(AppStorage.getUserData()?.isAddedBankAccount ?? false))
      otherWidgetList.add(addBankAccountView(other: true));
    if (ctrl.dashboardData.value?.isFeedbackShow ?? false) {
      otherWidgetList.add(FeedBackCard(isOtherWidget: true));
    }
    otherWidgetList.add(guidanceView(other: true));

    if (!(ctrl.dashboardData.value!.isUploadDocumentStatus ?? false)) {
      var view = VerifyProfileView(
        callback: () {},
        marginHorizontal: 0,
        other: true,
      );

      otherWidgetList.add(view);
    }

    otherWidgetList.add(likeRatingView());

    if (ctrl.dashboardData.value!.userLikes!.isNotEmpty) {
      otherWidgetList.add(recentLikes());
    }

    setState(() {});
  }

  addBankAccountView({other = false}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minHeight: AppScreenSize.width * 0.32),
        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: other ? null : boxGradient,
            border: other ? Border.all(color: AppColors.greyCardBorder) : null),
        child: Row(
          children: [
            Expanded(
                child: ScaleTransition(
              scale: _animation,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Add your bank details",
                        style: AppFontStyle.heading4
                            .copyWith(color: other ? null : AppColors.white)),
                    vSpace(7),
                    Text(
                      "Enter your bank details",
                      style: AppFontStyle.greyRegular16pt.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: other ? null : AppColors.white,
                          color: other ? null : AppColors.white),
                    ),
                  ]),
            )),
            Padding(
              padding: EdgeInsets.zero,
              child: Custom.lottieAsset(
                  other ? Lotties.bankLottie : Lotties.bankWhiteLottie,
                  size: 100),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widgetList.isEmpty
        ? SizedBox()
        : ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemBuilder: (context, index) {
              return Container(
                child: (index % 2) == 0
                    ? widgetList[index]
                    : otherWidgetList[index],
              );
            },
            separatorBuilder: (context, index) => vSpace(15),
            itemCount: widgetList.length,
          );
  }
}
