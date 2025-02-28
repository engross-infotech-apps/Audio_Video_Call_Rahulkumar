import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/function/app_function.dart';
import 'package:gokidu_app_tour/core/helper/date_format.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/controller/bottom_nav_bar_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/controller/recipient_nav_bar_controller.dart';
import 'package:gokidu_app_tour/view/liked/controller/liked_controller.dart';
import 'package:gokidu_app_tour/view/liked/model/liked_model.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => LikeScreenState();
}

class LikeScreenState extends State<LikeScreen> with TickerProviderStateMixin {
  final ctrl = Get.put(LikeController());

  @override
  void initState() {
    ctrl.init();
    int initialIndex = 0;
    if (AppStorage.getUserData()?.roleId == UserRole.recipient.number) {
      final recipientCtrl =
          Get.find<RecipientBottomBarController>(tag: "bottombar");
      initialIndex = (recipientCtrl.selectedAction.value?.tabIndex ?? 0);
      recipientCtrl.selectedAction.value = null;
    } else {
      final donorCntrl = Get.find<BottomNavBarController>(tag: "bottomNavBar");
      initialIndex = (donorCntrl.selectedAction.value?.tabIndex ?? 0);
      donorCntrl.selectedAction.value = null;
    }

    ctrl.chooseGrid.value =
        (AppStorage.getLayoutStyle() ?? 0) == LayoutStyle.grid.number;
    ctrl.tabCtrl.value =
        TabController(length: 4, vsync: this, initialIndex: initialIndex);

    ctrl.tabCtrl.value?.addListener(ctrl.tabListener);
    super.initState();
  }

  ///------------------functions----------------

  getTabBgBody(index) {
    switch (index) {
      case 0:
        return CustomEmptyScreen(
          icon: AppSvgIcons.likeEmpty,
          iconSize: 60,
          title: "No Likes Yet!",
          subTitle:
              "When a ${getCurrentUserRole()} likes you, you'll see them here. Keep engaging to get noticed!",
        );
      case 1:
        return CustomEmptyScreen(
          icon: AppSvgIcons.likeEmpty,
          iconSize: 60,
          title: "You Haven't Liked Anyone Yet!",
          subTitle: ctrl.user?.roleId == UserRole.recipient.number
              ? "Like donors to show interest and connect with those willing to help."
              : "Like recipients to show interest and connect with those who need help.",
        );
      case 2:
        return CustomEmptyScreen(
          icon: AppSvgIcons.likeEmpty,
          iconSize: 60,
          title: "No Maybes Yet!",
          subTitle:
              '''Mark someone as "Maybe" to decide later. When you do, they'll appear here.''',
        );
      case 3:
        return CustomEmptyScreen(
          icon: AppSvgIcons.likeEmpty,
          iconSize: 60,
          title: "No Dislikes Yet!",
          subTitle:
              "Don't want to see someone again? Dislike them, and they won't appear in your feed.",
        );
      default:
        return SizedBox();
    }
  }

  ///--------------------grid view--------------

  gridView(
      {List<LikeModel>? list, ScrollController? scrollCntrl, int? tabIndex}) {
    return GridView.builder(
        controller: scrollCntrl,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20.00,
          childAspectRatio:
              (MediaQuery.of(context).size.width - (20 + 20 + 10)) / 470,
        ),
        itemCount: list!.length,
        itemBuilder: (context, index) {
          return Container(child: gridBody(list[index], tabIndex));
        });
  }

  textView(LikeModel donorData, index) {
    var likeDate = timeAgo(donorData.createdDate!);
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: RichText(
              text: TextSpan(
                  text:
                      "${(donorData.displayName ?? donorData.fullName ?? 'N/A')}",
                  style: AppFontStyle.heading5nHalf.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    // shadows: AppFontStyle.textShadow(),
                  ),
                  children: [
                    if (donorData.isVerified ?? false) ...[
                      WidgetSpan(child: hSpace(5)),
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child:
                              Custom.svgIconData(AppSvgIcons.verify, size: 16)),
                    ],
                    TextSpan(
                      text: " • ${donorData.age}",
                      style: AppFontStyle.heading5nHalf.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        // shadows: AppFontStyle.textShadow(),
                      ),
                    ),
                  ]),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              likeDate,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppFontStyle.greyRegular14pt.copyWith(color: Colors.white),
            ),
          ),
        ]);
  }

  Widget gridBody(LikeModel donorData, index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: bookMarkNetWorkImage(donorData.profilePicture ?? "", index,
            child: textView(donorData, index), donorData: donorData),
      ),
    );
  }

  Widget bookMarkNetWorkImage(String img, int index,
      {Widget? child, LikeModel? donorData}) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      CachedNetworkImage(
        imageUrl: CustomText.imgEndPoint + img,
        errorListener: (value) {},
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        ),
        placeholder: (context, url) => Container(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.greyBorder),
              ),
              alignment: Alignment.center,
              child: Custom.loader()),
        ),
        errorWidget: (context, url, error) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyCardBorder, width: 1),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(AppImage.emptyProfile),
                  fit: BoxFit.scaleDown,
                )),
          );
        },
      ),
      Positioned.fill(
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                // (!(donorData?.isRead ?? false) && index == 0
                //         ? AppColors.primaryRed
                //         : Colors.black)
                //     .withOpacity(0.9),
                // (!(donorData?.isRead ?? false) && index == 0
                //         ? AppColors.primaryRed
                //         : Colors.black)
                //     .withOpacity(0.35),
                // (!(donorData?.isRead ?? false) && index == 0
                //         ? AppColors.primaryRed
                //         : Colors.black)
                //     .withOpacity(0.1),
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.35),
                Colors.black.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: child,
        ),
      ),
      if (!(donorData?.isRead ?? false) && index == 0) ...[
        Positioned(
          right: 10,
          top: 10,
          child: CardIconButton(
            icon: AppSvgIcons.recentLike,
            bgColor: AppColors.primaryRed,
            useMargin: false,
          ),
        ),
        hSpace(20),
      ],
    ]);
  }

  ///--------------------list view-----------------------

  listView(
      {List<LikeModel>? list, ScrollController? scrollCntrl, int? tabIndex}) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        controller: scrollCntrl,
        itemCount: list?.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var likeDate = timeAgo(list![index].createdDate!);
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            hoverColor: AppColors.lightPink,
            splashColor: AppColors.lightPink,
            overlayColor:
                MaterialStateColor.resolveWith((states) => AppColors.lightPink),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: listBody(list[index], likeDate, tabIndex: tabIndex),
            ),
          );
        });
  }

  Widget listBody(LikeModel element, String date, {int? tabIndex}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: !(element.isRead ?? false) && tabIndex == 0
            ? AppColors.lightPinkBG.withOpacity(0.5)
            : Colors.transparent,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Stack(children: [
          CachedNetworkImage(
            imageUrl: CustomText.imgEndPoint + (element.profilePicture ?? ""),
            height: 60,
            width: 60,
            errorListener: (value) {},
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            placeholder: (context, url) => Container(
                height: 10,
                width: 10,
                alignment: Alignment.center,
                child: Custom.loader()),
            errorWidget: (context, url, error) {
              return Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightPink,
                    image: DecorationImage(
                      image: AssetImage(AppImage.emptyProfile),
                      fit: BoxFit.cover,
                    )),
              );
            },
          ),
          if ((element.isOnline ?? false)) ...[
            Positioned(
              right: 0,
              bottom: 7,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightGreen,
                ),
                width: 10,
                height: 10,
              ),
            ),
          ],
        ]),
        hSpace(15),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text:
                          "${(element.displayName ?? element.fullName ?? 'N/A')}",
                      style: AppFontStyle.heading5
                          .copyWith(fontWeight: FontWeight.w500),
                      children: [
                        if (element.isVerified != null &&
                            element.isVerified!) ...[
                          WidgetSpan(child: hSpace(5)),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Custom.svgIconData(AppSvgIcons.verify,
                                size: 16),
                          ),
                        ],
                        TextSpan(
                            text: " • ${element.age}",
                            style: AppFontStyle.heading5
                                .copyWith(fontWeight: FontWeight.w400))
                      ]),
                ),
                Text(
                  date,
                  style: AppFontStyle.greyRegular14pt,
                ),
              ]),
        ),
        if (!(element.isRead ?? false) && tabIndex == 0) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.lightPink2,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Custom.svgIconData(AppSvgIcons.recentLike, size: 18),
              hSpace(5),
              Text("Recently liked", style: AppFontStyle.blackRegular14pt),
            ]),
          ),
          // hSpace(20),
        ],
      ]),
    );
  }

  ///-------------------tab view--------------------

  Widget tabView(tabIndex) {
    var loader = ctrl.getLoader(tabIndex);
    var list = ctrl.getTabList(tabIndex);
    var scrl = ctrl.getScrollCntrl(tabIndex);
    return !loader
        ? Obx(
            () => RefreshIndicator(
              onRefresh: () => ctrl.callBack(tabIndex),
              color: AppColors.primaryRed,
              child: (list.isNotEmpty)
                  ? ctrl.chooseGrid.value
                      ? gridView(
                          list: list, scrollCntrl: scrl, tabIndex: tabIndex)
                      : listView(
                          list: list, scrollCntrl: scrl, tabIndex: tabIndex)
                  : LayoutBuilder(
                      builder: (context, constraint) {
                        return SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: Center(child: getTabBgBody(tabIndex)),
                          ),
                        );
                      },
                    ),
            ),
          )
        : Center(
            child: Container(
              height: 50,
              width: 50,
              child: Custom.loader(),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    ctrl.chooseGrid.value =
        (AppStorage.getLayoutStyle() ?? 0) == LayoutStyle.grid.number;
    return Obx(() => Scaffold(
          // appBar: AppBar(
          //   automaticallyImplyLeading: false,
          //   elevation: 0,
          //   scrolledUnderElevation: 0,
          //   backgroundColor: Colors.transparent,
          //   systemOverlayStyle: SystemUiOverlayStyle.dark,
          //   centerTitle: false,
          //   leadingWidth: 60,
          //   leading: Padding(
          //     padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          //     child: CustomBgRoundedIcons(
          //         icon: AppSvgIcons.backArrow,
          //         onTap: () {
          //           Get.back();
          //         }),
          //   ),
          //   title: Text("Likes",
          //       style:
          //           AppFontStyle.heading4.copyWith(fontWeight: FontWeight.w500)),
          //   actions: [
          //     CustomBgRoundedIcons(
          //       icon:
          //           (AppStorage.getLayoutStyle() ?? 0) == LayoutStyle.grid.number
          //               ? AppSvgIcons.gridView
          //               : AppSvgIcons.listView,
          //       size: 40,
          //       iconColor: AppColors.primaryRed,
          //       // isGradient: true,
          //       onTap: () {
          //         ctrl.chooseGrid.value = !ctrl.chooseGrid.value;
          //         AppStorage.appStorage.write(
          //             AppStorage.layoutStyle,
          //             ctrl.chooseGrid.value
          //                 ? LayoutStyle.grid.number
          //                 : LayoutStyle.list.number);
          //         setState(() {});
          //       },
          //     ),
          //     hSpace(20),
          //   ],
          // ),
          // /* !ctrl.loaderOne.value || !ctrl.loaderTwo.value
          //       ? */
          body: Column(children: [
            Stack(alignment: Alignment.center, children: [
              TabBar.secondary(
                controller: ctrl.tabCtrl.value,
                tabAlignment: TabAlignment.fill,
                indicator: BoxDecoration(color: Colors.transparent),
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.symmetric(horizontal: 10),
                dividerHeight: 1,
                dividerColor: AppColors.greyBorder,
                splashBorderRadius: BorderRadius.circular(100),
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: AppFontStyle.blackRegular18pt
                    .copyWith(fontWeight: FontWeight.w600),
                labelColor: AppColors.primaryRed,
                unselectedLabelColor: AppColors.black,
                tabs: const [
                  Tab(child: Text("Liked Me")),
                  Tab(child: Text("I Liked")),
                  Tab(child: Text("Maybe")),
                  Tab(child: Text("Dislike")),
                ],
                onTap: (value) {},
                isScrollable: false,
              ),
            ]),
            Flexible(
              child: Obx(
                () => TabBarView(
                  controller: ctrl.tabCtrl.value,
                  children: List<Widget>.generate(
                    ctrl.tabCtrl.value!.length,
                    (index) {
                      return tabView(index);
                    },
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
