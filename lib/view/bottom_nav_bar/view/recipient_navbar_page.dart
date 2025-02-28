import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/function/app_function.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/controller/recipient_nav_bar_controller.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/explore_donors/filter_screen/view/filter_page.dart';
import 'package:gokidu_app_tour/view/liked/view/liked_page.dart';

class RecipientBottomNavBarPage extends StatefulWidget {
  const RecipientBottomNavBarPage({
    super.key,
  });

  @override
  State<RecipientBottomNavBarPage> createState() =>
      _RecipientBottomNavBarPageState();
}

class _RecipientBottomNavBarPageState extends State<RecipientBottomNavBarPage> {
  final RecipientBottomBarController cntrl =
      Get.put(RecipientBottomBarController(), tag: "bottombar");

  @override
  void initState() {
    super.initState();
  }

  Widget bottomBarIconView(String icon, String label, int index) {
    return Obx(
      () => Expanded(
        child: GestureDetector(
          onTap: () => setState(() {
            cntrl.selectedIndex.value = index;
          }),
          child: Container(
            color: Colors.transparent,
            width: AppScreenSize.width / 5,
            child: Custom.svgIconData(icon,
                size: 22,
                color: cntrl.selectedIndex.value == index
                    ? AppColors.primaryRed
                    : AppColors.greyText),
          ),
        ),
      ),
    );
  }

  bookMarkOnTap() async {
    if ((AppStorage.getLayoutStyle() ?? 0) == LayoutStyle.grid.number) {
      AppStorage.appStorage
          .write(AppStorage.layoutStyle, LayoutStyle.list.number);
    } else {
      AppStorage.appStorage
          .write(AppStorage.layoutStyle, LayoutStyle.grid.number);
    }
    cntrl.appBarView[3]['svg'] = CustomBgRoundedIcons(
      icon: (AppStorage.getLayoutStyle() ?? 0) == LayoutStyle.grid.number
          ? AppSvgIcons.gridView
          : AppSvgIcons.listView,
      size: 40,
      iconColor: Colors.white,
      isGradient: true,
      onTap: null,
    );
    cntrl.widgetOptions[3] = LikeScreen();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        // toolbarHeight: 80,
        scrolledUnderElevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Row(children: [
            Expanded(
              child: Obx(() => Text(
                  cntrl.appBarView[cntrl.selectedIndex.value]['title']
                      .toString(),
                  style: AppFontStyle.heading2)),
            ),
            Obx(
              () => GestureDetector(
                onTap: () async {
                  if (cntrl.selectedIndex.value == 2) {
                    await showLookupBottomSheet(child: FilterPage());
                  } else if (cntrl.selectedIndex.value == 3) {
                    await bookMarkOnTap();
                    setState(() {});
                  } else if (cntrl.selectedIndex.value == 0) {
                  } else if (cntrl.selectedIndex.value == 4) {}
                  setState(() {});
                },
                child: Container(
                    child: cntrl.appBarView[cntrl.selectedIndex.value]['svg'] ??
                        SizedBox()),
              ),
            ),
          ]),
        ),
      ),
      body: WillPopScope(
        onWillPop: appOnWillPop,
        child: SizedBox(
          height: double.maxFinite,
          child: Obx(
            () => cntrl.widgetOptions.elementAt(cntrl.selectedIndex.value),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => SafeArea(
          child: Container(
            // height: 70,
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: AppColors.greyLightBorder, width: 2)),
            ),
            width: double.maxFinite,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottomBarIconView(
                      cntrl.selectedIndex.value == 0
                          ? AppSvgIcons.homeFill
                          : AppSvgIcons.homeBorder,
                      "Home",
                      0),
                  bottomBarIconView(
                      cntrl.selectedIndex.value == 1
                          ? AppSvgIcons.chatFill
                          : AppSvgIcons.chatBorder,
                      "Chats",
                      1),
                  GestureDetector(
                    onTap: () => setState(() {
                      cntrl.selectedIndex.value = 2;
                    }),
                    child: Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: AppScreenSize.width / 6,
                            height: 45,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                                color: cntrl.selectedIndex.value == 2
                                    ? AppColors.primaryRed
                                    : AppColors.lightPink,
                                borderRadius: BorderRadius.circular(15)),
                            child: Custom.svgIconData(
                                cntrl.selectedIndex.value == 2
                                    ? AppSvgIcons.diversity
                                    : AppSvgIcons.diversityBorder,
                                size: 40,
                                fit: BoxFit.scaleDown),
                          ),
                          FittedBox(
                            child: Text('Donors',
                                style: AppFontStyle.greyRegular14pt
                                    .copyWith(color: AppColors.primaryRed)),
                          )
                        ],
                      ),
                    ),
                  ),
                  hSpace(10),
                  bottomBarIconView(
                      cntrl.selectedIndex.value == 3
                          ? AppSvgIcons.heartFill
                          : AppSvgIcons.heartBorder,
                      "Activity",
                      3),
                  Obx(
                    () => GestureDetector(
                      onTap: () => setState(() {
                        cntrl.selectedIndex.value = 4;
                      }),
                      child: Container(
                        color: Colors.transparent,
                        width: AppScreenSize.width / 5,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  padding: EdgeInsets.all(0.5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: cntrl.selectedIndex.value == 4
                                          ? Border.all(
                                              color: AppColors.primaryRed,
                                              width: 1.5)
                                          : null),
                                  child: ClipOval(
                                    child: CustomNetWorkImage(
                                        image: AppStorage.getUserData()
                                                ?.profilePicture ??
                                            "",
                                        placeholder: AppImage.emptyProfile),
                                  )),
                            ]),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
