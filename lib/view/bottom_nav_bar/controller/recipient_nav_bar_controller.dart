// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/view/explore_donors_list.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/home/view/recipient_home_page.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/recipient_profile/view/recipient_profile.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/filter_appbar_view.dart';
import 'package:gokidu_app_tour/view/chat/view/chat_list.dart';
import 'package:gokidu_app_tour/view/liked/view/liked_page.dart';

class RecipientBottomBarController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedAction = Rxn<UserActions>();
  var user = AppStorage.getUserData().obs;
  var appBarView = [].obs;
  var filterCount = 0.obs;
  var chatBadgeCounter = 0.obs;
  var widgetOptions = <Widget>[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    // var data = await DefaultAssetBundle.of(
    //         NavigationService.navigatorKey.currentContext!)
    //     .loadString("assets/json/recipient_data.json");
    // var recipientData = jsonDecode(data);
    // await AppStorage.appStorage
    //     .write(AppStorage.userData, jsonEncode(recipientData["data"]));
    widgetOptions.value = [
      RecipientHomePage(),
      // ChatEmptyView(),
      // ChatUserList(),
      ChatRoomList(),
      ExploreDonorsListPage(),

      LikeScreen(),
      // RatingReview(),
      // Container(
      //   color: AppColors.lightPink,
      //   child: Center(
      //     child: Text(
      //       "Like screen",
      //       style: AppFontStyle.heading2,
      //     ),
      //   ),
      // ),
      // Container(
      //   color: AppColors.lightPink,
      //   child: Center(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           "Profile screen",
      //           style: AppFontStyle.heading2,
      //         ),
      //         vSpace(20),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 30.0),
      //           child: CustomPrimaryButton(
      //             textValue: "LogOut",
      //             callback: () {
      //               Get.offAll(LoginPage());
      //             },
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      RecipientProfileScreen()
    ];

    await getAppBarView();
  }

  getAppBarView() {
    appBarView.value = [
      {
        "title": "Hi, Recipient",
        "svg": Custom.svgIconData(AppSvgIcons.notification),
        //  Container(
        //     padding: EdgeInsets.all(10),
        //     decoration: BoxDecoration(3
        //         shape: BoxShape.circle, color: AppColors.lightPink),
        //     child: Custom.svgIconData(AppSvgIcons.notification)),
      },
      {
        "title": "Chats",
        "svg": null,
      },
      {
        "title": "Donors",
        "svg": AppBarIconButton(
          text: "Preferences (${filterCount.value})",
          icon: AppSvgIcons.filter,
        ),
      },
      // {
      //   "title": "Ratings & reviews",
      //   "svg": null,
      // },
      {
        "title": "Activity",
        "svg": CustomBgRoundedIcons(
          icon: (AppStorage.getLayoutStyle() ?? 0) == LayoutStyle.grid.number
              ? AppSvgIcons.gridView
              : AppSvgIcons.listView,
          size: 40,
          iconColor: Colors.white,
          isGradient: true,
          onTap: null,
        )
      },
      {
        "title": "Profile",
        "svg": Custom.svgIconData(
          AppSvgIcons.setting,
        ),
      },
    ].obs;
  }
}
