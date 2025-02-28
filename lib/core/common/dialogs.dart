// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';

showLookupBottomSheet(
        {Widget? child, bool enableDrag = true, bool isDismissible = true}) =>
    showModalBottomSheet(
        context: NavigationService.navigatorKey.currentContext!,
        isScrollControlled: true,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (context) {
          return SafeArea(child: child!);
        });

showAppToast(String msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontSize: 12);

showAppSnackbar(String msg) {
  RenderObject? snackBar =
      NavigationService.snackBarKey.currentContext?.findRenderObject();
  if (snackBar == null) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(
            SnackBar(content: Text(msg), key: NavigationService.snackBarKey));
  }
}

showSnackBarAction(UserActions action, VoidCallback onTap) {
  Get.snackbar(
    action.value,
    "Click Open to see all your ${action.value}${action == UserActions.maybe ? "" : "s"}",
    margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black,
    backgroundGradient: gradient,
    colorText: Colors.white,
    duration: const Duration(seconds: 5),
    mainButton: TextButton(
      onPressed: onTap,
      child: Text(
        "Open",
        style: AppFontStyle.blackRegular16pt
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

openAppDialog(text) {
  showDialog(
    context: NavigationService.navigatorKey.currentContext!,
    builder: (context) => AlertMsgDialog(
      title: "Permission",
      msg: "Please enable $text permission from app setting.",
      primaryText: "Open Settings",
      secondaryText: "Cancel",
      image: AppSvgIcons.myLocation,
      primaryBtnTap: () async {
        // Navigator.pop(context);
        // await openAppSettings();
      },
      secondaryBtnTap: () {
        Navigator.pop(context);
      },
    ),
  );
}

showLoadingDialog() =>
    waitDialog(NavigationService.navigatorKey.currentContext!,
        loaderKey: NavigationService.loaderKey);

closeLoadingDialog() {
  RenderObject? dialog =
      NavigationService.loaderKey.currentContext?.findRenderObject();
  if (dialog != null) {
    Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
  }
}

/// Waiting Dialog
waitDialog(BuildContext context,
    {message = "Please wait...", Duration? duration, GlobalKey? loaderKey}) {
  var dialog = Dialog(
    key: loaderKey,
    insetPadding: EdgeInsets.zero,
    shape: OutlineInputBorder(borderRadius: BorderRadius.zero),
    elevation: 0.0,
    backgroundColor: Colors.black.withOpacity(0.5),
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(color: AppColors.white),
            ),
            vSpace(20),
            Text(message,
                style: AppFontStyle.blackRegular14pt.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.white)),
          ],
        ),
      ),
    ),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    useSafeArea: false,
    builder: (_) => WillPopScope(onWillPop: () async => false, child: dialog),
  );

  if (duration != null) {
    Future.delayed(
      duration,
      () {
        final RenderObject? dialog =
            loaderKey?.currentContext?.findRenderObject();
        if (dialog != null) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}

animatedDialog(
        {Widget? child,
        EdgeInsets? insetPadding,
        bool? barrierDismissible,
        String barrierLabel = "",
        BorderRadius? borderRadius,
        Duration? transitionDuration}) =>
    showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Dialog(
              backgroundColor: AppColors.white,
              insetAnimationCurve: Curves.bounceInOut,
              insetPadding:
                  insetPadding ?? EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(30)),
              child: child,
            ),
          );
        },
        transitionDuration: transitionDuration ??
            Duration(milliseconds: 150), // DURATION FOR ANIMATION
        barrierDismissible: barrierDismissible ?? true,
        barrierLabel: barrierLabel,
        context: NavigationService.navigatorKey.currentContext!,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SizedBox();
        });
