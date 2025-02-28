import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/recipient_list/controller/recipient_list_controller.dart';
// import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/filter_screen/widget/list_empty_screen.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/widgets/recipient_profile_card.dart';
import 'package:gokidu_app_tour/widgets/card_swiper/enums.dart';
import 'package:gokidu_app_tour/widgets/card_swiper/properties/allowed_swipe_direction.dart';
import 'package:gokidu_app_tour/widgets/card_swiper/widget/card_swiper.dart';

class RecipientList extends StatefulWidget {
  const RecipientList({super.key});

  @override
  State<RecipientList> createState() => RecipientListState();
}

class RecipientListState extends State<RecipientList>
    with SingleTickerProviderStateMixin {
  final ctrl = Get.put(RecipientListController(), tag: "exploreRecipient");

  @override
  void initState() {
    ctrl.pageNo.value = 1;
    ctrl.getRecipientData();
    ctrl.selectedCardIndex.value = 0;
    ctrl.animationController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: Duration(milliseconds: 100),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Obx(() => ctrl.loader.value
      ? ctrl.recipientList.isNotEmpty
          ? CardSwiper(
              isLoop: true,
              controller: ctrl.controller,
              onSwipe: _onSwipe,
              onUndo: _onUndo,
              numberOfCardsDisplayed:
                  ctrl.recipientList.length < 3 ? ctrl.recipientList.length : 3,
              backCardOffset:
                  Offset(0, MediaQuery.of(context).size.height * 0.05),
              // maxAngle: 50,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              allowedSwipeDirection: AllowedSwipeDirection.only(
                up: true,
                down: false,
              ),
              cardBuilder: (context, index, horizontalOffsetPercentage,
                  verticalOffsetPercentage) {
                bool isCurrent = index == ctrl.selectedCardIndex.value;
                return Obx(
                  () => AnimatedBuilder(
                    animation: ctrl.animationController,
                    builder: (context, child) {
                      ctrl.scaleAnimation = Tween<Offset>(
                              begin: Offset(0.0, 0), end: Offset(0, -300))
                          .animate(ctrl.animationController);
                      ctrl.fadeAnimation = Tween<double>(begin: 1.0, end: 0.5)
                          .animate(ctrl.animationController);
                      return Transform.translate(
                        offset: isCurrent
                            ? ctrl.scaleAnimation?.value ?? Offset(0, 0)
                            : Offset(0, 0),
                        child: Opacity(
                          opacity: isCurrent
                              ? ctrl.fadeAnimation?.value ?? 1.0
                              : 1.0,
                          child: child,
                        ),
                      );
                    },
                    child: ViewRecipientWidget(
                        recipientData: ctrl.recipientList[index]),
                  ),
                );
              },
              cardsCount: ctrl.recipientList.length,
            )
          : Container() //ListInitialScreen()
      : SizedBox());
  Future<bool> _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async {
    if (currentIndex == ctrl.recipientList.length - 3 &&
        ctrl.isMoreDataAvailable.value) {
      // ctrl.pageNo++;
      // await ctrl.getRecipientData();
    }
    ctrl.selectedCardIndex.value = currentIndex ?? 0;
    setState(() {});
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    ctrl.selectedCardIndex.value = currentIndex;
    setState(() {});
    debugPrint(
      'The card $currentIndex was undo from the ${direction.name}',
    );
    return true;
  }
}
