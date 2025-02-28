import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/helper/date_format.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/helper/eye_colors.dart';
import 'package:gokidu_app_tour/core/helper/hair_colors.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/api_response.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/home/models/home_model.dart';
import 'package:gokidu_app_tour/view/onboarding/models/image_models.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/model/donor_profile_model.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_controller.dart';

class DonorProfileController extends GetxController {
  GlobalKey<FormState> emailValidateKey = GlobalKey<FormState>();
  GlobalKey<FormState> codeValidateKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordValidateKey = GlobalKey<FormState>();
  final idCountryKey = GlobalKey<FormState>();
  var isAnonymous = false.obs;

  CameraController? controller;

  var pwdHide = true.obs;
  var newPwdHide = true.obs;
  var currentPwdHide = true.obs;

  var pwdPattern = false.obs;
  var pwd8Char = false.obs;
  var resendOtp = false.obs;
  var isDisplayNameExists = false.obs;
  var imgNotSelected = true.obs;
  var cameraOpen = false.obs;
  var isUpdate = false.obs;

  var timer = CountdownController(autoStart: true).obs;

  final f = DateFormat('dd/MM/yyyy');

  var filtration = 0.obs;
  var varified = false;
  var ageLenght = 0.obs;

  var verification = true.obs;
  var stdTest = true.obs;
  var isappyed = false.obs;

  var profileImg = Rxn<File?>();
  var finalProfileImg = Rxn<String>();

  var frontIdImg = Rxn<PlatformFile?>();
  var frontIdImgUrl = Rxn<String>();

  var backIdImg = Rxn<PlatformFile?>();
  var backIdImgUrl = Rxn<String>();

  var verifyImg = Rxn<File?>();
  var verifyImgUrl = Rxn<String>();

  var userData = Rxn<UserModel>();
  var donorProfileDetail = Rxn<DonorProfileDetail>();

  var userImage = <UserImage>[].obs;
  var donorOtherReport = <OtherMedicalReport>[].obs;

  var geneticReport = Rxn<OtherMedicalReport>();
  var semenReport = Rxn<OtherMedicalReport>();
  var stdReport = Rxn<OtherMedicalReport>();

  var preCacheimageList = <NetworkImage>[].obs;

  var deleteImgId = <String>[].obs;

  var deleteStdReport = Rxn<String>();
  var addStdReport = Rxn<String>();
  var stdFileName = Rxn<String>();

  var deleteSemenReport = Rxn<String>();
  var addSemenReport = Rxn<String>();
  var semenFileName = Rxn<String>();

  var deleteGeneticReport = Rxn<String>();
  var addGeneticReport = Rxn<String>();
  var geneticFileName = Rxn<String>();

  var hairColorsList = <LookupModelPO>[].obs;
  var selectedEyeColor = Rxn<LookupModelPO>();

  var eyeColorsList = <LookupModelPO>[].obs;
  var selectedHairColor = Rxn<LookupModelPO>();

  var ethnicityList = <LookupModelPO>[].obs;
  var selectedEthnicity = Rxn<LookupModelPO>();

  var nationalityList = <LookupModelPO>[].obs;
  var selectedNationality = Rxn<LookupModelPO>();
  var selectedCountry = Rxn<LookupModelPO>();

  var religiousList = <LookupModelPO>[].obs;
  var selectedReligious = Rxn<LookupModelPO>();

  var educationList = <LookupModelPO>[].obs;
  var selectedEducation = Rxn<LookupModelPO>();

  var professionList = <LookupModelPO>[].obs;
  var selectedProfession = Rxn<LookupModelPO>();

  var bloodList = <LookupModelPO>[].obs;
  var selectedBloodGroup = Rxn<LookupModelPO>();

  var documentList = <LookupModelPO>[].obs;
  var selectedDocumentType = Rxn<LookupModelPO>();

  var heightList = <LookupModelPO>[].obs;
  var ageList = <LookupModelPO>[].obs;

  var otherReportList = <LookupModelPO>[].obs;
  var selectedReportList = <LookupModelPO>[].obs;
  var otherReport = Rxn<LookupModelPO>();
  var errorMsg = "".obs;

  var displayName = TextEditingController().obs;
  var fullName = TextEditingController().obs;

  var birthDate = TextEditingController().obs;
  var bio = TextEditingController().obs;
  var userAddress = TextEditingController(text: "").obs;
  var latitude = "".obs;
  var longitude = "".obs;
  var height = TextEditingController().obs;
  var currentOccupation = TextEditingController().obs;
  var otherEthnicity = TextEditingController().obs;
  var otherReligiousCntrl = TextEditingController().obs;

  var emailCntrl = TextEditingController();
  var otpCntrl = TextEditingController();
  var currentPasswordCntrl = TextEditingController();
  var passwordCntrl = TextEditingController();
  var retypePasswordCntrl = TextEditingController();
  var documentTypeCntrl = TextEditingController();
  var idCountryCntrl = TextEditingController();
  var otherReportCntrl = TextEditingController();

//otherReportCntrl
  var pickedImages = <PickedImageModel>[
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
  ].obs;

  List<String> extensionsForReport = ['pdf', 'PDF'];
  List<String> allowedExtensions = ['jpeg', 'pdf', 'png', 'jpg', 'heif'];

  @override
  void onInit() {
    super.onInit();
    // init();
  }

  init() async {
    await Future.delayed(Duration.zero);
    await showLoadingDialog();
    await getLookupData();
    await getDonorProfileData();
    await Future.delayed(
      Duration(seconds: 1),
      () {
        closeLoadingDialog();
      },
    );
  }

  getLookupData() async {
    AllLookUpModel? list;

    var response = await ResponseWrapper.init(
        create: () =>
            APIResponse<AllLookUpModel>(create: () => AllLookUpModel()),
        data: await DefaultAssetBundle.of(
                NavigationService.navigatorKey.currentContext!)
            .loadString("assets/json/all_lookup.json"));

    list = response.response.data;

    if (list != null) {
      for (var data in HairColorsHelper.getHairColors()) {
        hairColorsList.add(data.modelPO!);
      }

      for (var data in EyeColorHelper.getEyeColors()) {
        eyeColorsList.add(data.modelPO!);
      }

      for (var data in list.ethnicity!) {
        ethnicityList.add(data.modelPO!);
      }
      ethnicityList.insert(
          ethnicityList.length, LookupModelPO(id: null, name: "Other"));

      for (var data in list.country!) {
        nationalityList.add(data.modelPO!);
      }
      for (var data in list.religious!) {
        religiousList.add(data.modelPO!);
      }
      religiousList.insert(
          religiousList.length, LookupModelPO(id: null, name: "Other"));

      for (var data in list.bloodGroup!) {
        bloodList.add(data.modelPO!);
      }

      for (var data in list.education!) {
        educationList.add(data.modelPO!);
      }

      for (var data in list.profession!) {
        professionList.add(data.modelPO!);
      }

      for (var data in list.medicalReportType!) {
        otherReportList.add(data.modelPO!);
      }
    }
  }

  addInitialValue() async {
    displayName.value.text = donorProfileDetail.value?.displayName ?? "";
    isAnonymous.value = displayName.value.text.isNotEmpty;
    bio.value.text = donorProfileDetail.value?.aboutMe ?? "";
    fullName.value.text = donorProfileDetail.value?.fullName ?? "";

    userAddress.value.text = donorProfileDetail.value?.address ?? "";
    latitude.value = donorProfileDetail.value?.latitude ?? "";
    longitude.value = donorProfileDetail.value?.longitude ?? "";
    height.value.text = donorProfileDetail.value?.height != null
        ? donorProfileDetail.value?.height.toString() ?? ""
        : "";
    // currentOccupation.value.text =
    //     donorProfileDetail.value?.professionName ?? "";

    if (donorProfileDetail.value?.dob != null) {
      var picked =
          parseDate("yyyy-MM-dd", donorProfileDetail.value!.dob!).toLocal();
      var date = formatDate("dd/MM/yyyy", picked);
      birthDate.value.text = date;
    }

    if (donorProfileDetail.value?.hairColorId != null) {
      selectedHairColor.value = hairColorsList.firstWhere(
          (element) => element.id == donorProfileDetail.value?.hairColorId);
    }
    if (donorProfileDetail.value?.eyeColorId != null) {
      selectedEyeColor.value = eyeColorsList.firstWhere(
          (element) => element.id == donorProfileDetail.value?.eyeColorId);
    }
    if (donorProfileDetail.value?.ethnicityId != null) {
      selectedEthnicity.value = ethnicityList.firstWhere(
          (element) => element.id == donorProfileDetail.value?.ethnicityId);
    }
    if (donorProfileDetail.value?.nationalityId != null) {
      selectedNationality.value = nationalityList.firstWhereOrNull(
          (element) => element.id == donorProfileDetail.value?.nationalityId);
    }
    if (donorProfileDetail.value?.countryId != null) {
      selectedCountry.value = nationalityList.firstWhereOrNull(
          (element) => element.id == donorProfileDetail.value?.countryId);
    }
    idCountryCntrl.text = selectedCountry.value?.name ?? "";

    if (donorProfileDetail.value?.religiousId != null) {
      selectedReligious.value = religiousList.firstWhereOrNull(
          (element) => element.id == donorProfileDetail.value?.religiousId);
    }
    if (donorProfileDetail.value?.educationId != null) {
      selectedEducation.value = educationList.firstWhereOrNull(
          (element) => element.id == donorProfileDetail.value?.educationId);
    }

    if (donorProfileDetail.value?.professionId != null) {
      selectedProfession.value = professionList.firstWhereOrNull(
          (element) => element.id == donorProfileDetail.value?.professionId);
    }

    if (donorProfileDetail.value?.bloodGroup != null) {
      selectedBloodGroup.value = bloodList.firstWhereOrNull((element) =>
          element.name.trim() == donorProfileDetail.value?.bloodGroup!.trim());
    }

    otherEthnicity.value.text = donorProfileDetail.value?.otherEthnicity ?? "";
    otherReligiousCntrl.value.text =
        donorProfileDetail.value?.otherReligious ?? "";
  }

  getDonorProfileData() async {
    try {
      userImage.clear();
      donorOtherReport.clear();
      var response1 = await ResponseWrapper.init(
          create: () =>
              APIResponse<DonorProfileModel>(create: () => DonorProfileModel()),
          data: await DefaultAssetBundle.of(
                  NavigationService.navigatorKey.currentContext!)
              .loadString("assets/json/donor_profile.json"));
      var data = response1.response.data;

      if (data != null) {
        donorProfileDetail.value = data.donorProfileDetail;
        userImage.value = data.userImage ?? [];
        donorOtherReport.value = data.otherMedicalReport ?? [];
        geneticReport.value = donorOtherReport
                .firstWhereOrNull((element) => element.medicalReportId == 3) ??
            OtherMedicalReport(medicalReportId: 3);
        semenReport.value = donorOtherReport
                .firstWhereOrNull((element) => element.medicalReportId == 2) ??
            OtherMedicalReport(medicalReportId: 2);
        stdReport.value = donorOtherReport
                .firstWhereOrNull((element) => element.medicalReportId == 1) ??
            OtherMedicalReport(medicalReportId: 1);
        // var encodedetails = jsonEncode(data.toMap());
        // await AppStorage.appStorage.write(AppStorage.userData, encodedetails);
        await addInitialValue();
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
      userImage.clear();

      // var data = await DefaultAssetBundle.of(
      //         NavigationService.navigatorKey.currentContext!)
      //     .loadString("assets/json/donor_data.json");
      // var donorData = jsonDecode(data);
      // var userDataJson = jsonEncode(donorData["data"]);
      // await AppStorage.appStorage.write(AppStorage.userData, userDataJson);

      await addInitialValue();
      // await Future.delayed(
      //   Duration(seconds: 1),
      //   () {
      //     closeLoadingDialog();
      //   },
      // );
    }
  }
}
