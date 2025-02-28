import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/api_response.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/user_model.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/main.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/home/model/recipient_home_model.dart';

class RecipientHomeController extends GetxController {
  var recipientHomeData = Rxn<RecipientHomeModel>();
  var nearByUserList = <NearByUser>[].obs;
  var recentChatsList = <RecentChat>[].obs;
  var userBookmarksList = <LikeBookmarkUser>[].obs;
  var likeUserList = <LikeBookmarkUser>[].obs;
  UserBasicDetailsModel? userData = AppStorage.getUserData();

  @override
  Future<void> onInit() async {
    // getRecipientHomeData();
    // await getRecentChatData();
    super.onInit();
  }

  Future getRecipientHomeData() async {
    recipientHomeData.value = RecipientHomeModel();
    nearByUserList.clear();
    recentChatsList.clear();
    likeUserList.clear();
    userBookmarksList.clear();
    try {
      var response1 = ResponseWrapper.init(
          create: () => APIResponse<RecipientHomeModel>(
              create: () => RecipientHomeModel()),
          data: await DefaultAssetBundle.of(
                  NavigationService.navigatorKey.currentContext!)
              .loadString("assets/json/recipient_home.json"));
      RecipientHomeModel? data = response1.response.data;
      if (data != null) {
        recipientHomeData.value = data;
        nearByUserList.value = data.nearByUser ?? [];
        recentChatsList.value = data.recentChats ?? [];
        likeUserList.value = data.userLikes ?? [];
        userBookmarksList.value = data.userBookmark ?? [];
        unreadLikeCount.value = data.unreadLikeCount ?? 0;
      }
    } catch (e) {
      await showDialog(
        context: Get.context!,
        builder: (context) => AlertMsgDialog(
            title: "Error",
            msg: e.toString(),
            secondaryText: "Close",
            image: AppSvgIcons.report,
            secondaryBtnTap: () {
              Navigator.pop(context);
            }),
      );
    }
  }
}
