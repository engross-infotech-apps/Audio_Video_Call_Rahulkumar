import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/controller/recipient_nav_bar_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/controller/donor_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/filter_screen/widget/blood_group.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/filter_screen/widget/hair_color_option.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/filter_screen/widget/profession_view.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/filter_appbar_view.dart';
import '../widget/age_option.dart';
import '../widget/education_option.dart';
import '../widget/ethnicity_option.dart';
import '../widget/eye_color_option.dart';
import '../widget/height_option.dart';
import '../widget/nationality_option.dart';
import '../widget/religion_option.dart';
import '../widget/verification_option.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});
  @override
  State<FilterPage> createState() => FilterPageState();
}

class FilterPageState extends State<FilterPage> {
  final filterCtrl = Get.find<DonorsListController>(tag: "exploreDonor");
  final ScrollController scrollCtrl = ScrollController();

  var verificationSelectedList = <LookupModelPO>[];
  var hairColorSelectedList = <LookupModelPO>[];
  var eyeColorSelectedList = <LookupModelPO>[];
  var ethnicitySelectedList = <LookupModelPO>[];
  var professionSelectedList = <LookupModelPO>[];
  var heightSelectedList = <LookupModelPO>[];
  var ageSelectedList = <LookupModelPO>[];
  var bloodSelectedList = <LookupModelPO>[];
  var religionSelectedList = <LookupModelPO>[];
  var nationalitySelectedList = <LookupModelPO>[];
  var educationalSelectedList = <LookupModelPO>[];
  var verificationData = <LookupModelPO>[];
  var hairColorData = <LookupModelPO>[];
  var eyeColorData = <LookupModelPO>[];
  var ethnicityData = <LookupModelPO>[];
  var professionData = <LookupModelPO>[];
  var heightData = <LookupModelPO>[];
  var ageData = <LookupModelPO>[];
  var bloodGroupData = <LookupModelPO>[];
  var religionData = <LookupModelPO>[];
  var nationalityData = <LookupModelPO>[];
  var educationalData = <LookupModelPO>[];

  var latitude;
  var longitude;
  var radius = Rxn<double>();

  bool? verification;
  var stdTest = true;
  var geneticTest = true;
  var semenTest = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    filterCtrl.filtration.value = 0;
    verification = filterCtrl.verification.value;
    stdTest = filterCtrl.stdTest.value ?? true;
    geneticTest = filterCtrl.stdTest.value ?? true;
    semenTest = filterCtrl.semenTest.value ?? true;

    verificationData.clear();
    hairColorData.clear();
    eyeColorData.clear();
    bloodGroupData.clear();
    professionData.clear();
    ethnicityData.clear();
    ageData.clear();
    religionData.clear();
    educationalData.clear();
    nationalityData.clear();
    latitude = null;
    longitude = null;
    radius.value = null;

    hairColorData = filterCtrl.hairColorsList;
    eyeColorData = filterCtrl.eyeColorsList;
    professionData = filterCtrl.professionList;
    ethnicityData = filterCtrl.ethnicityList;
    heightData = filterCtrl.heightList;
    ageData = filterCtrl.ageList;
    bloodGroupData = filterCtrl.bloodGroupList;
    religionData = filterCtrl.religiousList;
    nationalityData = filterCtrl.nationalityList;
    educationalData = filterCtrl.educationList;
    latitude = filterCtrl.latitude;
    longitude = filterCtrl.longitude;
    radius.value = filterCtrl.radius.value;

    verificationSelectedList.addAll(filterCtrl.filterVerificationList);
    hairColorSelectedList.addAll(filterCtrl.filterHairColorList);
    eyeColorSelectedList.addAll(filterCtrl.filterEyeColorList);
    ethnicitySelectedList.addAll(filterCtrl.filterEthnicityList);
    professionSelectedList.addAll(filterCtrl.filterProfessionList);
    heightSelectedList.addAll(filterCtrl.filterHeightList);
    ageSelectedList.addAll(filterCtrl.filterAgeList);
    bloodSelectedList.addAll(filterCtrl.filterBloodGroupList);
    religionSelectedList.addAll(filterCtrl.filterReligionList);
    nationalitySelectedList.addAll(filterCtrl.filterNationalityList);
    educationalSelectedList.addAll(filterCtrl.filterEducationalList);
  }

  // scrollListener() {
  //   if (scrollCtrl.offset >= scrollCtrl.position.maxScrollExtent * 0.99) {
  //     // isRead.value = true;
  //   }
  // }

  Widget headingBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column
        Row(
          children: [
            Custom.svgIconData(AppSvgIcons.filter),
            hSpace(10),
            Text(
              'Preferences',
              style: AppFontStyle.heading4,
            ),
          ],
        ),
        // -----------------------Reset filter-----------------
        /*
           GestureDetector(
          onTap: () async {
            filterCtrl.donorDetail.clear();
            filterCtrl.donorCards.clear();
            showLoadingDialog();
            await filterCtrl.getDonorPreferences();
            await filterCtrl.getDonorList(loader: false);
            await closeLoadingDialog();
            Get.back();
            setState(() {});
          },
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 20),
            constraints: BoxConstraints(maxWidth: AppScreenSize.width * 0.20),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.lightPink),
            child: Text("Reset",
                style: AppFontStyle.blackRegular14pt
                    .copyWith(fontWeight: FontWeight.w600)),
          ),
        ),*/
        //-----------------------------------------------------
      ],
    );
  }

  Widget filterBody() {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.35;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: cardWidth,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.circular(15),
            ),
            child: RawScrollbar(
              thumbColor: AppColors.greyBorder,
              controller: scrollCtrl,
              thumbVisibility: true,
              thickness: 5,
              mainAxisMargin: 10,
              minThumbLength: 10,
              radius: Radius.circular(100),
              child: ListView.builder(
                  controller: scrollCtrl,
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filterCtrl.filterOptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {
                        if (index == 1) {
                          // showLookupBottomSheet(
                          //   enableDrag: false,
                          //   child: RangeFilterBottomSheet(
                          //     latitudeDefault: latitude,
                          //     longitudeDefault: longitude,
                          //     radius: radius.value,
                          //     headingFont: AppFontStyle.heading4,
                          //     // initialCameraPosition: CameraPosition(
                          //     //   target: LatLng(
                          //     //       latitude ?? 43.0828, longitude ?? -79.0742),
                          //     // ),
                          //     onTap: (v, r) {
                          //       radius.value = r;
                          //       latitude = v.latitude;
                          //       longitude = v.longitude;
                          //       setState(() {});
                          //     },
                          //   ),
                          // );
                        } else {
                          filterCtrl.filtration.value = index;
                        }
                        setState(() {});
                      },
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: optionTexts(
                            filterCtrl.filterOptions[index] +
                                (applyFilter(index) ? " •" : ""),
                            filterCtrl.filtration.value == index
                                ? AppColors.primaryRed
                                : applyFilter(index)
                                    ? AppColors.black
                                    : AppColors.greyText,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 10, left: 10),
              // decoration: const BoxDecoration(color: Colors.pink),
              child: optionBody(),
            ),
          )
        ]);
  }

  applyFilter(index) {
    switch (index) {
      case 0:
        return verificationSelectedList.isNotEmpty;
      case 1:
        return latitude != null && longitude != null && radius.value != null;
      case 2:
        return hairColorSelectedList.isNotEmpty;
      case 3:
        return eyeColorSelectedList.isNotEmpty;
      case 4:
        return bloodSelectedList.isNotEmpty;
      case 5:
        return professionSelectedList.isNotEmpty;
      case 6:
        return ethnicitySelectedList.isNotEmpty;
      case 7:
        return heightSelectedList.isNotEmpty;
      case 8:
        return ageSelectedList.isNotEmpty;
      case 9:
        return religionSelectedList.isNotEmpty;
      case 10:
        return nationalitySelectedList.isNotEmpty;
      case 11:
        return educationalSelectedList.isNotEmpty;
    }
  }

  optionBody() {
    switch (filterCtrl.filtration.value) {
      case 0:
        return VerificationOption(
          status: verification,
          list: verificationSelectedList,
          onTap: (v) {
            // verification = v;
            verificationSelectedList = v;
          },
        );

      case 2:
        return HairColorView(
          list: hairColorSelectedList,
          lookupList: hairColorData,
          title: 'Hair Color',
          onTap: (v) {
            hairColorSelectedList = v;
          },
        );

      case 3:
        return EyeColorView(
          list: eyeColorSelectedList,
          lookupList: eyeColorData,
          title: 'Eye Color',
          onTap: (v) {
            eyeColorSelectedList = v;
          },
        );

      case 4:
        return BloodGroupView(
          list: bloodSelectedList,
          lookupList: bloodGroupData,
          onTap: (v) {
            bloodSelectedList = v;
          },
          title: 'Blood Group',
        );

      case 5:
        return ProfessionView(
          list: professionSelectedList,
          lookupList: professionData,
          title: 'Profession',
          onTap: (v) {
            professionSelectedList = v;
          },
        );

      case 6:
        return EthnicityView(
          list: ethnicitySelectedList,
          lookupList: ethnicityData,
          title: 'Ethnicity',
          onTap: (v) {
            ethnicitySelectedList = v;
          },
        );

      case 7:
        return HeightView(
          list: heightSelectedList,
          lookupList: heightData,
          onTap: (v) {
            heightSelectedList = v;
          },
          title: 'Height',
        );

      case 8:
        return AgeView(
          list: ageSelectedList,
          lookupList: ageData,
          onTap: (v) {
            ageSelectedList = v;
          },
          title: 'Age',
        );

      case 9:
        return ReligionView(
          list: religionSelectedList,
          lookupList: religionData,
          title: 'Religion',
          onTap: (v) {
            religionSelectedList = v;
          },
        );

      case 10:
        {
          List<LookupModelPO> searchList = [];
          searchList.addAll(nationalityData);

          return NationalityView(
            list: nationalitySelectedList,
            lookupList: nationalityData,
            onTap: (v) {
              nationalitySelectedList = v;
            },
            searchList: searchList,
            searchable: true,
            title: 'Nationality',
          );
        }
      case 11:
        {
          return EducationView(
            lookupList: educationalData,
            list: educationalSelectedList,
            title: 'Education Level',
            onTap: (v1) {
              educationalSelectedList = v1;
            },
          );
        }

      // case 9:
      //   return StdTestingOption(
      //     status: stdTest,
      //     title: "STD",
      //     onTap: (v) {
      //       stdTest = v;
      //     },
      //   );
      // case 10:
      //   return StdTestingOption(
      //     status: semenTest,
      //     title: "Semen",
      //     onTap: (v) {
      //       semenTest = v;
      //     },
      //   );

      // case 11:
      //   return StdTestingOption(
      //     status: geneticTest,
      //     title: "Genetic",
      //     onTap: (v) {
      //       geneticTest = v;
      //     },
      //   );
    }
    setState(() {});
  }

  optionTexts(option, color) {
    return Text(
      '$option',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: color,
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        constraints: BoxConstraints(maxHeight: AppScreenSize.height / 1.2),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          headingBar(),
          vSpace(20),
          Expanded(child: filterBody()),
          vSpace(20),
          CustomPrimaryButton(
            textValue: 'Apply preferences',
            textColor: AppColors.white,
            textSize: 16,
            callback: () {
              final bottomBarCntrl =
                  Get.find<RecipientBottomBarController>(tag: "bottombar");
              filterCtrl.submit(
                  hairColorSelectedList,
                  eyeColorSelectedList,
                  bloodSelectedList,
                  professionSelectedList,
                  ethnicitySelectedList,
                  heightSelectedList,
                  ageSelectedList,
                  religionSelectedList,
                  nationalitySelectedList,
                  educationalSelectedList,
                  verificationSelectedList,
                  stdTest,
                  latitude,
                  longitude,
                  radius.value, () {
                var count = filterCtrl.applyFilterCount();
                bottomBarCntrl.appBarView[2]['svg'] = AppBarIconButton(
                  text: "Preferences ($count)",
                  icon: AppSvgIcons.filter,
                );
                bottomBarCntrl.filterCount.value = count;
                setState(() {});
              });
              setState(() {});
            },
          ),
          vSpace(5),
          CustomPrimaryButton(
            textValue: "Clear preferences",
            buttonColor: AppColors.lightPink1,
            textColor: AppColors.black,
            callback: () {
              filterCtrl.clearFilter();
              setState(() {});
            },
          ),
          vSpace(10),
        ]),
      ),
    );
  }
}
