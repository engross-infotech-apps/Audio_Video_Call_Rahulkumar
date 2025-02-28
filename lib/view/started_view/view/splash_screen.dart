// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/auth/view/login_screen.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/view/bottom_nav_bar_page.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/view/recipient_navbar_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.page,
  });

  final String page;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    setUpUI();
    super.initState();
  }

  Future setUpUI() async {
    await GetStorage.init();

    print("------page---${widget.page}");
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();

    await navigateToGoKiduApp();

    // var connectionStatus = ConnectionStatusListener.getInstance();
    // await connectionStatus.initialize();
    // if (!connectionStatus.hasConnection) {
    //   updateConnectivity(false, connectionStatus);
    // } else {
    //   navigateToGoKiduApp();
    // }
    // connectionStatus.connectionChange.listen((event) {
    //   debugPrint("initNoInternetListener $event");
    //   if (event) {
    //     navigateToGoKiduApp();
    //   }
    //   updateConnectivity(event, connectionStatus);
    // });
  }

  navigateToGoKiduApp() async {
    // Timer(Duration(milliseconds: 3500), () async {
    print("---###----*");
    var user = AppStorage.getUserData();
    if (user != null) {
      if (user.roleId == UserRole.recipient.number) {
        Timer(Duration(milliseconds: 3500), () async {
          await Get.off(RecipientBottomNavBarPage());
        });
      } else if (user.roleId != UserRole.recipient.number) {
        Timer(Duration(milliseconds: 3500), () async {
          await Get.off(BottomNavBarPage());
        });
      } else {
        Timer(Duration(milliseconds: 3500), () async {
          await Get.off(LoginPage());
        });
      }
    } else {
      Timer(Duration(milliseconds: 3500), () async {
        await Get.off(LoginPage());
      });
    }

    // FirebaseMessaging.onBackgroundMessage(fire.myBackgroundMessageHandler);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(bottom: 50),
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(gradient: gradient),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.bottomCenter,
            // height: 300,
            // width: 200,
            // color: Colors.yellow,
            // child: Custom.lottieAsset(Lotties.splashLottie),
            child: Image.asset(
              AppGif.splashImgGif2,
              // scale: 2.5,
              opacity: const AlwaysStoppedAnimation<double>(1.0),
            ),
          ),

          // Text("GoKidu",
          //     style: AppFontStyle.heading1.copyWith(
          //         color: Colors.white,
          //         fontSize: 60,
          //         letterSpacing: -1,
          //         fontWeight: FontWeight.w900)),

          // Text('Baby for All',
          //     style: AppFontStyle.greyRegular16pt.copyWith(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //         letterSpacing: 3,
          //         fontSize: 22)),
          // AnimatedTextKit(
          //   animatedTexts: [
          //     ScaleAnimatedText('GoKidu',
          //         scalingFactor: 0,
          //         duration: Duration(seconds: 5),
          //         textStyle: AppFontStyle.heading1.copyWith(
          //             color: Colors.white,
          //             fontSize: 60,
          //             fontWeight: FontWeight.w900)),
          //   ],
          // ),
          // AnimatedTextKit(
          //   animatedTexts: [
          //     TyperAnimatedText('Baby for All',
          //         speed: Duration(milliseconds: 100),
          //         textStyle: AppFontStyle.greyRegular16pt.copyWith(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             letterSpacing: 3,
          //             fontSize: 22)),
          //   ],
          // ),
          // Image.asset(AppImage.splashImg),
        ]),
      ),
    );
  }
}
