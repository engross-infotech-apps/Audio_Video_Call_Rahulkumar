import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/const.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/helper/validation_helper.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/chat/controller/chat_view_controller.dart';
import 'package:gokidu_app_tour/view/chat/model/room.dart';
import 'package:gokidu_app_tour/view/chat/model/user.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';

import '../../calling_page/calling_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, this.room, this.otherUser, this.isLikedByRecipient});

  final Room? room;
  final User? otherUser;
  final bool? isLikedByRecipient;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  var cntrl = Get.put(ChatViewController());
  late Animation<double> animation;
  late AnimationController controller;
  var isRecipient;
  var otherUser;
  var f_node = FocusNode();
  var isShow = true.obs;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );
    cntrl.init();
  }

  @override
  void dispose() {
    AppStorage.appStorage.remove(AppStorage.currentRoomId);
    super.dispose();
  }

  buttonClick() async {
    switch (cntrl.selectedOption) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    // case 4:
    //   cntrl.handleAudioSelection();
    //   break;
      case 5:
        break;
      case 6:
        break;
      case 7:
        break;
      case 8:
        showAppSnackbar("${cntrl.selectedOption}");
        break;
    }
    controller.reverse();
    setState(() {
      cntrl.isOpen.value = false;
    });
    setState(() {});
  }

  bottomWidget() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.maxFinite,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: CustomTextField(
                      focusNode: f_node,
                      controller: cntrl.messController,
                      readOnly: !cntrl.isOpen.value,
                      maxLine: 4,
                      minLine: 1,
                      hintText: 'Send a message',
                      validator: (p0) => ValidationHelper.isChatValidate(p0!),
                      inputType: TextInputType.multiline,
                      ontap: () async {
                        controller.reverse();
                        cntrl.isOpen.value = true;
                        setState(() {});
                      },
                      onChanged: (p0) {
                        // ValidationHelper.isChatValidate(p0);
                        controller.reverse();
                        setState(() {});
                        cntrl.isOpen.value = true;
                      },
                    )),
                const SizedBox(width: 10),
                cntrl.messController.text
                    .trim()
                    .isEmpty
                    ? Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cntrl.isOpen.value
                            ? FocusScope.of(context).unfocus()
                            : null;
                        !cntrl.isOpen.value
                            ? controller.reverse()
                            : controller.forward();
                        setState(() {});
                        cntrl.isOpen.value = !cntrl.isOpen.value;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: AppColors.primaryRed,
                          shape: BoxShape.circle,
                        ),
                        child: Transform.rotate(
                          angle: !cntrl.isOpen.value ? 150 : 0,
                          child: Custom.svgIconData(AppSvgIcons.plus),
                        ),
                      ),
                    ),
                  ],
                )
                    : InkWell(
                  onTap: () async {
                    if (_formKey.currentState?.validate() ?? false) {}
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: AppColors.primaryRed,
                      shape: BoxShape.circle,
                    ),
                    child: Custom.svgIconData(
                      AppSvgIcons.paperPlaneSend,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.only(top: 15),
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  // constraints: BoxConstraints(
                  //   maxHeight: MediaQuery.of(context).size.height * 0.40,
                  // ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColors.lightPink,
                      borderRadius: BorderRadius.circular(20)),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // crossAxisSpacing: 20.00,
                      childAspectRatio: ((MediaQuery
                          .of(context)
                          .size
                          .width -
                          (20 + 20 + 10)) /
                          2) /
                          180,
                    ),
                    itemCount: cntrl.optionList.length,
                    itemBuilder: (context, index) =>
                        GestureDetector(
                          onTap: () {
                            cntrl.selectedOption = cntrl.optionList[index].id;
                            buttonClick();
                            cntrl.isOpen.value = true;
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white),
                                  child: Custom.svgIconData(
                                      cntrl.optionList[index].image!,
                                      color: AppColors.primaryRed,
                                      size: 25),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Text(
                                    cntrl.optionList[index].name,
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  customAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 70,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: false,
      leadingWidth: 60,
      title: Padding(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Column(children: [
          GestureDetector(
            onTap: () async {
              // var user = AppStorage.getUserData();
              // bool isRecipient = user?.roleId == UserRole.donor.number;
              // // widget.otherUser?.role?.toLowerCase() ==
              // //     UserRole.recipient.value.toLowerCase();
              // await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => isRecipient
              //           ? ViewRecipient(
              //               recipientId:
              //                   int.parse(widget.otherUser!.userId.toString()),
              //               page: "chat",
              //             )
              //           : ExploreDonorDetailsPage(
              //               id: int.parse(widget.otherUser!.userId.toString()),
              //               page: "chat",
              //             ),
              //     ));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightPink,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 28,
                    weight: 1,
                  ),
                ),
              ),
              hSpace(10),
              Stack(children: [
                Container(
                  height: 40,
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: (widget.otherUser?.profilePicture ??
                        ""),
                    //CustomText.imgEndPoint +
                    errorListener: (value) {},
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        Container(
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
                ),
                if (widget.otherUser?.isOnline ?? false) ...[
                  Positioned(
                    right: 3,
                    bottom: 5,
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
              hSpace(10),
              Expanded(
                child: Text(
                    widget.otherUser?.displayName ??
                        widget.otherUser?.fullName ??
                        'N/A',
                    style: AppFontStyle.heading4
                        .copyWith(fontWeight: FontWeight.w500)),
              ),

              ///- Video Audio Call
              GestureDetector(
                onTap: (){
                  Get.to(CallingPage(
                      isVideoCall:true,
                      callToUser: widget.otherUser
                  ));
                },
                child: SvgPicture.asset(
                  AppSvgIcons.videoCall,
                  height: 30,
                  width: 30,
                ),
              ),
              const SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                  Get.to(CallingPage(
                      isVideoCall:false,
                      callToUser: widget.otherUser
                  ));
                },
                child: SvgPicture.asset(
                  AppSvgIcons.audioCall,
                  height: 30,
                  width: 30,
                ),
              ),

              ///- Video Audio Call
              Obx(() => chatAdditionalOptions()),
            ]),
          ),
          Custom.divider(padding: 0)
        ]),
      ),
    );
  }

  chatAdditionalOptions() {
    if (isShow.value && cntrl.roomData != null) {
      return Theme(
        data: Theme.of(context).copyWith(
            dividerTheme: DividerThemeData(
              color: AppColors.greyCardBorder,
            ),
            popupMenuTheme: PopupMenuThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              shadowColor: AppColors.black,
              surfaceTintColor: AppColors.white.withOpacity(0.95),
              color: AppColors.white.withOpacity(0.95),
              elevation: 8,
            )),
        child: PopupMenuButton<int>(
          offset: Offset(0, 40),
          padding: EdgeInsets.zero,
          icon: Icon(Icons.more_vert),
          onSelected: (value) async {
            f_node.unfocus();
            if (value == 3) {} else if (value == 2) {
              var otherUserId = cntrl.otherUser!.id!;
              await showDialog(
                context: context,
                builder: (context) =>
                    AlertMsgDialog(
                        title: 'Clear all chat?',
                        msg:
                        'Are you sure you want to clear all chat messages from "${cntrl
                            .otherUser?.displayName ??
                            cntrl.otherUser?.fullName}"',
                        imgColor: AppColors.redError,
                        primaryText: "Yes, Clear",
                        secondaryText: "No",
                        primaryBtnTap: () async {},
                        secondaryBtnTap: () {
                          Navigator.pop(context);
                        }),
              );
            } else if (value == 1) {}
          },
          itemBuilder: (context) =>
          [
            PopupMenuItem(
              value: 2,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Custom.svgIconData(AppSvgIcons.clearChat,
                      color: AppColors.black, size: 25),
                  hSpace(10),
                  Text(
                    "Clear chat",
                    style: AppFontStyle.blackRegular16pt
                        .copyWith(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            PopupMenuItem(
              value: 1,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Custom.svgIconData(AppSvgIcons.flagReport,
                      size: 25, color: AppColors.black),
                  hSpace(10),
                  Text(
                    "Flag ${cntrl.otherUser?.displayName ??
                        cntrl.otherUser?.fullName}",
                    style: AppFontStyle.blackRegular16pt
                        .copyWith(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            PopupMenuDivider(height: 1),
            PopupMenuItem(
              value: 3,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Custom.svgIconData(AppSvgIcons.block),
                  hSpace(10),
                  Text(
                    cntrl.roomData?.blockUser != null &&
                        cntrl.roomData!.blockUser!.contains(otherUser)
                        ? "Unblock ${cntrl.otherUser?.displayName ??
                        cntrl.otherUser?.fullName}"
                        .trim()
                        : "Block ${cntrl.otherUser?.displayName ??
                        cntrl.otherUser?.fullName}"
                        .trim(),
                    style: AppFontStyle.blackRegular16pt.copyWith(
                        color: AppColors.redError, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: cntrl.tempChat.length,
                  reverse: true,
                  itemBuilder: (context, index) => cntrl.tempChat[index],
                )),
            bottomWidget()
          ],
        ),
      ),
    );
  }
}
