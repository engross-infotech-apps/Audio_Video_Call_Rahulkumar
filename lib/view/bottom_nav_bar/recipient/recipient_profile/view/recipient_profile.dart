import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/verify_profile.dart';
import 'package:gokidu_app_tour/view/settings/view/setting_page.dart';
import 'package:gokidu_app_tour/widgets/gradient_border_container.dart';
import '../controller/recipient_profile_controller.dart';

class RecipientProfileScreen extends StatefulWidget {
  const RecipientProfileScreen({super.key});

  @override
  State<RecipientProfileScreen> createState() => RecipientProfileScreenState();
}

class RecipientProfileScreenState extends State<RecipientProfileScreen> {
  final ctrl = Get.put(RecipientProfileController(), tag: 'recipientProfile');

  @override
  void initState() {
    ctrl.loading.value = false;
    super.initState();
    ctrl.init();
  }

  cardView(String title, String subtitle, VoidCallback ontap, String svgIcon) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        leading: CustomBgRoundedIcons(
          icon: svgIcon,
          size: 50,
          iconColor: AppColors.primaryRed,
          onTap: () {},
        ),
        titleAlignment: ListTileTitleAlignment.center,
        contentPadding: EdgeInsets.symmetric(vertical: 5),

        title: Text(title,
            style: AppFontStyle.blackRegular16pt
                .copyWith(fontWeight: FontWeight.w600, fontSize: 16)),

        // subtitle: subtitle == ""
        //     ? null
        //     : Padding(
        //         padding: const EdgeInsets.only(top: 5),
        //         child: Text(subtitle,
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //             style: AppFontStyle.greyRegular16pt.copyWith(fontSize: 14)),
        //       ),
        trailing: Custom.svgIconData(
          AppSvgIcons.arrowRight,
          size: 18,
        ),
      ),
    );
  }

  profile() {
    return Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            // Get.to(EditRecipientProfile())!.then((value) {
            //   if (value != null && value) {
            //     final bottomBarCntrl =
            //         Get.find<RecipientBottomBarController>(tag: "bottombar");
            //     bottomBarCntrl.selectedIndex.value == 4;
            //     bottomBarCntrl.appBarView[0] = {
            //       "title":
            //           "Hi, ${ctrl.profileData.value.displayName != null && ctrl.profileData.value.displayName!.isNotEmpty ? ctrl.profileData.value.displayName : ctrl.profileData.value.fullName ?? ""}",
            //       "svg": null
            //     };
            //     setState(() {});
            //   }
            // });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GradientBorderContainer(
                color: AppColors.white,
                height: 120,
                width: 120,
                gradientColor: buttonGradient,
                borderWidth: 5,
                padding: EdgeInsets.all(3),
                boxShape: BoxShape.circle,
                child: Obx(
                  () => ClipOval(
                      child: ctrl.profileImg.value == null
                          ? CustomNetWorkImage(
                              image:
                                  ctrl.profileData.value.profilePicture ?? "",
                              placeholder: AppImage.emptyProfile)
                          : Image.file(
                              ctrl.profileImg.value!,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              vSpace(20),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => Text(
                          ctrl.profileData.value.displayName ??
                              ctrl.profileData.value.fullName ??
                              "N/A",
                          style: AppFontStyle.heading4,
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
              vSpace(10),
              GestureDetector(
                onTap: () {
                  // Get.to(EditRecipientProfile())!.then((value) {
                  //   if (value != null && value) {
                  //     final bottomBarCntrl =
                  //         Get.find<RecipientBottomBarController>(
                  //             tag: "bottombar");
                  //     bottomBarCntrl.selectedIndex.value == 4;
                  //     bottomBarCntrl.appBarView[0] = {
                  //       "title":
                  //           "Hi, ${ctrl.profileData.value.displayName != null && ctrl.profileData.value.displayName!.isNotEmpty ? ctrl.profileData.value.displayName : ctrl.profileData.value.fullName ?? ""}",
                  //       "svg": null
                  //     };
                  //     setState(() {});
                  //   }
                  // });
                },
                child: Text(
                  'Edit profile',
                  style: AppFontStyle.greyRegular16pt.copyWith(
                      color: AppColors.primaryRed, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ));
  }

  divider() => Divider(thickness: 1.5, color: AppColors.greyCardBorder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: Custom.appBar(title: 'Profile', backButton: false),
      body: Obx(
        () => ctrl.loading.value
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  child: Custom.loader(),
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profile(),
                      vSpace(30),
                      if (!(ctrl.profileData.value.isUploadDocumentStatus ??
                          false)) ...[
                        VerifyProfileView(
                          marginHorizontal: 0,
                          callback: () async {
                            // await Get.to(IdDetailsScreen())?.then((v) async {
                            //   ctrl.recipientProfileData.value =
                            //       await RecipientApi().recipientProfile();
                            //   ctrl.profileData.value = ctrl
                            //       .recipientProfileData.value.recipientProfile!;
                            //   setState(() {});
                            // });
                          },
                        ),
                        vSpace(20),
                      ],
                      cardView("Donor preferences",
                          "Customize your search and find your perfect donor match",
                          () {
                        // Get.to(DonorPreferences());
                      }, AppSvgIcons.diversity),
                      divider(),
                      cardView(
                        "Ratings and reviews",
                        "Manage your ratings and reviews added on donors profile",
                        () {
                          // Get.to(RatingReview());/
                        },
                        AppSvgIcons.ratingBorder,
                      ),
                      divider(),
                      // cardView(
                      //     "Transaction history",
                      //     "View transactions you made to donors",
                      //     () {},
                      //     AppSvgIcons.transaction),
                      // divider(),
                      cardView("Settings", "", () {
                        Get.to(SettingPage());
                      }, AppSvgIcons.settingBorder),
                      // divider(),
                      // cardView(
                      //     "Help and assistance", "", () {}, AppSvgIcons.helpAssistance),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
