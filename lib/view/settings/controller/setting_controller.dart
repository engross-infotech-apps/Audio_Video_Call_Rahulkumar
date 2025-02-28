import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/helper/validation_helper.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/view/auth/view/login_screen.dart';
import 'package:gokidu_app_tour/view/settings/view/update_password.dart';

class SettingController extends GetxController {
  GlobalKey<FormState> passwordValidateKey = GlobalKey<FormState>();
  GlobalKey<FormState> codeValidateKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailValidateKey = GlobalKey<FormState>();

  // var profileDetails = Rxn<UserBasicDetailsModel>();

  var emailCntrl = TextEditingController();
  var otpCntrl = TextEditingController();
  var currentPasswordCntrl = TextEditingController();
  var passwordCntrl = TextEditingController();
  var retypePasswordCntrl = TextEditingController();

  var pwdPattern = false.obs;
  var pwd8Char = false.obs;
  var resendOtp = false.obs;
  var pwdHide = true.obs;
  var newPwdHide = true.obs;
  var currentPwdHide = true.obs;

  var profileDetails = AppStorage.getUserData().obs;

  // @override
  // void onInit() {
  //   getProfileDetails();
  //   super.onInit();
  // }

  isFieldEmpty(String value, String hint) {
    if (value.trim().isEmpty) {
      return 'Please enter $hint!';
    }
    return null;
  }

  Future getProfileDetails() async {
    // try {
    //   UserBasicDetailsModel? list = await UserApi().getUserBasicDetails();
    //   if (list != null) {
    //     profileDetails.value = list;
    //     var encodedetails = jsonEncode(list.toMap());
    //     await AppStorage.appStorage.write(AppStorage.userData, encodedetails);
    //   }
    // } catch (e) {
    //   debugPrint("---error---${e}");
    // }
  }

  Future<bool> updateNotificationStatus(
      {bool? notification, bool? email}) async {
    // var parameter = {
    //   "IsEnableNotificationsAlerts": notification,
    //   "IsEnableEmailsAlerts": email,
    // };
    try {
      return true;
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
      return false;
    }
  }

  resendOtpForEmail() async {
    FocusScope.of(Get.context!).unfocus();
    if (emailValidateKey.currentState?.validate() ?? false) {
      try {
        resendOtp.value = true;
        // var res = await AuthApi().resendUpdatePassword(emailCntrl.text);
        // showDialog(
        //   context: Get.context!,
        //   builder: (context) => AlertMsgDialog(
        //       title: "Success",
        //       msg: res!.message.toString(),
        //       primaryText: "Done",
        //       image: AppSvgIcons.checkCircle,
        //       primaryBtnTap: () {
        //         Navigator.pop(context);
        //       }),
        // );
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

  updatePwdCodeVerify() async {
    FocusScope.of(Get.context!).unfocus();
    if (codeValidateKey.currentState?.validate() ?? false) {
      // var parameter = {
      //   "Email": emailCntrl.text.trim(),
      //   "OTP": otpCntrl.text.trim()
      // };
      try {
        Get.off(UpdatePassword());
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

  errorDialog(String text) async {
    await showDialog(
      context: Get.context!,
      builder: (context) => AlertMsgDialog(
          title: "Error",
          msg: text,
          secondaryText: "Close",
          image: AppSvgIcons.report,
          secondaryBtnTap: () {
            Navigator.pop(context);
          }),
    );
  }

  passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter password!';
    } else if (ValidationHelper.isPasswordValid(value)) {
      return 'Your password  must be at least 8 characters and should include a combination of numbers, letters and special character!';
    }
    return null;
  }

  rePasswordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter password!';
    } else if (passwordCntrl.text != retypePasswordCntrl.text) {
      return 'New password does not match. Enter new password again here!';
    }
    return null;
  }

  updatePasswod() async {
    FocusScope.of(Get.context!).unfocus();
    if (currentPasswordCntrl.text.isEmpty) {
      errorDialog("Please enter current password!");
    } else if (passwordCntrl.text.isNotEmpty) {
      errorDialog("Please enter new password!");
    } else if (retypePasswordCntrl.text.isNotEmpty) {
      errorDialog("Please enter retype password!");
    } else if (passwordCntrl.text != retypePasswordCntrl.text) {
      errorDialog("New password and Retype password does not match!");
    } else if (ValidationHelper.passwordValidation(passwordCntrl.text) !=
        null) {
      errorDialog(
          "Your password  must be at least 8 characters and should include a combination of numbers, letters and special character.");
    } else {
      await changePassword();
    }
  }

  changePassword() async {
    if (passwordValidateKey.currentState?.validate() ?? false) {
      // Map parameter = {
      //   "OldPassword": currentPasswordCntrl.text.trim(),
      //   "NewPassword": passwordCntrl.text.trim(),
      // };
      try {
        showAppSnackbar("Your password changed successfully!");
        Get.back();
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

  deleteUserAccount(AccountDeleteType type) async {
    try {
      await AppStorage.appStorage.remove(AppStorage.userData);
      await AppStorage.appStorage.remove(AppStorage.addBankAccountTimeDate);
      await AppStorage.appStorage.remove(AppStorage.addBankAccountPopCount);
      await Get.deleteAll();
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => AlertMsgDialog(
            title: "Account ${type.number == 1 ? "deactivated" : "deleted"}",
            msg:
                "Your account is ${type.number == 1 ? "deactivated" : "deleted"} successfully.",
            primaryText: "Okay",
            primaryBtnTap: () {
              Navigator.pop(context);
            }),
      );
      await Get.offAll(LoginPage());
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
