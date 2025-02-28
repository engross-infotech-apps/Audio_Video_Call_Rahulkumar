// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/controller/recipient_nav_bar_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/controller/donor_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/filter_screen/view/filter_empty_donor_screen.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/filter_screen/widget/list_empty_screen.dart';
import 'package:gokidu_app_tour/widgets/card_swiper/enums.dart';
import 'package:gokidu_app_tour/widgets/card_swiper/properties/allowed_swipe_direction.dart';
import 'package:gokidu_app_tour/widgets/card_swiper/widget/card_swiper.dart';

class ExploreDonorsListPage extends StatefulWidget {
  const ExploreDonorsListPage({super.key});

  @override
  State<ExploreDonorsListPage> createState() => _ExploreDonorsListPageState();
}

class _ExploreDonorsListPageState extends State<ExploreDonorsListPage>
    with SingleTickerProviderStateMixin {
  final cntrl = Get.put(DonorsListController(), tag: "exploreDonor");
  final bottomBarCntrl =
      Get.find<RecipientBottomBarController>(tag: "bottombar");

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration.zero);
    cntrl.loader.value = true;
    cntrl.pageNo.value = 1;
    // await showLoadingDialog();
    cntrl.donorDetail.clear();
    cntrl.donorCards.clear();
    // --------Default preferences---------------
    // await cntrl.getDonorPreferences();
    //-------------------------------------------
    await cntrl.getDonorList();
    cntrl.selectedCardIndex.value = 0;
    // await closeLoadingDialog();
    // bottomBarCntrl.appBarView[2] = {
    //   "title": "Donors",
    //   "svg": FilterAppBarView(filterCount: cntrl.applyFilterCount())
    // };
    cntrl.animationController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: Duration(milliseconds: 100),
    );
    cntrl.loader.value = false;
    setState(() {});
  }

  @override
  void dispose() {
    cntrl.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("---va--${bottomBarCntrl.filterCount.value}");
    return Scaffold(
      body: Column(children: [
        Obx(
          () => cntrl.loader.value
              ? SizedBox()
              : cntrl.donorCards.isNotEmpty
                  ? Flexible(
                      child: CardSwiper(
                          controller: cntrl.controller,
                          cardsCount: cntrl.donorCards.length,
                          allowedSwipeDirection:
                              AllowedSwipeDirection.only(up: true, down: false),
                          onSwipeDirectionChange:
                              (horizontalDirection, verticalDirection) {},
                          onEnd: () async {},
                          onTapDisabled: () {},
                          onSwipe: _onSwipe,
                          onUndo: _onUndo,
                          numberOfCardsDisplayed: cntrl.donorCards.length < 3
                              ? cntrl.donorCards.length
                              : 3,
                          backCardOffset: Offset(
                              0, MediaQuery.of(context).size.height * 0.05),
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                          cardBuilder: (context,
                              index,
                              horizontalThresholdPercentage,
                              verticalThresholdPercentage) {
                            bool isCurrent =
                                index == cntrl.selectedCardIndex.value;

                            return Obx(
                              () => AnimatedBuilder(
                                  animation: cntrl.animationController,
                                  builder: (context, child) {
                                    cntrl.scaleAnimation = Tween<Offset>(
                                            begin: Offset(0.0, 0),
                                            end: Offset(0, -300))
                                        .animate(cntrl.animationController);
                                    cntrl.fadeAnimation =
                                        Tween<double>(begin: 1.0, end: 0.5)
                                            .animate(cntrl.animationController);
                                    return Transform.translate(
                                      offset: isCurrent
                                          ? cntrl.scaleAnimation?.value ??
                                              Offset(0, 0)
                                          : Offset(0, 0),
                                      child: Opacity(
                                        opacity: isCurrent
                                            ? cntrl.fadeAnimation?.value ?? 1.0
                                            : 1.0,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: cntrl.donorCards[index]),
                            );
                          }),
                    )
                  : bottomBarCntrl.filterCount.value == 0
                      ? ListInitialScreen()
                      : FilterInitialScreen(),
        ),
      ]),
    );
  }

  Future<bool> _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async {
    if (direction == CardSwiperDirection.bottom) {
      var index = previousIndex - 1;
      if (index >= 0) {
        cntrl.controller.moveTo(index);
        return false;
      }
    }
    if (currentIndex == cntrl.donorCards.length - 3) {
      cntrl.pageNo++;
      await cntrl.getDonorList();
    }
    cntrl.selectedCardIndex.value = currentIndex!;
    setState(() {});
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    cntrl.selectedCardIndex.value = currentIndex;
    setState(() {});
    debugPrint(
      'The card $currentIndex was undo from the ${direction.name}',
    );
    return true;
  }
}
