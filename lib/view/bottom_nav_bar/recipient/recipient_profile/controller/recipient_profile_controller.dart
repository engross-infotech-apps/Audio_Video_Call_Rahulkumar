import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/helper/date_format.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/api_response.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/model/donor_profile_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/recipient_list/Model/recipient_profile_model.dart';
import 'package:gokidu_app_tour/view/onboarding/models/image_models.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../model/donor_preferences_model.dart';

class RecipientProfileController extends GetxController {
  var profileImg = Rxn<File?>();

  var finalProfileImg = Rxn<String>();
  final formKey = GlobalKey<FormState>();

  TextEditingController bio = TextEditingController();
  TextEditingController displayName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  var userAddress = TextEditingController().obs;
  var birthDate = TextEditingController().obs;

  var isAnonymous = false.obs;
  var oldDisplayName = Rxn<String>();

  var latitude = "".obs;
  var longitude = "".obs;

  var addressParameters;

  String? apiImg;
  var loading = false.obs;
  var isDisplayNameExists = false.obs;
  var pickedImages = <PickedImageModel>[
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
    PickedImageModel(imgStatus: UploadImageStatus.isNotSelected),
  ].obs;

  // var getProfileImg = Rxn<String>();
  var recipientProfileData = RecipientProfileModel().obs;
  var profileData = RecipientProfile().obs;
  var imageList = <UserImage>[].obs;

  var ethnicityList = <LookupModelPO>[].obs;
  var selectedEthnicity = Rxn<LookupModelPO>();

  var otherEthnicity = TextEditingController().obs;
  var ethnicityCntrl = TextEditingController().obs;

  var nationalityList = <LookupModelPO>[].obs;
  var selectedNationality = Rxn<LookupModelPO>();
  var nationalityCntrl = TextEditingController().obs;

  @override
  void onInit() async {
    await init();
    super.onInit();
  }

  init({bool passPage = true}) async {
    try {
      loading.value = true;
      await getLookupData();
      var response1 = await ResponseWrapper.init(
          create: () => APIResponse<RecipientProfileModel>(
              create: () => RecipientProfileModel()),
          data: await DefaultAssetBundle.of(
                  NavigationService.navigatorKey.currentContext!)
              .loadString("assets/json/recipient_profile.json"));
      recipientProfileData.value = response1.response.data;

      profileData.value = recipientProfileData.value.recipientProfile!;
      imageList.clear();
      imageList.addAll(recipientProfileData.value.userImage ?? []);
      for (var i = 0; i < imageList.length; i++) {
        pickedImages[i].image = imageList[i].imageName;
        pickedImages[i].imgUrl = imageList[i].imageName;
        pickedImages[i].imageId = imageList[i].userImageId;
        pickedImages[i].isExisting = true;
        pickedImages[i].imgStatus = UploadImageStatus.isUploadSuccess;
      }
      if (profileData.value.dob != null) {
        var picked = parseDate("yyyy-MM-dd", profileData.value.dob!).toLocal();
        var date = formatDate("dd/MM/yyyy", picked);
        birthDate.value.text = date;
      }
      // getProfileImg = profileData!.profilePicture!;
      if (profileData.value.profilePicture != null &&
          profileData.value.profilePicture!.isNotEmpty) {
        apiImg = profileData.value.profilePicture ?? "";
      }
      if (profileData.value.displayName != null &&
          profileData.value.displayName!.isNotEmpty) {
        oldDisplayName.value = profileData.value.displayName;
        displayName.text = profileData.value.displayName!;
        isAnonymous.value = displayName.text.isNotEmpty;
      }
      if (profileData.value.fullName != null &&
          profileData.value.fullName!.isNotEmpty) {
        fullName.text = profileData.value.fullName!;
      }
      if (profileData.value.aboutMe != null &&
          profileData.value.aboutMe!.isNotEmpty) {
        bio.text = profileData.value.aboutMe!;
      }
      if (profileData.value.address != null &&
          profileData.value.address!.isNotEmpty) {
        userAddress.value.text = profileData.value.address!;
        longitude.value = profileData.value.addressLongitude.toString();
        latitude.value = profileData.value.addressLatitude.toString();
      }
      if (profileData.value.ethnicityId != null) {
        selectedEthnicity.value = ethnicityList.firstWhere(
            (element) => element.id == profileData.value.ethnicityId);
        ethnicityCntrl.value.text = selectedEthnicity.value!.name;
      }
      if (profileData.value.otherEthnicity != null) {
        otherEthnicity.value.text = profileData.value.otherEthnicity!;
      }
      if (profileData.value.nationalityId != null) {
        selectedNationality.value = nationalityList.firstWhere(
            (element) => element.id == profileData.value.nationalityId);
        nationalityCntrl.value.text = selectedNationality.value!.subName!;
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;
      debugPrint("==============$e");
    }
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
      ethnicityList.clear();
      nationalityList.clear();

      for (var data in list.ethnicity!) {
        ethnicityList.add(data.modelPO!);
      }
      ethnicityList.insert(
          ethnicityList.length, LookupModelPO(id: null, name: "Other"));

      for (var data in list.country!) {
        nationalityList.add(data.modelPO!);
      }
    }
  }

  // Future getProfileDetails() async {
  //   try {
  //     var data = await DefaultAssetBundle.of(
  //             NavigationService.navigatorKey.currentContext!)
  //         .loadString("assets/json/donor_data.json");
  //     var donorData = jsonDecode(data);
  //     await AppStorage.appStorage
  //         .write(AppStorage.userData, jsonEncode(donorData["data"]));
  //     // bottomBarCntrl.user.value = data.res;
  //   } catch (e) {
  //     debugPrint("---error---${e}");
  //   }
  // }

  isFieldEmpty(String value, String hint) {
    if (value.trim().isEmpty) {
      return 'Please enter $hint!';
    }
    return null;
  }

  isFieldSelected(String value, String hint) {
    if (value.trim().isEmpty) {
      return 'Please select $hint!';
    }
    return null;
  }

  birthdateValidation(String value) {
    if (value.trim().isEmpty) {
      return 'Please select birth date!';
    }
    return null;
  }

  final f = DateFormat('dd/MM/yyyy');

  Future<String> birthdateOntap() async {
    final now = DateTime.now();
    final date = DateTime(
        now.year - 18, now.month, now.day, now.hour, now.minute, now.second);

    DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: Get.context!,
      initialDate: birthDate.value.text.isEmpty
          ? date
          : parseDate("dd/MM/yyyy", birthDate.value.text).toLocal(),
      firstDate: DateTime(1900),
      lastDate: date,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryRed,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      String pickedDate = f.format(picked);
      birthDate.value.text = pickedDate.toString();
    }

    return birthDate.value.text;
  }

  showImgPicker() {
    return showModalBottomSheet(
        context: Get.context!,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.maxFinite,
            child: SafeArea(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Custom.svgIconData(AppSvgIcons.bottomSheetIcon),
                    ),
                    vSpace(20),
                    const Text(
                      "Add profile photo",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    vSpace(20),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await pickImages(ImageSource.camera);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                          Custom.svgIconData(AppSvgIcons.camera),
                          hSpace(7),
                          Text(
                            "Take a photo",
                            style: AppFontStyle.blackRegular16pt,
                          ),
                        ]),
                      ),
                    ),
                    vSpace(15),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await pickImages(ImageSource.gallery);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                          Custom.svgIconData(AppSvgIcons.imageGallery),
                          hSpace(7),
                          Text(
                            "Upload from gallery",
                            style: AppFontStyle.blackRegular16pt,
                          ),
                        ]),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  pickImages(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) await _cropImage(pickedFile.path);
  }

  Future _cropImage(String filePath) async {
    var croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      profileImg.value = File(croppedImage.path);
      // var res = await FileApi().uploadSingleFile(profileImg.value!.path);
      // if (res != null) {
      //   finalProfileImg.value = res.originalUrl;
      // }
    }
  }

  /*Future<String?> displayNameValidation(loader) async {
    try {
      var data = await AccountApi().displayName(
          displayName.text.trim(), oldDisplayName.value ?? "", loader);
      isDisplayNameExists.value = data!.data!.isNameExists!;
      return null;
    } catch (e) {
      // await showDialog(
      //   context: Get.context!,
      //   builder: (context) => AlertMsgDialog(
      //       title: "Error",
      //       msg: e.toString(),
      //       secondryText: "Close",
      //       image: AppSvgIcons.report,
      //       secondryBtnTap: () {
      //         Navigator.pop(context);
      //       }),
      // );
      isDisplayNameExists.value = true;
      return e.toString();
    }
  }

  onSave() async {
    showLoadingDialog();
    if (profileImg.value != null) {
      var res = await FileApi().uploadSingleFile(profileImg.value!.path);
      if (res != null) {
        finalProfileImg.value = res.originalUrl;
      }
    }
    var recipientImgs = <String>[];
    for (var element in pickedImages) {
      if (element.imgStatus == UploadImageStatus.isUploadSuccess &&
          element.imgUrl != null &&
          element.imgUrl!.isNotEmpty &&
          imageList.firstWhereOrNull((value) =>
                  element.imgUrl == value.imageName &&
                  element.imageId == value.userImageId) ==
              null) {
        recipientImgs.add(element.imgUrl!);
      }
    }
    var deletedImgId = [];
    for (var value in imageList) {
      if (pickedImages.firstWhereOrNull(
              (element) => element.imageId == value.userImageId) ==
          null) {
        deletedImgId.add(value.userImageId);
      } else {
        continue;
      }
    }

    var picked = parseDate("dd/MM/yyyy", birthDate.value.text.trim()).toLocal();
    var date = formatDate("yyyy-MM-dd", picked);

    try {
      Map parameter = {
        "FullName":
            fullName.text.trim().isEmpty ? null : (fullName.text).toString(),
        "DisplayName": displayName.text.trim().isEmpty
            ? null
            : (displayName.text).toString(),
        "DeletedPhotoIds": deletedImgId,
        "Photos": recipientImgs,
        "ProfilePicture":
            profileImg.value == null ? null : (finalProfileImg).toString(),
        "AboutMe": bio.text.trim().isEmpty ? null : (bio.text.toString()),
        "EthnicityId": selectedEthnicity.value?.id,
        "OtherEthnicity": selectedEthnicity.value?.id == null
            ? otherEthnicity.value.text.isNotEmpty
                ? otherEthnicity.value.text.trim()
                : null
            : null,
        "NationalityId": selectedNationality.value?.id,
        "DOB": date,
      };
      if (addressParameters != null) parameter.addAll(addressParameters);

      debugPrint("----parameter--$parameter");

      await RecipientApi().updateRecipientProfile(parameter);
      await getProfileDetails();
      await init(passPage: false);
      await closeLoadingDialog();
    } catch (e) {
      await closeLoadingDialog();
      debugPrint("----eroor--$e");
    }
  }

  addImgOnServer(Function callback) async {
    var list = await ImagePicker().pickMultiImage();

    for (var j = 0; j < pickedImages.length; j++) {
      for (var i = 0; i < (list.length < 7 ? list.length : 6); i++) {
        if (pickedImages[j].imgStatus == UploadImageStatus.isNotSelected) {
          pickedImages[j].imgStatus = UploadImageStatus.isUploading;
          FileApi()
              .uploadSingleFile(list[i].path)
              .then((UploadImageModel? res) async {
            if (res != null) {
              pickedImages[j].imgUrl = res.originalUrl;
              pickedImages[j].image = res.originalUrl;
              pickedImages[j].imgStatus = UploadImageStatus.isUploadSuccess;
              callback();
            } else {
              pickedImages[j].imgStatus = UploadImageStatus.isUploadFailed;
              callback();
            }
          });

          list.removeAt(i);
          callback();
        }
      }
    }
  }

  deleteImgOnServer(int index) async {
    var name = pickedImages[index].imgUrl!;
    try {
      await FileApi().deleteFile(name);
      pickedImages[index] =
          PickedImageModel(imgStatus: UploadImageStatus.isNotSelected);
    } catch (e) {
      showDialog(
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
  }*/
}
