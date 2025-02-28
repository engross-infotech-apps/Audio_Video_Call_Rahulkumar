// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/function/app_function.dart';
import 'package:gokidu_app_tour/core/helper/app_intl_formatter.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/model/donor_profile_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/widgets/expanded_container.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonWidgets {
  CommonWidgets({
    required this.detail,
    this.selectedNationality,
    this.selectedHairColor,
    this.likeView,
  });

  DonorProfileDetail detail;
  LookupModelPO? selectedHairColor, selectedNationality;
  Widget? likeView;
  bool physicalViewExpanded = false;
  bool backgroundViewExpanded = false;
  bool educationExpanded = false;
  bool medicalExpanded = false;

  ExpansionTileController physicalViewCtrl = ExpansionTileController();
  ExpansionTileController backgroundViewCtrl = ExpansionTileController();
  ExpansionTileController educationViewCtrl = ExpansionTileController();
  ExpansionTileController medicalViewCtrl = ExpansionTileController();

  String getCityState() {
    var cityState = "N/A";

    if (detail.city != null && detail.state == null) {
      cityState = detail.city ?? "";
    } else if (detail.city == null && detail.state != null) {
      cityState = detail.state ?? "";
    } else if (detail.city != null && detail.state != null) {
      cityState = "${detail.city ?? ""}, ${detail.state ?? ""}";
    }

    return cityState;
  }

  listCard(String text, {String? svg, Color? color, bgColor, borderColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: bgColor ?? AppColors.greyBG,
          border: Border.all(color: borderColor ?? AppColors.greyBorder)),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            svg == null
                ? SizedBox()
                : Custom.svgIconData(svg, size: 15, color: color),
            hSpace(svg == null ? 0 : 7),
            Text(text, style: AppFontStyle.heading6),
          ]),
    );
  }

  Widget listView() {
    var country = AppStorage.getUserData()?.countryId;
    return SizedBox(
      width: double.maxFinite,
      height: 30,
      child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            hSpace(20),
            if (likeView != null) ...[
              likeView!,
              hSpace(7),
            ],
            listCard("${detail.age ?? "N/A"}", svg: AppSvgIcons.cake),
            hSpace(7),
            listCard(country != null && country == 2
                ? "${mileToKM(detail.distance?.toDouble() ?? 0.0)} km"
                : "${detail.distance?.ceil() ?? "0"} mi"),
            hSpace(7),
            if (detail.bloodGroup != null) ...[
              listCard(detail.bloodGroup ?? "N/A", svg: AppSvgIcons.blood),
              // hSpace(7),
            ],
            // listCard(getCityState(), svg: AppSvgIcons.location),
            hSpace(20),
          ]),
    );
  }

  Widget likesAndRatingListView() {
    return SizedBox(
      width: double.maxFinite,
      height: 30,
      child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            hSpace(20),
            if (detail.ratingCount != null &&
                (detail.ratingCount ?? 0) != 0 &&
                (detail.averageRating) != 0) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.greyBG,
                    border: Border.all(color: AppColors.greyBorder)),
                child: Row(children: [
                  // Text((detail.averageRating ?? 0.0).toStringAsFixed(2),
                  //     style: AppFontStyle.heading4.copyWith(fontSize: 16)),
                  // hSpace(7),
                  // Custom.svgIconData(AppSvgIcons.ratingStar, size: 18),
                  // hSpace(7),
                  // Custom.svgIconData(AppSvgIcons.horizontalDiv,
                  //     color: AppColors.greyBorder),
                  // hSpace(7),
                  SizedBox(
                    height: 15,
                    child: RatingBar.builder(
                      ignoreGestures: true,
                      updateOnDrag: false,
                      itemSize: 15,
                      itemPadding: EdgeInsets.only(right: 2),
                      minRating: 1,
                      initialRating: detail.averageRating?.toDouble() ?? 0,
                      itemCount: 5,
                      unratedColor: AppColors.greyBorder,
                      allowHalfRating: true,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => Custom.svgIconData(
                        AppSvgIcons.ratingStar,
                        color:
                            ratingStarColor(detail.averageRating?.toDouble()),
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                  ),
                  hSpace(5),
                  Text("(${detail.ratingCount ?? "N/A"})",
                      style: AppFontStyle.heading6),
                ]),
              ),
            ],
            hSpace(20),
          ]),
    );
  }

  detailsTile(String title, String subTitle, {Widget? leading, String? svg}) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 10,
      leading: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          padding: EdgeInsets.all(svg != null ? 13 : 0),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: AppColors.lightPink),
          child: svg != null ? Custom.svgIconData(svg, size: 25) : leading),
      title: Text(title,
          style: AppFontStyle.greyRegular14pt
              .copyWith(fontWeight: FontWeight.w600)),
      subtitle:
          Text(subTitle, style: AppFontStyle.heading6.copyWith(height: 2)),
    );
  }

  heightText(num cm) {
    var heightText = "";

    var length = double.parse(cm.toString()) / 2.54;
    var feet = (length / 12).floor();
    var inch = (length - 12 * feet);
    if (inch.round() != inch) {
      if (inch.round() > inch) {
        if (inch.round() >= 12) {
          feet += 1;
          inch = 0;
        } else {
          inch = inch.round().toDouble();
        }
      } else {
        inch = inch.floorToDouble() + 0.5;
      }
    }

    heightText =
        '''${feet.toString()}'${inch.toStringAsFixed(1)}" (${cm.toString()} cm)''';
    return heightText;
  }

  physicalView({
    ExpansionTileController? controller,
    key,
    Function(bool val)? onTap,
  }) {
    return ExpandedContainer(
      key: key,
      controller: controller,
      title: "Physical characteristics",
      ontap: onTap,
      child: Column(children: [
        detailsTile(
            svg: AppSvgIcons.height,
            "Height",
            detail.height != null
                // ? "${cmToFeetConverter(double.parse(detail.height?.toString() ?? "0")).toStringAsFixed(2)}\" (${detail.height} cm)"
                ? heightText(detail.height!)
                : "N/A"),
        vSpace(10),
        detailsTile(
            leading: ClipOval(
                child: selectedHairColor?.image != null
                    ? Image.asset(selectedHairColor?.image ?? "",
                        fit: BoxFit.cover)
                    : Image.asset(AppImage.hairColorImg,
                        height: 25, width: 25)),
            "Hair color",
            detail.hairColor ?? "N/A"),
        vSpace(10),
        detailsTile(
            svg: AppSvgIcons.eysColor, "Eye color", detail.eyeColor ?? "N/A"),
      ]),
    );
  }

  backgroundView({
    ExpansionTileController? controller,
    Function(bool val)? onTap,
    key,
  }) {
    return ExpandedContainer(
      key: key,
      controller: controller,
      ontap: onTap,
      title: "Background information",
      child: Column(children: [
        detailsTile(
            svg: AppSvgIcons.ethnicity,
            "Ethnicity",
            detail.ethnicityName ?? detail.otherEthnicity ?? "N/A"),
        vSpace(10),
        detailsTile(
          "Nationality",
          detail.nationality != null ? detail.nationality.toString() : "N/A",
          leading: selectedNationality?.code != null
              ? Text(
                  countryCodeToEmoji(selectedNationality?.code ?? ""),
                  style: TextStyle(fontSize: 20),
                )
              : null,
          svg: selectedNationality?.code == null ? AppSvgIcons.flag : null,
        ),
        vSpace(10),
        detailsTile(
            svg: AppSvgIcons.religious,
            "Religious beliefs",
            detail.religiousName ?? detail.otherReligious ?? "N/A"),
      ]),
    );
  }

  healthLifestyleView() {
    return ExpandedContainer(
      title: "Health and lifestyle",
      child: detailsTile(
          svg: AppSvgIcons.bloodType,
          "Blood group",
          detail.bloodGroup ?? "N/A"),
    );
  }

  professionalInfoView({
    ExpansionTileController? controller,
    bool dividerEnable = true,
    key,
    Function(bool val)? onTap,
  }) {
    return ExpandedContainer(
      key: key,
      controller: controller,
      ontap: onTap,
      divider: dividerEnable,
      title: "Education and profession",
      child: Column(children: [
        detailsTile(
            svg: AppSvgIcons.occupation,
            "Profession",
            "${detail.professionName ?? "N/A"} "),
        vSpace(10),
        detailsTile(
            svg: AppSvgIcons.education,
            "Education",
            detail.educationName ?? "N/A"),
      ]),
    );
  }

  reportTestingResult(
      {ExpansionTileController? controller,
      RxList<OtherMedicalReport>? medicalReports,
      bool isEnableButton = true,
      key,
      Function(bool val)? onTap}) {
    var std = medicalReports!.firstWhereOrNull((e) => e.medicalReportId == 1);
    var semen = medicalReports.firstWhereOrNull((e) => e.medicalReportId == 2);
    var genetic =
        medicalReports.firstWhereOrNull((e) => e.medicalReportId == 3);

    if (std == null) {
      var report = OtherMedicalReport(
          medicalReportId: 1, medicalReportName: "STD report");
      medicalReports.add(report);
    } else if (semen == null) {
      var report = OtherMedicalReport(
          medicalReportId: 2, medicalReportName: "Semen report");
      medicalReports.add(report);
    } else if (genetic == null) {
      var report = OtherMedicalReport(
          medicalReportId: 3, medicalReportName: "Genetic report");
      medicalReports.add(report);
    }
    medicalReports.sort(
      (a, b) => a.medicalReportId!.compareTo(b.medicalReportId!),
    );

    return Obx(
      () => ExpandedContainer(
          key: key,
          controller: controller,
          ontap: onTap,
          divider: false,
          title: "Medical details",
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return testReportCard(
                medicalReports[index].medicalReportName ?? "N/A",
                reportTypeId: medicalReports[index].medicalReportId,
                isEnableButton: isEnableButton,
                reportFile: medicalReports[index].filePath,
              );
            },
            itemCount: medicalReports.length,
            separatorBuilder: (context, index) => vSpace(15),
          )

          //  Column(children: [
          //   vSpace(10),
          //   testReportCard(
          //     "Blood group",
          //     detail.bloodGroup ?? "N/A",
          //     icon: AppSvgIcons.bloodType,
          //   ),
          //   vSpace(15),
          //   testReportCard(
          //     "STD Status",
          //     "STD testing checks for exposure to the cytomegalovirus, a common virus that can cause complications in pregnancy and affect unborn babies.",
          //     reportStatus: detail.stdTestStatus ?? false,
          //     reportFile: detail.stdTestReportFile,
          //   ),
          //   vSpace(
          //       PregnancyTypes.getType(detail.userType ?? 0) == PregnancyTypes.egg
          //           ? 0
          //           : 15),
          //   PregnancyTypes.getType(detail.userType ?? 0) == PregnancyTypes.egg
          //       ? SizedBox()
          //       : testReportCard(
          //           "Semen Analysis Report",
          //           "A semen analysis evaluates the sperm in a sample, examining sperm count, motility, morphology, and other factors.",
          //           reportStatus: detail.semenTestStatus ?? false,
          //           reportFile: detail.semenTestReportFile,
          //         ),
          //   vSpace(15),
          //   testReportCard(
          //     "Genetic Testing",
          //     "Genetic testing examines an individual's DNA for alterations or variations that might indicate the presence of certain genetic conditions or traits",
          //     reportStatus: detail.geneticTestStatus ?? false,
          //     reportFile: detail.geneticTestReportFile,
          //   ),
          //   vSpace(15),
          // ]),
          ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  testReportCard(
    String title, {
    bool? reportStatus,
    bool isEnableButton = true,
    String? reportFile,
    String? subTitle,
    String? icon,
    int? reportTypeId,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.greyCardBorder)),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 10,
        leading: Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.lightPink),
            child: Custom.svgIconData(icon ?? AppSvgIcons.testTube, size: 25)),
        title: Row(children: [
          Expanded(
              child: Text(
            title,
            style: AppFontStyle.heading5.copyWith(fontWeight: FontWeight.w500),
          )),
          if (reportStatus != null) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.lightPink),
              child: Text(
                  (reportStatus ? "Tested" : "Not Tested").toUpperCase(),
                  style: AppFontStyle.blackRegular14pt
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
            ),
          ],
        ]),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (subTitle != null && subTitle.isNotEmpty)
              Text(subTitle, style: AppFontStyle.greyRegular14pt),
            // if (reportFile != null) ...[
            vSpace(10),
            InkWell(
              // onTap: isEnableButton
              //     ? () async {
              //         await showLoadingDialog();
              //         try {
              //           final user = await fetchUser(
              //             FirebaseChatCore.instance.getFirebaseFirestore(),
              //             detail.userId.toString(),
              //             FirebaseChatCore.instance.config.usersCollectionName,
              //           );
              //           var otherUser = types.User.fromJson(user);

              //           final room = await FirebaseChatCore.instance
              //               .createRoom(otherUser, createNewRoom: true);
              //           var parameters = {
              //             "RoomId": room?.id,
              //             "DonorUserId": int.parse(detail.userId.toString()),
              //             "MedicalReportIds": [reportTypeId],
              //             "IsExistReport": reportFile != null
              //           };

              //           await ChatApi()
              //               .medicalReportRequest(parameters, loader: false);
              //           await showAppToast("Submitted Successfully");
              //           await closeLoadingDialog();
              //         } catch (e) {
              //           await closeLoadingDialog();
              //           await showDialog(
              //             context: Get.context!,
              //             builder: (context) => AlertMsgDialog(
              //               title: "Warning",
              //               msg: e.toString(),
              //               primaryText: CustomText.ok,
              //               primaryBtnTap: () {
              //                 Get.back();
              //               },
              //             ),
              //           );
              //         }
              //       }
              //     : () {
              //         if (reportFile != null && reportFile.isNotEmpty) {
              //           Get.to(PDFViewerPage(url: reportFile, title: title));
              //         } else {
              //           Get.to(DonorEditProfile())?.then((value) {
              //             if (value['isUpdate']) {
              //               final cntrl = Get.find<DonorProfileController>(
              //                   tag: "profile");
              //               cntrl.getDonorProfileData();
              //             }
              //           });
              //         }
              //       },
              child: Text(
                isEnableButton
                    ? "Request report"
                    : (reportFile != null && reportFile.isNotEmpty)
                        ? "View report"
                        : "Not uploaded",
                style: AppFontStyle.greyRegular14pt.copyWith(
                    color: AppColors.primaryRed, fontWeight: FontWeight.w600),
              ),
            )
            // ],
          ]),
        ),
      ),
    );
  }
}
