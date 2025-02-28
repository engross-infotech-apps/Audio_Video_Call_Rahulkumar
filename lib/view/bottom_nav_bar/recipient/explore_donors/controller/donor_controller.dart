import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/helper/eye_colors.dart';
import 'package:gokidu_app_tour/core/helper/hair_colors.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/api_response.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/controller/recipient_nav_bar_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/recipient_list/Model/recipient_profile_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/rating_review/model/rating_review_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/recipient_profile/model/donor_preferences_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/donors_card_view.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/model/donor_profile_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/filter_appbar_view.dart';
import 'package:gokidu_app_tour/widgets/card_swiper/controller/card_swiper_controller.dart';

class DonorsListController extends GetxController {
  final CardSwiperController controller = CardSwiperController();

  var donorDetail = <DonorProfileDetail>[].obs;
  var donorCards = <DonorCardView>[].obs;
  var userImage = <UserImage>[].obs;
  var donorRatingsReviews = <Rating>[].obs;

  var donorProfileDetail = Rxn<DonorProfileDetail>();

  var hairColorsList = <LookupModelPO>[].obs;
  var selectedHairColor = Rxn<LookupModelPO>();

  var nationalityList = <LookupModelPO>[].obs;
  var selectedNationality = Rxn<LookupModelPO>();

  var educationList = <LookupModelPO>[].obs;
  var eyeColorsList = <LookupModelPO>[].obs;
  var professionList = <LookupModelPO>[].obs;
  var ethnicityList = <LookupModelPO>[].obs;
  var religiousList = <LookupModelPO>[].obs;

  var heightList = <LookupModelPO>[].obs;
  var ageList = <LookupModelPO>[].obs;
  var bloodGroupList = <LookupModelPO>[].obs;

  var filterHairColorList = <LookupModelPO>[];
  var filterEyeColorList = <LookupModelPO>[];
  var filterEthnicityList = <LookupModelPO>[];
  var filterProfessionList = <LookupModelPO>[];
  var filterHeightList = <LookupModelPO>[];
  var filterAgeList = <LookupModelPO>[];
  var filterBloodGroupList = <LookupModelPO>[];
  var filterReligionList = <LookupModelPO>[];
  var filterNationalityList = <LookupModelPO>[];
  var filterEducationalList = <LookupModelPO>[];
  var filterVerificationList = <LookupModelPO>[];

  var medicalReports = <OtherMedicalReport>[].obs;

  var eyeColors = "N/A".obs;
  var hairColors = "N/A".obs;
  var ethnicity = "N/A".obs;
  var nationality = "N/A".obs;
  var religion = "N/A".obs;
  var height = "N/A".obs;
  var profession = "N/A".obs;
  var education = "N/A".obs;

  TextEditingController searchCntrl = TextEditingController();
  TextEditingController ratingCntrl = TextEditingController();

  var pageNo = 1.obs;
  var pageSize = 3.obs;

  var rating = 0.0.obs;

  var filtration = 0.obs;
  var ageLength = 0.obs;
  var selectedCardIndex = 0.obs;

  var country = AppStorage.getUserData()?.countryId;
  var verification = Rxn<bool>();
  var stdTest = Rxn<bool>();
  var geneticTest = Rxn<bool>();
  var semenTest = Rxn<bool>();
  var loader = false.obs;

  var latitude;
  var longitude;
  var radius = Rxn<double>();

  late AnimationController animationController;
  Animation<Offset>? scaleAnimation;
  Animation<double>? fadeAnimation;

  List<dynamic> filterOptions = [
    'Verification',
    'Donor radius',
    'Hair color',
    'Eye color',
    'Blood group',
    'Profession',
    'Ethnicity',
    'Height',
    'Age',
    'Religion',
    'Nationality',
    'Educational level',
    // 'STD testing',
    // 'Semen testing',
    // 'Genetic testing',
  ];

  @override
  void onInit() async {
    super.onInit();
    await init();
  }

  init() async {
    loader.value = true;
    await getLookupData();
    // await getDonorPreferences();
    loader.value = await false;
  }

  getLookupData() async {
    AllLookUpModel? list;

    // var getApi = AppStorage.getLookupApi();

    // if (getApi.isNotEmpty) {
    //   var data = await jsonDecode(getApi);
    //   list = AllLookUpModel.fromMap(data);
    // } else {
    var response = await ResponseWrapper.init(
        create: () =>
            APIResponse<AllLookUpModel>(create: () => AllLookUpModel()),
        data: await DefaultAssetBundle.of(
                NavigationService.navigatorKey.currentContext!)
            .loadString("assets/json/all_lookup.json"));

    list = response.response.data;
    // }

    if (list != null) {
      for (var data in HairColorsHelper.getHairColors()) {
        hairColorsList.add(data.modelPO!);
      }

      for (var data in EyeColorHelper.getEyeColors()) {
        eyeColorsList.add(data.modelPO!);
      }

      for (var data in list.profession!) {
        professionList.add(data.modelPO!);
      }

      for (var data in list.ethnicity!) {
        ethnicityList.add(data.modelPO!);
      }
      ethnicityList.insert(
        ethnicityList.length,
        LookupModelPO(id: null, name: "Other"),
      );

      for (var data in list.country!) {
        nationalityList.add(data.modelPO!);
      }
      for (var data in list.religious!) {
        religiousList.add(data.modelPO!);
      }
      religiousList.insert(
        religiousList.length,
        LookupModelPO(id: null, name: "Other"),
      );

      for (var data in list.education!) {
        educationList.add(data.modelPO!);
      }

      for (var data in list.height!) {
        heightList
            .add(LookupModelPO(id: data.heightId, name: data.heightRange!));
      }

      for (var data in list.age!) {
        ageList.add(data.modelPO!);
      }

      for (var data in list.bloodGroup!) {
        bloodGroupList.add(data.modelPO!);
      }
    }
  }

  getDonorPreferences() async {
    final bottomBarCntrl =
        Get.find<RecipientBottomBarController>(tag: "bottombar");

    RecipientProfile? profileData;
    try {
      RecipientProfileModel? data;

      // data = await RecipientApi().recipientProfile();
      profileData = data?.recipientProfile;
      if (profileData != null) {
        pageNo.value = 1;
        filterHairColorList.clear();
        filterEyeColorList.clear();
        filterBloodGroupList.clear();
        filterProfessionList.clear();
        filterEthnicityList.clear();
        filterHeightList.clear();
        filterAgeList.clear();
        filterReligionList.clear();
        filterNationalityList.clear();
        filterEducationalList.clear();
        filterVerificationList.clear();
        radius.value = null;
        latitude = null;
        longitude = null;
        eyeColors.value = profileData.eyeColorIds ?? "N/A";
        hairColors.value = profileData.hairColorIds ?? "N/A";
        ethnicity.value = profileData.ethnicityIds ?? "N/A";
        nationality.value = profileData.preferredNationalities ?? "N/A";
        height.value = profileData.preferredHeights ?? "N/A";
        religion.value = profileData.religiousIds ?? "N/A";
        profession.value = profileData.professionIds ?? "N/A";
        education.value = profileData.educationIds ?? "N/A";
        // religion.value =
        latitude = profileData.latitude != null &&
                (profileData.latitude)!.toLowerCase() != "null"
            ? double.parse(profileData.latitude!)
            : null;
        longitude = profileData.longitude != null &&
                (profileData.longitude)!.toLowerCase() != "null"
            ? double.parse(profileData.longitude!)
            : null;
        radius.value = profileData.donorRadiusinMile?.toDouble() ?? null;
        if (country != null && country == 2 && radius.value != null) {
          radius.value = (radius.value! * 1.609344).roundToDouble();
        }
      }
    } catch (e) {
      debugPrint("----ee--$e");
    }
    if (profileData != null) {
      if (profileData.eyeColorIds != null &&
          profileData.eyeColorIds!.isNotEmpty) {
        filterEyeColorList
            .addAll(getStringList(eyeColors.value, eyeColorsList));
      }

      if (profileData.hairColorIds != null &&
          profileData.hairColorIds!.isNotEmpty) {
        filterHairColorList
            .addAll(getStringList(hairColors.value, hairColorsList));
      }

      if (profileData.ethnicityIds != null &&
          profileData.ethnicityIds!.isNotEmpty) {
        filterEthnicityList
            .addAll(getStringList(ethnicity.value, ethnicityList));
      }

      if (profileData.religiousIds != null &&
          profileData.religiousIds!.isNotEmpty) {
        filterReligionList.addAll(getStringList(religion.value, religiousList));
      }

      if (profileData.preferredNationalities != null &&
          profileData.preferredNationalities!.isNotEmpty) {
        filterNationalityList
            .addAll(getStringList(nationality.value, nationalityList));
      }

      if (profileData.preferredHeights != null &&
          profileData.preferredHeights!.isNotEmpty) {
        filterHeightList.addAll(getStringList(height.value, heightList));
      }

      if (profileData.professionIds != null &&
          profileData.professionIds!.isNotEmpty) {
        filterProfessionList
            .addAll(getStringList(profession.value, professionList));
      }

      if (profileData.educationIds != null &&
          profileData.educationIds!.isNotEmpty) {
        filterEducationalList
            .addAll(getStringList(education.value, educationList));
      }
    }
    bottomBarCntrl.appBarView[2] = {
      "title": "Donors",
      "svg": AppBarIconButton(
        text: "Preferences (${applyFilterCount()})",
        icon: AppSvgIcons.filter,
      ),
    };
  }

  getStringList(String str, List<LookupModelPO> select) {
    List<int> list = [];
    List<String> displayName = [];
    List<LookupModelPO> selectedList = [];

    list = str.split(',').map((e) => int.parse(e)).toList();
    for (var element in list) {
      for (LookupModelPO item in select) {
        if (item.id == element) {
          item.isSelected = true;
          selectedList.add(item);
          displayName.add(item.name);

          break;
        }
      }
    }
    return selectedList;
  }

  getDonorList({bool loader = false}) async {
    showLoadingDialog();
    Map parameter = {
      "PageNumber": pageNo.value,
      "PageSize": 10,
      
      "VerificationStatus": filterVerificationList.isNotEmpty &&
              filterVerificationList.length != 2
          ? filterVerificationList[0].id == 1
              ? true
              : false
          : null,
      "HairColorIds": filterHairColorList.map((e) => e.id).toList(),
      "EyeColorIds": filterEyeColorList.map((e) => e.id).toList(),
      "BloodGroups": filterBloodGroupList.map((e) => e.name).toList(),
      "ProfessionIds": filterProfessionList.map((e) => e.id).toList(),
      "EthnicityIds": filterEthnicityList.map((e) => e.id).toList(),
      "HeightRangeIds": filterHeightList.map((e) => e.id).toList(),
      "AgeRangeIds": filterAgeList.map((e) => e.id).toList(),
      "ReligiousIds": filterReligionList.map((e) => e.id).toList(),
      "NationalityIds": filterNationalityList.map((e) => e.id).toList(),
      "EducationIds": filterEducationalList.map((e) => e.id).toList(),
      "Radius": radius.value
    };

    try {
      // recipient_list
      var response = await ResponseWrapper.init(
          create: () => APIListResponse<DonorProfileDetail>(
              create: () => DonorProfileDetail()),
          data: await DefaultAssetBundle.of(
                  NavigationService.navigatorKey.currentContext!)
              .loadString("assets/json/recipient_list.json"));

      var list = response.response.data;
      await Future.delayed(
        Duration(seconds: 1),
        () {
          closeLoadingDialog();
        },
      );
      // var list =
      //     await RecipientApi().donorsWithFilter(parameter, loader: loader);
      if (list.isNotEmpty) {
        for (var data in list) {
          if (data.userImage != null &&
              data.userImage!.isNotEmpty &&
              !(data.userImage!.contains(data.profilePicture))) {
            data.profilePicture != null
                ? data.userImage?.insert(0, data.profilePicture!)
                : null;
          }
          donorDetail.add(data);
          donorCards.add(DonorCardView(data));
        }
      }
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

  // getDonorDetails(String id) async {
  //   donorProfileDetail.value = null;
  //   userImage.clear();
  //   donorRatingsReviews.clear();
  //   medicalReports.clear();
  //   try {
  //     var data = await RecipientApi().getDonorDetailsById(
  //         id, LastActivity.recipientExploreGetDonor.number.toString());
  //     if (data != null) {
  //       donorProfileDetail.value = data.donorProfileDetail;
  //       if (data.userImage != null && data.userImage!.isNotEmpty)
  //         userImage.addAll(data.userImage!);
  //       if (data.donorProfileDetail?.profilePicture != null) {
  //         userImage.insert(
  //             0, UserImage(imageName: data.donorProfileDetail?.profilePicture));
  //       }
  //       if (data.otherMedicalReport != null &&
  //           data.otherMedicalReport!.isNotEmpty) {
  //         medicalReports.addAll(data.otherMedicalReport ?? []);
  //       }

  //       donorRatingsReviews.value = data.donorRatingsReviews!;
  //     }
  //   } catch (e) {
  //     await showDialog(
  //       context: Get.context!,
  //       builder: (context) => AlertMsgDialog(
  //           title: "Error",
  //           msg: e.toString(),
  //           secondaryText: "Close",
  //           image: AppSvgIcons.report,
  //           secondaryBtnTap: () {
  //             Navigator.pop(context);
  //           }),
  //     );
  //   }

  //   if (donorProfileDetail.value?.hairColorId != null) {
  //     selectedHairColor.value = hairColorsList.firstWhere(
  //         (element) => element.id == donorProfileDetail.value?.hairColorId);
  //   }

  //   if (donorProfileDetail.value?.countryId != null) {
  //     selectedNationality.value = nationalityList.firstWhere(
  //         (element) => element.id == donorProfileDetail.value?.countryId);
  //   }
  // }

  // addRateReview(String comment) async {
  //   Map parameter = {
  //     "UserId": donorProfileDetail.value?.userId,
  //     "Ratings": rating.value,
  //     "Comment": comment.trim(),
  //   };
  //   try {
  //     await UserApi().rateReview(parameter);
  //     Get.back();
  //     showAppToast("Your review successfully posted");
  //     await getDonorDetails(donorProfileDetail.value!.userId.toString());
  //   } catch (e) {
  //     await showDialog(
  //       context: Get.context!,
  //       builder: (context) => AlertMsgDialog(
  //           title: "Error",
  //           msg: e.toString(),
  //           secondaryText: "Close",
  //           image: AppSvgIcons.report,
  //           secondaryBtnTap: () {
  //             Navigator.pop(context);
  //           }),
  //     );
  //   }
  // }

  ///------------------remove------------

  Future<void> playAnimation() async {
    try {
      // if (scaleAnimation == null || fadeAnimation == null) {
      await animationController.forward().orCancel;
      animationController.reset();
      // }
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  successAction() async {
    // if (action == UserActions.like || action == UserActions.dislike) {

    if (selectedCardIndex.value == donorCards.length - 3) {
      pageNo++;
      await getDonorList();
      donorCards.removeAt(selectedCardIndex.value);
    } else if (selectedCardIndex.value == donorCards.length - 1) {
      controller.moveTo(0);
      donorCards.removeAt(selectedCardIndex.value);
      selectedCardIndex.value = 0;
    } else {
      donorCards.removeAt(selectedCardIndex.value);
    }
    // } else if (action == UserActions.maybe) {
    //   donor.isBookmark = !(donor.isBookmark ?? false);
    // }
  }

  // Future<bool?> actionDonor(int? userId, UserActions action,
  //     {bool isDetailsPage = false}) async {
  //   final RecipientBottomBarController bottomNavCtrl =
  //       Get.find<RecipientBottomBarController>(tag: "bottombar");
  //   var performingAction = AppStorage.getPerformingAction();

  //   try {
  //     // var res;
  //     var res = await UserApi().doAction(int.parse(userId.toString()), action);

  //     if (performingAction == null && !(performingAction ?? false)) {
  //       await showDialog(
  //         context: Get.context!,
  //         builder: (context) => AlertMsgDialog(
  //           title: "Added to the ${action.value} list.",
  //           msg: "",
  //           // "Click ${CustomText.ok.toLowerCase()} to view all your actions.",
  //           primaryText: "${CustomText.ok}",
  //           primaryBtnTap: () async {
  //             bottomNavCtrl.selectedIndex.value = 3;
  //             bottomNavCtrl.selectedAction.value = action;
  //             Get.back();
  //             if (isDetailsPage) {
  //               Get.back(result: {
  //                 "isLiked": donorProfileDetail.value?.isLiked,
  //                 "isBookmark": donorProfileDetail.value?.isBookmark,
  //                 "isDislike": donorProfileDetail.value?.isDisLiked,
  //               });
  //             }
  //             await AppStorage.appStorage
  //                 .write(AppStorage.performingAction, true);
  //           },
  //           /* secondaryText: "Close",
  //             secondaryBtnTap: () {
  //             Get.back();
  //           }*/
  //           image: AppSvgIcons.heartFill,
  //           imgColor: AppColors.primaryRed,
  //         ),
  //       );
  //     }

  //     if (res != null && res && !isDetailsPage) {
  //       playAnimation();
  //       // controller.swipe(CardSwiperDirection.top);
  //       await Future.delayed(Duration.zero, () async {
  //         await successAction();
  //         // controller.undo();
  //       });
  //     }
  //     return res;
  //   } catch (e) {
  //     debugPrint("---error---$e");
  //   }
  //   return null;
  // }

  ///------------------filter----------------

  int applyFilterCount() {
    int count = 0;
    if (filterVerificationList.isNotEmpty) count++;
    if (filterHairColorList.isNotEmpty) count++;
    if (filterEyeColorList.isNotEmpty) count++;
    if (filterBloodGroupList.isNotEmpty) count++;
    if (filterProfessionList.isNotEmpty) count++;
    if (filterEthnicityList.isNotEmpty) count++;
    if (filterHeightList.isNotEmpty) count++;
    if (filterAgeList.isNotEmpty) count++;
    if (filterReligionList.isNotEmpty) count++;
    if (filterNationalityList.isNotEmpty) count++;
    if (filterEducationalList.isNotEmpty) count++;
    if (radius.value != null && latitude != null && longitude != null) count++;
    return count;
  }

  clearFilter() async {
    final bottomBarCntrl =
        Get.find<RecipientBottomBarController>(tag: "bottombar");
    // showLoadingDialog();

    pageNo.value = 1;
    filterHairColorList.clear();
    filterEyeColorList.clear();
    filterBloodGroupList.clear();
    filterProfessionList.clear();
    filterEthnicityList.clear();
    filterHeightList.clear();
    filterAgeList.clear();
    filterReligionList.clear();
    filterNationalityList.clear();
    filterEducationalList.clear();
    filterVerificationList.clear();
    radius.value = null;
    latitude = null;
    longitude = null;

    bottomBarCntrl.appBarView[2] = {
      "title": "Donors",
      "svg": AppBarIconButton(
        text: "Preferences (${applyFilterCount()})",
        icon: AppSvgIcons.filter,
      ),
    };
    await getDonorList();
    await closeLoadingDialog();
    Get.back();
  }

  submit(
      hairColorSelectedList,
      eyeColorSelectedList,
      bloodGroupSelectedList,
      professionSelectedList,
      ethnicitySelectedList,
      heightSelectedList,
      ageSelectedList,
      religionSelectedList,
      nationalitySelectedList,
      educationalSelectedList,
      verificationSelectedList,
      stdTestStatus,
      lat,
      long,
      radius,
      VoidCallback callback) async {
    pageNo.value = 1;

    // showLoadingDialog();

    donorDetail.clear();
    donorCards.clear();

    filterVerificationList.clear();
    filterHairColorList.clear();
    filterEyeColorList.clear();
    filterBloodGroupList.clear();
    filterProfessionList.clear();
    filterEthnicityList.clear();
    filterHeightList.clear();
    filterAgeList.clear();
    filterReligionList.clear();
    filterNationalityList.clear();
    filterEducationalList.clear();
    this.radius.value = null;
    latitude = null;
    longitude = null;

    filterHairColorList = hairColorSelectedList;
    filterEyeColorList = eyeColorSelectedList;
    filterBloodGroupList = bloodGroupSelectedList;
    filterProfessionList = professionSelectedList;
    filterEthnicityList = ethnicitySelectedList;
    filterHeightList = heightSelectedList;
    filterAgeList = ageSelectedList;
    filterReligionList = religionSelectedList;
    filterNationalityList = nationalitySelectedList;
    filterEducationalList = educationalSelectedList;
    latitude = lat;
    longitude = long;
    this.radius.value = radius;

    filterVerificationList = verificationSelectedList;
    stdTest.value = stdTestStatus;

    // await getDonorList();
    // await closeLoadingDialog();

    callback();

    Get.back();
  }
}
