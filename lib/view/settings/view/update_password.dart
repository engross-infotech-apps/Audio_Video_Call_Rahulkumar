import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/helper/validation_helper.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/settings/controller/setting_controller.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final cntrl = Get.put(SettingController());

  void initState() {
    cntrl.currentPasswordCntrl.clear();
    cntrl.passwordCntrl.clear();
    cntrl.retypePasswordCntrl.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom.appBar(title: 'Change password'),
      body: SafeArea(
        child: Form(
          key: cntrl.passwordValidateKey,
          child: LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Obx(
                    () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vSpace(20),
                          Text(
                              "You'll be logged out of all sessions except this one to protect your account if anyone is trying to gain access.",
                              style: AppFontStyle.greyRegular16pt),
                          vSpace(20),
                          Text(
                              "Your password  must be at least 8 characters and should include a combination of numbers, letters and special character.",
                              style: AppFontStyle.greyRegular16pt),
                          vSpace(30),
                          CustomTextField(
                              controller: cntrl.currentPasswordCntrl,
                              obscure: cntrl.currentPwdHide.value,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    cntrl.currentPwdHide.value =
                                        !cntrl.currentPwdHide.value;
                                  },
                                  child: Custom.svgIconData(
                                      cntrl.currentPwdHide.value
                                          ? AppSvgIcons.visibilityOff
                                          : AppSvgIcons.visibility)),
                              hintText: "Current password",
                              validator: (v) =>
                                  cntrl.isFieldEmpty(v!, "current password")),
                          vSpace(10),
                          CustomTextField(
                              controller: cntrl.passwordCntrl,
                              obscure: cntrl.pwdHide.value,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp("[\\s]")),
                              ],
                              onChanged: (v) {
                                cntrl.pwdPattern.value =
                                    !ValidationHelper.pwdPattern(v);
                                cntrl.pwd8Char.value = v.length > 7;
                                setState(() {});
                              },
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    cntrl.pwdHide.value = !cntrl.pwdHide.value;
                                  },
                                  child: Custom.svgIconData(cntrl.pwdHide.value
                                      ? AppSvgIcons.visibilityOff
                                      : AppSvgIcons.visibility)),
                              hintText: "New password",
                              validator: (v) => cntrl.passwordValidation(v!)),
                          vSpace(10),
                          CustomTextField(
                              controller: cntrl.retypePasswordCntrl,
                              obscure: cntrl.newPwdHide.value,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp("[\\s]")),
                              ],
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    cntrl.newPwdHide.value =
                                        !cntrl.newPwdHide.value;
                                  },
                                  child: Custom.svgIconData(
                                      cntrl.newPwdHide.value
                                          ? AppSvgIcons.visibilityOff
                                          : AppSvgIcons.visibility)),
                              hintText: "Retype new password",
                              validator: (v) => cntrl.rePasswordValidation(v!)),
                          TextButton(
                              onPressed: () async {
                                // await Get.to(ForgotPassword());
                              },
                              child: Text(
                                "Forgotten your password?",
                                style: AppFontStyle.blackRegular16pt.copyWith(
                                    color: AppColors.primaryRed,
                                    fontWeight: FontWeight.w600),
                              )),
                          Spacer(),
                          vSpace(10),
                          CustomPrimaryButton(
                            textValue: "Change password",
                            callback: () async {
                              FocusScope.of(context).unfocus();
                              await cntrl.changePassword();
                            },
                          ),
                          vSpace(10),
                        ]),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
