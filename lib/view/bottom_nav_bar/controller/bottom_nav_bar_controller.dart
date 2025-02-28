import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/user_model.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/home/view/home_page.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/view/profile_page.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/recipient_list/view/recipient_list_page.dart';
import 'package:gokidu_app_tour/view/chat/view/chat_list.dart';
import 'package:gokidu_app_tour/view/liked/view/liked_page.dart';

class BottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;
  var chatBadgeCounter = 0.obs;

  // var donorProfileDetail = Rxn<DonorProfileDetail>();
  UserBasicDetailsModel? user = AppStorage.getUserData();
  var selectedAction = Rxn<UserActions>();

  var widgetOptions = <Widget>[].obs;

  var appBarView = [].obs;
  bool isListening = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    // var data = await DefaultAssetBundle.of(
    //         NavigationService.navigatorKey.currentContext!)
    //     .loadString("assets/json/donor_data.json");
    // var donorData = jsonDecode(data);
    // if (donorData["data"] != null) {
    //   await AppStorage.appStorage
    //       .write(AppStorage.userData, jsonEncode(donorData["data"]));
    // }
    getAppBarView();
    widgetOptions.value = [
      HomePage(
        onNearbyTap: (Value) {
          selectedIndex.value = Value!;
        },
      ),
      ChatRoomList(), // Container(
      //   color: AppColors.lightPink,
      //   child: Center(
      //     child: Text(
      //       "Recipient screen",
      //       style: AppFontStyle.heading2,
      //     ),
      //   ),
      // ),
      RecipientList(),
      // RatingReview(),
      LikeScreen(),
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
      ProfilePage(),
    ];
  }

  getAppBarView() {
    appBarView.value = [
      {
        "title": "Hi, Donor",
        "svg": Custom.svgIconData(AppSvgIcons.notification),
        //  Container(
        //     padding: EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //         shape: BoxShape.circle, color: AppColors.lightPink),
        //     child: Custom.svgIconData(AppSvgIcons.notification)),
      },
      {
        "title": "Chats",
        "svg": null,
      },
      {
        "title": "Recipients",
        "svg": null, //FilterAppBarView(filterCount: filterCount.value)
      },
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
