import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/api_response.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
// import 'package:gokidu_app_tour/core/services/api_services/modules/user.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/main.dart';
// import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/recipient_list/view/view_recipient_page.dart';
// import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/view/explore_donor_details.dart';
import 'package:gokidu_app_tour/view/liked/model/liked_model.dart';

class LikeController extends GetxController {
  var likeData = Rxn<LikeDataModel>();
  var tabCtrl = Rxn<TabController>();

  var likeByOtherList = <LikeModel>[].obs;
  var likeByMeList = <LikeModel>[].obs;
  var maybeList = <LikeModel>[].obs;
  var disLikeList = <LikeModel>[].obs;

  var totalLikeByOtherCount = 0.obs;
  var totalLikeByMeCount = 0.obs;
  var totalMaybeCount = 0.obs;
  var totalDisLikeCount = 0.obs;

  var loaderOne = true.obs;
  var loaderTwo = true.obs;
  var loaderThree = true.obs;
  var loaderFour = true.obs;

  var user = AppStorage.getUserData();

  var pageNoListOne = 1.obs;
  var pageNoListTwo = 1.obs;
  var pageNoListThree = 1.obs;
  var pageNoListFour = 1.obs;

  final scrollCtrlMe = ScrollController();
  final scrollCtrlOther = ScrollController();
  final scrollCtrlMaybe = ScrollController();
  final scrollCtrlDisLike = ScrollController();

  final date = DateTime.now();
  var selectedTab = 0.obs;
  // var selectedIndex = Rxn<int>();
  var chooseGrid = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  init() async {
    pageNoListOne.value = 1;
    pageNoListTwo.value = 1;
    pageNoListThree.value = 1;
    pageNoListFour.value = 1;

    totalLikeByOtherCount.value = 0;
    totalLikeByMeCount.value = 0;
    totalMaybeCount.value = 0;
    totalDisLikeCount.value = 0;

    scrollCtrlOther.addListener(loadOtherLike);
    scrollCtrlMe.addListener(loadMyLike);
    scrollCtrlMaybe.addListener(loadMaybe);
    scrollCtrlDisLike.addListener(loadDisLike);

    await getListOne();
    await getListTwo();
    await getMaybeList();
    await getDisLikeList();

    unreadLikeCount.value = 0;
  }

  loadMyLike() async {
    if (scrollCtrlMe.position.pixels == scrollCtrlMe.position.maxScrollExtent &&
        likeByMeList.length != totalLikeByMeCount.value) {
      pageNoListTwo.value++;
      getListTwo();
    }
  }

  loadOtherLike() async {
    if (scrollCtrlOther.position.pixels ==
            scrollCtrlOther.position.maxScrollExtent &&
        likeByOtherList.length != totalLikeByOtherCount.value) {
      pageNoListOne.value++;
      getListOne();
    }
  }

  loadMaybe() async {
    if (scrollCtrlMaybe.position.pixels ==
            scrollCtrlMaybe.position.maxScrollExtent &&
        maybeList.length != totalMaybeCount.value) {
      pageNoListThree.value++;
      getMaybeList();
    }
  }

  loadDisLike() async {
    if (scrollCtrlDisLike.position.pixels ==
            scrollCtrlDisLike.position.maxScrollExtent &&
        disLikeList.length != totalDisLikeCount.value) {
      pageNoListFour.value++;
      getDisLikeList();
    }
  }

  getListOne() async {
    if (pageNoListOne.value <= 1) {
      loaderOne.value = true;
      likeByOtherList.clear();
    }

    var param = {
      "PageNumber": pageNoListTwo.value.toString(),
      "PageSize": "10",
      "ActionType": UserActions.likeByOther.number,
    };
    LikeDataModel? allData;
    var response1 = await ResponseWrapper.init(
        create: () => APIResponse<LikeDataModel>(create: () => LikeDataModel()),
        data: await DefaultAssetBundle.of(
                NavigationService.navigatorKey.currentContext!)
            .loadString("assets/json/action_list.json"));
    allData = response1.response.data;

    // allData = await UserApi().getActionList(param, false);

    likeData.value = allData;
    likeByOtherList.addAll(allData?.likes ?? []);

    likeData.value?.likes?.clear();
    totalLikeByOtherCount.value = likeData.value?.totalCount ?? 0;
    loaderOne.value = false;
  }

  getListTwo() async {
    if (pageNoListTwo.value <= 1) {
      loaderTwo.value = true;
      likeByMeList.clear();
    }

    var param = {
      "PageNumber": pageNoListTwo.value.toString(),
      "PageSize": "10",
      "ActionType": UserActions.like.number,
    };
    LikeDataModel? allData;
    var response1 = await ResponseWrapper.init(
        create: () => APIResponse<LikeDataModel>(create: () => LikeDataModel()),
        data: await DefaultAssetBundle.of(
                NavigationService.navigatorKey.currentContext!)
            .loadString("assets/json/action_list.json"));
    allData = response1.response.data;
    // allData = await UserApi().getActionList(param, false);

    likeData.value = allData;
    likeByMeList.addAll(allData?.likes ?? []);
    likeData.value?.likes?.clear();
    totalLikeByMeCount.value = likeData.value?.totalCount ?? 0;
    loaderTwo.value = false;
  }

  getMaybeList() async {
    if (pageNoListThree.value <= 1) {
      loaderThree.value = true;
      maybeList.clear();
    }
    var param = {
      "PageNumber": pageNoListThree.value.toString(),
      "PageSize": "10",
      "ActionType": UserActions.maybe.number,
    };
    LikeDataModel? allData;
    var response1 = await ResponseWrapper.init(
        create: () => APIResponse<LikeDataModel>(create: () => LikeDataModel()),
        data: await DefaultAssetBundle.of(
                NavigationService.navigatorKey.currentContext!)
            .loadString("assets/json/action_list.json"));
    allData = response1.response.data;

    // allData = await UserApi().getActionList(param, false);

    likeData.value = allData;
    maybeList.addAll(allData?.likes ?? []);
    likeData.value?.likes?.clear();
    totalMaybeCount.value = likeData.value?.totalCount ?? 0;
    loaderThree.value = false;
  }

  getDisLikeList() async {
    if (pageNoListFour.value <= 1) {
      loaderFour.value = true;
      disLikeList.clear();
    }
    var param = {
      "PageNumber": pageNoListFour.value.toString(),
      "PageSize": "10",
      "ActionType": UserActions.dislike.number,
    };
    LikeDataModel? allData;
    var response1 = await ResponseWrapper.init(
        create: () => APIResponse<LikeDataModel>(create: () => LikeDataModel()),
        data: await DefaultAssetBundle.of(
                NavigationService.navigatorKey.currentContext!)
            .loadString("assets/json/action_list.json"));
    allData = response1.response.data;

    // allData = await UserApi().getActionList(param, false);

    likeData.value = allData;
    disLikeList.addAll(allData?.likes ?? []);
    likeData.value?.likes?.clear();
    totalDisLikeCount.value = likeData.value?.totalCount ?? 0;
    loaderFour.value = false;
  }

  tabListener() {
    if (tabCtrl.value?.index != selectedTab.value) {
      selectedTab.value = tabCtrl.value!.index;
      // debugPrint("----index----${selectedTab.value}");
      // if (AppStorage.getUserData()?.roleId == UserRole.recipient.number) {
      //   final recipientCtrl =
      //       Get.find<RecipientBottomBarController>(tag: "bottombar");
      //   recipientCtrl.selectedAction.value =
      //       UserActions.getActionByIndex(tabCtrl.value!.index);
      // } else {
      //   final donorCntrl =
      //       Get.find<BottomNavBarController>(tag: "bottomNavBar");
      //   donorCntrl.selectedAction.value =
      //       UserActions.getActionByIndex(tabCtrl.value!.index);
      // }
    }
  }

  callBack(index) {
    switch (index) {
      case 0:
        {
          pageNoListOne.value = 1;
          return getListOne();
        }
      case 1:
        {
          pageNoListTwo.value = 1;
          return getListTwo();
        }
      case 2:
        {
          pageNoListThree.value = 1;
          return getMaybeList();
        }
      case 3:
        {
          pageNoListFour.value = 1;
          return getDisLikeList();
        }
      default:
        return null;
    }
  }

  onTapMethod(LikeModel listData, index) {
    if (user!.roleId == 1) {
      if (listData.userId != null) {
        // Get.to(ExploreDonorDetailsPage(id: listData.userId!))?.then((value) {
        //   if (value["isUpdate"]) {
        //     // callBack(index);
        //     getListOne();
        //     getListTwo();
        //     getMaybeList();
        //     getDisLikeList();
        //   }
        // });
      }
    } else {
      if (listData.userId != null) {
        // Get.to(ViewRecipient(recipientId: listData.userId!))
        //     ?.then((value) async {
        //   if (value["isUpdate"]) {
        //     // await callBack(index);
        //     getListOne();
        //     getListTwo();
        //     getMaybeList();
        //     getDisLikeList();
        //   }
        // });
      }
    }
  }

  bool getLoader(index) {
    switch (index) {
      case 0:
        return loaderOne.value;
      case 1:
        return loaderTwo.value;
      case 2:
        return loaderThree.value;
      case 3:
        return loaderFour.value;
      default:
        return false;
    }
  }

  getTabList(index) {
    switch (index) {
      case 0:
        return likeByOtherList;
      case 1:
        return likeByMeList;
      case 2:
        return maybeList;
      case 3:
        return disLikeList;
      default:
        return [];
    }
  }

  getScrollCntrl(index) {
    switch (index) {
      case 0:
        return scrollCtrlOther;
      case 1:
        return scrollCtrlMe;
      case 2:
        return scrollCtrlMaybe;
      case 3:
        return scrollCtrlDisLike;
      default:
        return ScrollController();
    }
  }
}
