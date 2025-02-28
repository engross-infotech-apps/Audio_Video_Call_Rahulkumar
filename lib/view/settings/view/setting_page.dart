// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/auth/view/login_screen.dart';
import 'package:gokidu_app_tour/view/settings/controller/setting_controller.dart';
import 'package:gokidu_app_tour/view/settings/view/update_password.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => SettingStatePage();
}

class SettingStatePage extends State<SettingPage> {
  final ctrl = Get.put(SettingController());
  PackageInfo? versionInfo;

  @override
  void initState() {
    getVersion();
    super.initState();
  }

  getVersion() async {
    versionInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget rowTile(text, status, Function(bool) onChange) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(text,
            style: AppFontStyle.blackRegular16pt.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18)),
        Switch(
          value: status,
          inactiveTrackColor: AppColors.lightPink,
          inactiveThumbColor: AppColors.primaryRed,
          activeTrackColor: AppColors.primaryRed,
          activeColor: AppColors.white,
          trackOutlineColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            return Colors.transparent;
          }),
          trackOutlineWidth: WidgetStateProperty.resolveWith<double?>(
              (Set<WidgetState> states) {
            return 0;
          }),
          onChanged: onChange,
        ),
      ]),
    );
  }

  Widget bankAccountSection() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSpace(30),
            titleText("Payments & funds"),
            vSpace(10),
            tile("Bank accounts", () async {
              // _launchUrl("https://gokidu.com/privacypolicy");
            }),
            Custom.divider()
          ],
        ),
      );

  Widget titleText(text) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(text,
            style: AppFontStyle.greyRegular16pt.copyWith(
                fontWeight: FontWeight.w600, color: AppColors.greyLightText)),
      );

  Widget tile(title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Expanded(
                child: Text(
              title,
              style: AppFontStyle.blackRegular16pt
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            )),
            Container(
              color: Colors.transparent,
              child: Custom.svgIconData(AppSvgIcons.arrowRight,
                  fit: BoxFit.scaleDown, size: 18),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom.appBar(title: "Settings"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            vSpace(30),
            titleText("Notifications"),
            vSpace(15),
            rowTile("Notifications alerts",
                ctrl.profileDetails.value?.isEnableNotificationsAlerts ?? true,
                (v) async {
              var status = await ctrl.updateNotificationStatus(notification: v);
              if (status) {
                ctrl.profileDetails.value?.isEnableNotificationsAlerts = v;
                await ctrl.getProfileDetails();
              }
              setState(() {});
            }),
            Custom.divider(),
            rowTile("Emails",
                ctrl.profileDetails.value?.isEnableEmailsAlerts ?? true,
                (v) async {
              var status = await ctrl.updateNotificationStatus(email: v);
              if (status) {
                ctrl.profileDetails.value?.isEnableEmailsAlerts = v;
                await ctrl.getProfileDetails();
              }
              setState(() {});
            }),
            Custom.divider(),
            vSpace(30),
            titleText("Legal"),
            vSpace(10),
            tile("Privacy policy", () async {
              await _launchUrl("https://gokidu.com/privacypolicy");
            }),
            Custom.divider(),
            tile("Terms and conditions", () async {
              await _launchUrl("https://gokidu.com/termcondition");
            }),
            Custom.divider(),
            ctrl.profileDetails.value?.roleId == 2
                ? bankAccountSection()
                : SizedBox(),
            vSpace(30),
            titleText("Manage account"),
            vSpace(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Your email",
                  style: AppFontStyle.blackRegular16pt.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
            vSpace(8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("${ctrl.profileDetails.value?.email}",
                  style: AppFontStyle.greyRegular16pt),
            ),
            vSpace(10),
            Custom.divider(),
            if (ctrl.profileDetails.value?.isEmailUser ?? false) ...[
              tile("Change password", () async {
                await Get.to(UpdatePassword());
              }),
              Custom.divider(),
            ],
            tile("Deactivate account", () async {
              await showDialog(
                context: context,
                builder: (context) => AlertMsgDialog(
                  title: "Deactivate",
                  msg: "Are you sure you want to deactivate account?",
                  primaryText: "Deactivate",
                  secondaryText: "Cancel",
                  primaryBtnColor: AppColors.primaryRed,
                  primaryBtnTap: () async {
                    Get.back();
                    await ctrl.deleteUserAccount(AccountDeleteType.deactivate);
                  },
                  secondaryBtnTap: () => Navigator.pop(context),
                ),
              );
            }),
            Custom.divider(),
            ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertMsgDialog(
                    title: "Delete",
                    msg: "Are you sure you want to delete your account?",
                    primaryText: "Delete",
                    secondaryText: "Cancel",
                    primaryBtnColor: AppColors.primaryRed,
                    primaryBtnTap: () async {
                      Get.back();
                      ctrl.deleteUserAccount(AccountDeleteType.deleteAccount);
                    },
                    secondaryBtnTap: () => Navigator.pop(context),
                  ),
                );
              },
              minLeadingWidth: 10,
              leading: Custom.svgIconData(AppSvgIcons.delete,
                  color: AppColors.redError),
              title: Text(
                "Delete account",
                style: AppFontStyle.blackRegular16pt.copyWith(
                    color: AppColors.redError, fontWeight: FontWeight.w600),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "GoKidu v" +
                    (versionInfo?.version ?? "") +
                    "(${versionInfo?.buildNumber ?? ""})",
                style: AppFontStyle.greyRegular14pt,
                textAlign: TextAlign.center,
              ),
            ),
            vSpace(10),
          ]),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          await showDialog(
            context: context,
            builder: (context) => AlertMsgDialog(
              title: "Logout",
              msg: "Are you sure you want to Logout?",
              primaryText: "Logout",
              secondaryText: "Cancel",
              primaryBtnColor: AppColors.primaryRed,
              primaryBtnTap: () async {
                await showLoadingDialog();
                try {} catch (e) {
                  debugPrint("---error---$e");
                }
                await AppStorage.appStorage.remove(AppStorage.userData);
                await AppStorage.appStorage
                    .remove(AppStorage.addBankAccountTimeDate);
                await AppStorage.appStorage
                    .remove(AppStorage.addBankAccountPopCount);
                await Get.deleteAll();
                await closeLoadingDialog();
                await Get.offAll(LoginPage());
              },
              secondaryBtnTap: () => Navigator.pop(context),
            ),
          );
        },
        child: SafeArea(
          child: Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.lightPinkBorder)),
            alignment: Alignment.center,
            child: Text(
              "Logout",
              style: AppFontStyle.blackRegular16pt.copyWith(
                  color: AppColors.redError,
                  fontSize: 19,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
