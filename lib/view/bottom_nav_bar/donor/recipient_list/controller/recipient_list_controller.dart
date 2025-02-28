import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/api_response.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/model/donor_profile_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/recipient_list/model/recipient_profile_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/rating_review/model/rating_review_model.dart';
import 'package:gokidu_app_tour/widgets/card_swiper/controller/card_swiper_controller.dart';

class RecipientListController extends GetxController {
  final CardSwiperController controller = CardSwiperController();

  var recipientList = <RecipientProfileDetails>[].obs;
  var ratingReviewList = <Rating>[].obs;
  var pageNo = 0.obs;
  var loader = false.obs;
  var likeLoader = false.obs;
  var recipientData = Rxn<RecipientProfileModel>();
  var isMoreDataAvailable = true.obs;
  var rating = 0.0.obs;
  var userImage = <UserImage>[].obs;
  var selectedCardIndex = 0.obs;
  var isAction = false.obs;

  late AnimationController animationController;
  Animation<Offset>? scaleAnimation;
  Animation<double>? fadeAnimation;

  @override
  void onInit() async {
    super.onInit();
  }

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

  getRecipientData() async {
    var list = <RecipientProfileDetails>[];
    if (pageNo.value == 1) {
      loader.value = false;
      isMoreDataAvailable.value = true;
      recipientList.clear();
    }
    Map parameter = {
      "PageNumber": pageNo.value.toInt(),
      "PageSize": 10,
      "VerificationStatus": null
    };
    // try {
    var response1 = await ResponseWrapper.init(
        create: () => APIListResponse<RecipientProfileDetails>(
            create: () => RecipientProfileDetails()),
        data: await DefaultAssetBundle.of(
                NavigationService.navigatorKey.currentContext!)
            .loadString("assets/json/recipient_list.json"));
    list = response1.response.data;

    if (list.length < 10) {
      isMoreDataAvailable.value = false;
    } else {
      isMoreDataAvailable.value = true;
    }
    for (var element in list) {
      if (element.userImage != null &&
          !(element.userImage!.contains(element.profilePicture))) {
        if (element.profilePicture != null &&
            element.profilePicture!.isNotEmpty) {
          element.userImage!.insert(0, element.profilePicture!);
        }
      }
      recipientList.add(element);
    }
    loader.value = true;
    // } catch (e) {
    //   await showDialog(
    //     context: Get.context!,

    //     builder: (context) => AlertMsgDialog(
    //         title: "Error",
    //         msg: e.toString(),
    //         secondaryText: "Close",
    //         image: AppSvgIcons.report,
    //         secondaryBtnTap: () {
    //           Navigator.pop(context);
    //         }),
    //   );
    // }
  }
/*
  Future getRecipientDetails(int id) async {
    // loader.value = true;
    // await Future.delayed(Duration(seconds: 1));

    recipientData.value = null;
    userImage.clear();
    ratingReviewList.clear();

    try {
      var data = await DonorApi().getRecipientDetailsById(id.toString(),
          LastActivity.donorExploreGetRecipient.number.toString());
      if (data != null) {
        recipientData.value = data;
        if (data.recipientRatingsAndReviews != null) {
          ratingReviewList.addAll(data.recipientRatingsAndReviews ?? []);
          userImage.addAll(data.userImage!.isNotEmpty
              ? data.userImage ?? []
              : [
                  // UserImage(
                  //     userImageId: -1,
                  //     imageName:
                  //         data.recipientProfileDetail?.profilePicture ?? "")
                ]);
          if (data.recipientProfileDetail?.profilePicture != null &&
              userImage.firstWhereOrNull((element) =>
                      element.imageName ==
                      data.recipientProfileDetail?.profilePicture) ==
                  null) {
            userImage.insert(
                0,
                UserImage(
                    userImageId: -1,
                    imageName:
                        data.recipientProfileDetail?.profilePicture ?? ""));
          }
        }
      } else {
        Get.back();
      }
      loader.value = false;
    } catch (e) {
      // loader.value = false;
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

  likeDislikeRecipient() async {
    // try {
    //   var res;
    //   likeLoader.value = true;
    //   res = await UserApi()
    //       .likeDislike(recipientData.value!.recipientProfileDetail!.userId);
    //   debugPrint(res);
    recipientData.value?.recipientProfileDetail?.isLiked =
        !recipientData.value!.recipientProfileDetail!.isLiked;
    recipientData.value?.recipientProfileDetail!.likesCount =
        recipientData.value!.recipientProfileDetail!.isLiked
            ? (recipientData.value!.recipientProfileDetail!.likesCount! + 1)
            : (recipientData.value!.recipientProfileDetail!.likesCount! - 1);
    // likeLoader.value = false;
    // } catch (e) {
    //   debugPrint(e);
    //   // showAppToast(e);
    // }
  }

  addRateReview(String comment) async {
    Map parameter = {
      "UserId": recipientData.value!.recipientProfileDetail!.userId,
      "Ratings": rating.value,
      "Comment": comment.trim(),
    };
    try {
      // Get.back();
      await UserApi().rateReview(parameter);
      Get.back();
      showAppToast("Your review successfully posted");
      await getRecipientDetails(
          recipientData.value!.recipientProfileDetail!.userId!);
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
      closeLoadingDialog();
    }
  }*/

  successAction() async {
    // int index = selectedCardIndex.value;

    // if (index == recipientList.length - 3 && isMoreDataAvailable.value) {
    //   pageNo++;
    //   await getRecipientData();
    //   recipientList.removeAt(index);
    // } else if (index == recipientList.length - 1) {
    //   controller.moveTo(0);
    //   recipientList.removeAt(index);
    //   selectedCardIndex.value = 0;
    // } else {
    //   recipientList.removeAt(index);
    // }
  }

  /* actionDonor(int? userId, UserActions action,
      {bool isDetailsPage = false}) async {
    final BottomNavBarController bottomNavCtrl =
        Get.find<BottomNavBarController>(tag: "bottomNavBar");
    try {
      // var res;
      var res = await UserApi().doAction(int.parse(userId.toString()), action);

      var performingAction = AppStorage.getPerformingAction();

      if (performingAction == null && !(performingAction ?? false)) {
        await showDialog(
          context: Get.context!,
          builder: (context) => AlertMsgDialog(
            title: "Added to the ${action.value} list.",
            msg: "",
            // "Click ${CustomText.ok.toLowerCase()} to view all your actions.",
            primaryText: "${CustomText.ok}",
            primaryBtnTap: () async {
              bottomNavCtrl.selectedIndex.value = 3;
              bottomNavCtrl.selectedAction.value = action;
              Get.back();
              if (isDetailsPage) {
                Get.back(result: {
                  "isLiked":
                      recipientData.value?.recipientProfileDetail?.isLiked,
                  "isBookmark":
                      recipientData.value?.recipientProfileDetail?.isBookmark,
                  "isDislike":
                      recipientData.value?.recipientProfileDetail?.isDisliked,
                });
              }
              await AppStorage.appStorage
                  .write(AppStorage.performingAction, true);
            },
            /* secondaryText: "Close",
              secondaryBtnTap: () {
              Get.back();
            }*/
            image: AppSvgIcons.heartFill,
            imgColor: AppColors.primaryRed,
          ),
        );
      }
      if (res != null && res && !isDetailsPage) {
        playAnimation();
        // controller.swipe(CardSwiperDirection.top);
        await Future.delayed(Duration.zero, () async {
          await successAction();
          // controller.undo();
        });
      }
      return res;
    } catch (e) {
      debugPrint("---error--${e.toString()}");
    }
  }*/
}
