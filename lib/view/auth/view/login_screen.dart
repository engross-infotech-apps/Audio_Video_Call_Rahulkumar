import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/helper/validation_helper.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/auth/controller/login_controller.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     color: AppColors.primaryRed,
  //   );
  // }

  final cntrl = Get.put(LoginController());

  @override
  void initState() {
    cntrl.password.text = "";
    cntrl.email.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom.appBar(
        backButton: false,
        actions: InkWell(
          // onTap: () => Get.offAll(CreateAccount()),
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              'Create account',
              textAlign: TextAlign.right,
              style: AppFontStyle.blackRegular14pt,
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => Future.delayed(
          Duration.zero,
          () => true,
        ),
        // onWillPop: appOnWillPop,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: cntrl.loginValidateKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              vSpace(20),
              Text(
                'Welcome back to GoKidu!',
                style: AppFontStyle.heading2,
                textAlign: TextAlign.left,
              ),
              vSpace(40),
              CustomTextField(
                  title: "Email address",
                  maxLength: 120,
                  inputType: TextInputType.emailAddress,
                  controller: cntrl.email,
                  hintText: "Enter email address",
                  validator: (v) => ValidationHelper.emailValidation(v!)),
              vSpace(10),
              Obx(
                () => CustomTextField(
                    title: "Password",
                    controller: cntrl.password,
                    maxLength: 120,
                    obscure: cntrl.pwdHide.value,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          cntrl.pwdHide.value = !cntrl.pwdHide.value;
                        },
                        child: Custom.svgIconData(cntrl.pwdHide.value
                            ? AppSvgIcons.visibilityOff
                            : AppSvgIcons.visibility)),
                    hintText: "Enter password",
                    validator: (v) => cntrl.passwordValidation(v!)),
              ),
              vSpace(5),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      // Get.to(ForgotPassword());
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: AppColors.primaryRed),
                    )),
              ),
              // vSpace(),
              CustomPrimaryButton(
                textValue: "Log in",
                callback: () async {
                  FocusScope.of(context).unfocus();
                  await cntrl.loginUser();
                },
              ),
              vSpace(30),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Image.asset(AppImage.line1)),
                    hSpace(10),
                    Text('OR LOG IN WITH',
                        textAlign: TextAlign.center,
                        style: AppFontStyle.greyRegular10pt),
                    hSpace(10),
                    Expanded(child: Image.asset(AppImage.line2)),
                  ]),
              vSpace(30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (Platform.isIOS) ...[
                  CustomBgRoundedIcons(
                    icon: AppSvgIcons.apple,
                    bgColor: AppColors.greyLight,
                    borderColor: AppColors.greyLightBorder,
                    onTap: () async {},
                  ),
                  hSpace(20),
                ],
                CustomBgRoundedIcons(
                  icon: AppSvgIcons.google,
                  bgColor: AppColors.greyLight,
                  borderColor: AppColors.greyLightBorder,
                  onTap: () async {},
                ),
                hSpace(20),
                CustomBgRoundedIcons(
                  icon: AppSvgIcons.facebook,
                  bgColor: AppColors.greyLight,
                  borderColor: AppColors.greyLightBorder,
                  onTap: () async {},
                ),
              ]),
            ]),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
      //   child: TermsAndCondition(
      //     text: "By continuing",
      //     alignment: TextAlign.center,
      //   ),
      // ),
    );
  }
}
