// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/api_response.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/response_model.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/view/bottom_nav_bar_page.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/view/recipient_navbar_page.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginValidateKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var pwdHide = true.obs;

  passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter password!';
    }
    return null;
  }

  loginUser() async {
    if (loginValidateKey.currentState?.validate() ?? false) {
      await showLoadingDialog();
      try {
        var response1 = ResponseWrapper.init(
            create: () =>
                APIResponse<SignInResModel>(create: () => SignInResModel()),
            data: await DefaultAssetBundle.of(
                    NavigationService.navigatorKey.currentContext!)
                .loadString("assets/json/donor_login_json.json"));
        var donor = response1.response.data;

        var response2 = ResponseWrapper.init(
            create: () =>
                APIResponse<SignInResModel>(create: () => SignInResModel()),
            data: await DefaultAssetBundle.of(
                    NavigationService.navigatorKey.currentContext!)
                .loadString("assets/json/recipient_login_json.json"));
        var recipient = response2.response.data;

        await Future.delayed(
          Duration(milliseconds: 1000),
          () {
            closeLoadingDialog();
          },
        );

        if (donor?.email?.toLowerCase() == email.text.toLowerCase() &&
            password.text == "Gokidu@12345") {
          var data = await DefaultAssetBundle.of(
                  NavigationService.navigatorKey.currentContext!)
              .loadString("assets/json/donor_data.json");
          var donorData = jsonDecode(data);
          var userDataJson = jsonEncode(donorData["data"]);
          await AppStorage.appStorage.write(AppStorage.userData, userDataJson);
          await Get.offAll(BottomNavBarPage());
        } else if (recipient?.email?.toLowerCase() ==
                email.text.toLowerCase() &&
            password.text == "Gokidu@12345") {
          var data = await DefaultAssetBundle.of(
                  NavigationService.navigatorKey.currentContext!)
              .loadString("assets/json/recipient_data.json");
          var recipientData = jsonDecode(data);
          var userDataJson = jsonEncode(recipientData["data"]);
          await AppStorage.appStorage.write(AppStorage.userData, userDataJson);
          await Get.offAll(RecipientBottomNavBarPage());
        } else {
          await showDialog(
            context: Get.context!,
            builder: (context) => AlertMsgDialog(
                title: "Error",
                msg: "Email or password is wrong!",
                secondaryText: "Close",
                image: AppSvgIcons.report,
                secondaryBtnTap: () {
                  Navigator.pop(context);
                }),
          );
        }
      } catch (e) {
        await closeLoadingDialog();
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
}
