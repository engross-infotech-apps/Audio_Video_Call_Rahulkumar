import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/api_response.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/main.dart';
import '../models/home_model.dart';

class DonorHomeController extends GetxController {
  var dashboardData = Rxn<HomeDashboardModel?>();
  var isLoading = true.obs;

  getHomeDashBoardData() async {
    isLoading.value = true;
    dashboardData.value = HomeDashboardModel();
    try {
      var response1 = ResponseWrapper.init(
          create: () => APIResponse<HomeDashboardModel>(
              create: () => HomeDashboardModel()),
          data: await DefaultAssetBundle.of(
                  NavigationService.navigatorKey.currentContext!)
              .loadString("assets/json/donor_home.json"));
      HomeDashboardModel? list = response1.response.data;
      if (list != null) {
        dashboardData.value = list;
        unreadLikeCount.value = list.unreadLikeCount;
      }
    } catch (e) {
      closeLoadingDialog();
    }
    isLoading.value = false;
  }
}
