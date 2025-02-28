import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/function/app_function.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/controller/bottom_nav_bar_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/controller/donor_profile_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/boost_profile.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/verify_profile.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  final cntrl = Get.put(DonorProfileController(), tag: "profile");

  final BottomNavBarController bottomNavCtrl =
      Get.find<BottomNavBarController>(tag: "bottomNavBar");
  final scrollViewController = ScrollController();
  bool readMore = false;
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

  @override
  void initState() {
    cntrl.init();
    super.initState();
  }

  Widget profileImg() {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        margin: EdgeInsets.only(bottom: 8),
        width: 170,
        height: 170,
        child: SfRadialGauge(
          animationDuration: 50000,
          // enableLoadingAnimation: true,
          axes: <RadialAxis>[
            RadialAxis(
                startAngle: 115,
                endAngle: 425,
                axisLineStyle: AxisLineStyle(thickness: 10),
                showTicks: false,
                showLabels: false,
                showFirstLabel: false,
                pointers: <GaugePointer>[
                  RangePointer(
                    value: (cntrl.donorProfileDetail.value
                                ?.profileCompletionPercentage ??
                            0)
                        .toDouble(),
                    width: 10,
                    cornerStyle: CornerStyle.bothCurve,
                    enableAnimation: true,
                    // color: AppColors.primaryRed
                    gradient: SweepGradient(
                      colors: [
                        AppColors.primaryRed,
                        AppColors.primaryRed,
                        AppColors.gradientYellow,
                      ],
                    ),
                  )
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      axisValue: 50,
                      positionFactor: 0.07,
                      widget: Container(
                        height: 145,
                        width: 145,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.lightPink),
                        alignment: Alignment.center,
                        child: imgView(),
                      )),
                ])
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: gradient,
          ),
          child: Text(
            "${cntrl.donorProfileDetail.value?.profileCompletionPercentage ?? 0}% complete"
                .toUpperCase(),
            style: AppFontStyle.greyRegular14pt.copyWith(
                fontSize: 12,
                color: AppColors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ]);
  }

  addBankAccountView({other = false}) {
    return GestureDetector(
      onTap: () async {
        // await Get.put(ChatViewController(), tag: "chatViewCntrl");
        // await Get.to(AccountDetails(
        //   isFromSetting: true,
        // ))?.then(
        //   (v) => setState(() {}),
        // );
      },
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

  // Widget temp() {
  //   return g.AnimatedRadialGauge(
  //     duration: const Duration(seconds: 5),
  //     curve: Curves.slowMiddle,
  //     radius: 80,
  //     value: 20,
  //     axis: g.GaugeAxis(
  //       // min: 90,
  //       // max: 360,
  //       degrees: 320,
  //       style: const g.GaugeAxisStyle(
  //         thickness: 10,
  //         background: Color(0xFFDFE2EC),
  //         // segmentSpacing: 4,
  //       ),
  //       progressBar: const g.GaugeProgressBar.rounded(
  //         color: Color(0xFFB4C2F8),
  //       ),
  //     ),
  //   );
  // }

  Widget imgView() {
    return GestureDetector(
      // onTap: () => Get.to(DonorEditProfile())!.then((value) async {
      //   if (value["isUpdate"]) {
      //     await cntrl.getDonorProfileData();
      //     bottomNavCtrl.appBarView[0] = await {
      //       "title":
      //           "Hi, ${cntrl.donorProfileDetail.value?.displayName != null && cntrl.donorProfileDetail.value!.displayName!.isNotEmpty ? cntrl.donorProfileDetail.value?.displayName : cntrl.donorProfileDetail.value?.fullName ?? ""}",
      //       "svg": null
      //     };
      //     AppStorage.getUserData()?.profilePicture =
      //         cntrl.donorProfileDetail.value?.profilePicture;
      //     // bottomNavCtrl.donorProfileDetail.value =
      //     //     cntrl.donorProfileDetail.value;
      //     await UserApi().storeUserData();

      //     setState(() {});
      //   }
      // }),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
            child: CachedNetworkImage(
          imageUrl: CustomText.imgEndPoint +
              (cntrl.donorProfileDetail.value?.profilePicture ?? ""),
          errorListener: (value) {},
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
          placeholder: (context, url) =>
              Container(alignment: Alignment.center, child: Custom.loader()),
          errorWidget: (context, url, error) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.lightPink,
                  image: DecorationImage(
                    image: AssetImage(AppImage.emptyProfile),
                    fit: BoxFit.cover,
                  )),
            );
          },
        )),
      ),
    );
  }

  Widget editProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          // onTap: () => Get.to(DonorViewProfile()),
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.lightPink),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Custom.svgIconData(AppSvgIcons.eysColor),
              hSpace(8),
              Text("View profile",
                  style: AppFontStyle.blackRegular14pt
                      .copyWith(fontWeight: FontWeight.w600))
            ]),
          ),
        ),
        hSpace(10),
        GestureDetector(
          // onTap: () => Get.to(DonorEditProfile())!.then((value) async {
          //   if (value["isUpdate"]) {
          //     await cntrl.getDonorProfileData();
          //     bottomNavCtrl.appBarView[0] = await {
          //       "title":
          //           "Hi, ${cntrl.donorProfileDetail.value?.displayName != null && cntrl.donorProfileDetail.value!.displayName!.isNotEmpty ? cntrl.donorProfileDetail.value?.displayName : cntrl.donorProfileDetail.value?.fullName ?? ""}",
          //       "svg": null
          //     };
          //     // bottomNavCtrl.donorProfileDetail.value =
          //     //     cntrl.donorProfileDetail.value;
          //     await UserApi().storeUserData();
          //     setState(() {});
          //   }
          // }),
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.lightPink),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Custom.svgIconData(AppSvgIcons.edit),
              hSpace(8),
              Text("Edit profile",
                  style: AppFontStyle.blackRegular14pt
                      .copyWith(fontWeight: FontWeight.w600))
            ]),
          ),
        ),
      ],
    );
    //   return GestureDetector(
    //     onTap: () => Get.to(DonorEditProfile())!.then((value) async {
    //       debugPrint("---valuee---1-${value}");
    //       // if (value != null)
    //       cntrl.getDonorProfileData();
    //     }),
    //     child: Container(
    //       margin: EdgeInsets.symmetric(horizontal: 20),
    //       padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(50),
    //           color: AppColors.lightPink),
    //       child: Row(mainAxisSize: MainAxisSize.min, children: [
    //         Custom.svgIconData(AppSvgIcons.edit),
    //         hSpace(8),
    //         Text("Edit profile",
    //             style: AppFontStyle.blackRegular14pt
    //                 .copyWith(fontWeight: FontWeight.w600))
    //       ]),
    //     ),
    //   );
  }

  Widget aboutUs() {
    //debugPrint("---read---$readMore");
    return Obx(
      () => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text.rich(
            TextSpan(
                text: (cntrl.donorProfileDetail.value?.aboutMe?.length ?? 0) >
                            170 &&
                        !readMore
                    ? cntrl.donorProfileDetail.value?.aboutMe?.substring(0, 170)
                    : cntrl.donorProfileDetail.value?.aboutMe ?? "N/A",
                style: AppFontStyle.greyRegular14pt,
                children: [
                  TextSpan(
                      text: (cntrl.donorProfileDetail.value?.aboutMe?.length ??
                                      0) >
                                  170 &&
                              !readMore
                          ? " .. "
                          : "."),
                  WidgetSpan(
                    child: (cntrl.donorProfileDetail.value?.aboutMe?.length ??
                                0) >
                            170
                        ? InkWell(
                            onTap: () => setState(() {
                              readMore = !readMore;
                            }),
                            child: Text(readMore ? 'view less' : 'view more',
                                style: AppFontStyle.greyRegular14pt.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryRed)),
                          )
                        : SizedBox(),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  likeRatingView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                bottomNavCtrl.selectedIndex.value = 3;
              },
              child: Container(
                padding: const EdgeInsets.all(18),
                width: double.maxFinite,
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
                            cntrl.donorProfileDetail.value!.likeCount == 0
                                ? AppSvgIcons.heartBorder
                                : AppSvgIcons.heartFill,
                            size: 20)),
                    vSpace(10),
                    Text(
                        cntrl.donorProfileDetail.value!.likeCount == null ||
                                cntrl.donorProfileDetail.value!.likeCount == 0
                            ? "00"
                            : "${cntrl.donorProfileDetail.value!.likeCount.toString()}",
                        style: AppFontStyle.heading4
                            .copyWith(fontWeight: FontWeight.w500)),
                    /* vSpace(10),
                    Text(
                      "Total profile likes",
                      style: AppFontStyle.greyRegular14pt,
                    )*/
                  ],
                ),
              ),
            ),
          ),
          hSpace(20),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Get.to(RatingReview());
              },
              child: Container(
                padding: const EdgeInsets.all(18),
                width: double.maxFinite,
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
                            (cntrl.donorProfileDetail.value?.averageRating ?? 0)
                                .toDouble(),
                        itemCount:
                            cntrl.donorProfileDetail.value!.averageRating == 0.0
                                ? 1
                                : (cntrl.donorProfileDetail.value
                                            ?.averageRating ??
                                        0.0)
                                    .ceil(),
                        allowHalfRating: true,
                        direction: Axis.horizontal,
                        itemBuilder: (context, index) => Custom.svgIconData(
                            cntrl.donorProfileDetail.value!.averageRating == 0
                                ? AppSvgIcons.ratingBorder
                                : AppSvgIcons.starFill,
                            color: ratingStarColor(
                                cntrl.donorProfileDetail.value!.averageRating)),
                        onRatingUpdate: (double value) {},
                      ),
                    ),
                    // Custom.svgIconData(AppSvgIcons.heartFill, size: 20),
                    vSpace(10),
                    Text(
                        "${cntrl.donorProfileDetail.value?.averageRating?.toStringAsFixed(1)}",
                        style: AppFontStyle.heading4
                            .copyWith(fontWeight: FontWeight.w500)),
                    /* vSpace(10),
                    Text(
                      "Total profile ratings",
                      style: AppFontStyle.greyRegular14pt
                          .copyWith(fontWeight: FontWeight.w400),
                    )*/
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color? ratingStarColor(x) {
    if (x > 0 && x <= 2.0) {
      return AppColors.redError;
    } else if (x > 2.0 && x <= 3.5) {
      return AppColors.ratingYellow;
    } else {
      return null;
    }
  }

  stayUpdateView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.greyCardBorder,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stay updated with your tests",
              style:
                  AppFontStyle.heading4.copyWith(fontWeight: FontWeight.w500),
            ),
            vSpace(10),
            Text(
              "Maintain your profile's accuracy. Keep your STD, Genetic Testing, and Semen Analysis results updated.",
              style: AppFontStyle.greyRegular14pt,
            ),
            vSpace(10),
            GestureDetector(
                onTap: () {
                  // Get.to(ProfileReportPage(
                  //   isFromProfile: true,
                  //   onSave: () {
                  //     cntrl.getDonorProfileData();
                  //   },
                  //   genericTestReport:
                  //       cntrl.donorProfileDetail.value?.geneticTestReportFile,
                  //   semenTestReport:
                  //       cntrl.donorProfileDetail.value?.semenTestReportFile,
                  //   stdTestReport:
                  //       cntrl.donorProfileDetail.value?.stdTestReportFile,
                  // ));
                },
                child: Text(
                  "View",
                  style: AppFontStyle.greyRegular14pt.copyWith(
                      color: AppColors.primaryRed, fontWeight: FontWeight.w600),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: appOnWillPop,
      child: SingleChildScrollView(
        controller: scrollViewController,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        child: Obx(
          () => cntrl.donorProfileDetail.value != null
              ? Column(children: [
                  profileImg(),
                  vSpace(20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            cntrl.donorProfileDetail.value?.displayName !=
                                        null &&
                                    cntrl.donorProfileDetail.value!.displayName!
                                        .isNotEmpty
                                ? cntrl.donorProfileDetail.value!.displayName!
                                : cntrl.donorProfileDetail.value?.fullName ??
                                    "N/A",
                            style: AppFontStyle.heading3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        hSpace(5),
                        cntrl.donorProfileDetail.value?.isVerified != null &&
                                cntrl.donorProfileDetail.value?.isVerified ==
                                    true
                            ? Custom.svgIconData(AppSvgIcons.verify, size: 18)
                            : SizedBox(),
                      ],
                    ),
                  ),
                  cntrl.donorProfileDetail.value?.professionName != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                              cntrl.donorProfileDetail.value?.professionName ??
                                  "N/A",
                              style: AppFontStyle.greyRegular14pt
                                  .copyWith(fontWeight: FontWeight.w600)),
                        )
                      : SizedBox(),
                  vSpace(20),

                  editProfile(),
                  vSpace(30),
                  (cntrl.donorProfileDetail.value
                                  ?.profileCompletionPercentage ??
                              0) <
                          100
                      ? BoostProfileView(
                          marginHorizontal: 15,
                          other: false,
                          callback: () {
                            // Get.to(DonorEditProfile())!.then((value) async {
                            //   if (value["isUpdate"]) {
                            //     await cntrl.getDonorProfileData();
                            //     bottomNavCtrl.appBarView[0] = await {
                            //       "title":
                            //           "Hi, ${cntrl.donorProfileDetail.value?.displayName != null && cntrl.donorProfileDetail.value!.displayName!.isNotEmpty ? cntrl.donorProfileDetail.value?.displayName : cntrl.donorProfileDetail.value?.fullName ?? ""}",
                            //       "svg": null
                            //     };
                            //     // bottomNavCtrl.donorProfileDetail.value =
                            //     //     cntrl.donorProfileDetail.value;
                            //     await UserApi().storeUserData();

                            //     AppStorage.getUserData()?.profilePicture = cntrl
                            //         .donorProfileDetail.value?.profilePicture;
                            //     setState(() {});
                            //   }
                            // });
                          },
                          profileCompletionPercentage: (cntrl.donorProfileDetail
                                  .value?.profileCompletionPercentage ??
                              0),
                        )
                      : SizedBox(),
                  vSpace(20),
                  if (!(cntrl
                          .donorProfileDetail.value!.isUploadDocumentStatus ??
                      false)) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: VerifyProfileView(
                        callback: () {
                          // Get.to(IdDetailsScreen())!.then((value) async {
                          //   cntrl.getDonorProfileData();
                          // });
                        },
                        marginHorizontal: 0,
                        other: true,
                      ),
                    ),
                    vSpace(20),
                  ],

                  cntrl.donorProfileDetail.value?.aboutMe != null
                      ? aboutUs()
                      : SizedBox(),
                  vSpace(
                      cntrl.donorProfileDetail.value?.aboutMe != null ? 30 : 0),

                  likeRatingView(),
                  vSpace(20),
                  if (!(AppStorage.getUserData()?.isAddedBankAccount ??
                      false)) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: addBankAccountView(),
                    ),
                    vSpace(10),
                  ]

                  // stayUpdateView(),
                  // CommonWidgets(
                  //   detail:
                  //       cntrl.donorProfileDetail.value ?? DonorProfileDetail(),
                  // ).listView(),
                  // vSpace(20),
                  // CommonWidgets(
                  //   detail:
                  //       cntrl.donorProfileDetail.value ?? DonorProfileDetail(),
                  //   selectedHairColor: cntrl.selectedHairColor.value,
                  // ).physicalView(),
                  // CommonWidgets(
                  //   detail:
                  //       cntrl.donorProfileDetail.value ?? DonorProfileDetail(),
                  //   selectedNationality: cntrl.selectedNationality.value,
                  // ).backgroundView(),
                  // CommonWidgets(
                  //   detail:
                  //       cntrl.donorProfileDetail.value ?? DonorProfileDetail(),
                  // ).professionalInfoView(),
                  // CommonWidgets(
                  //   detail:
                  //       cntrl.donorProfileDetail.value ?? DonorProfileDetail(),
                  // ).reportTestingResult(),
                  // vSpace(20),
                ])
              : SizedBox(),
        ),
      ),
    );
  }
}
