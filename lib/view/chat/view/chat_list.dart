import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/view/chat/controller/chat_controller.dart';
import 'package:gokidu_app_tour/view/chat/model/room.dart';
import 'package:gokidu_app_tour/view/chat/model/user.dart';
import 'package:gokidu_app_tour/view/chat/view/chat_page.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';
import 'package:badges/badges.dart' as badges;

class ChatRoomList extends StatefulWidget {
  const ChatRoomList({super.key});

  @override
  State<ChatRoomList> createState() => ChatRoomListState();
}

class ChatRoomListState extends State<ChatRoomList>
    with TickerProviderStateMixin {
  final ctrl = Get.put(ChatController());
  var roomList = <Room>[].obs;

  List<Map<String, dynamic>> dummyChats = [
    {
      "createdAt": "2025-02-10T10:30:00Z",
      "id": "chat_1",
      "authorId": "101",
      "profilePicture": "https://randomuser.me/api/portraits/men/1.jpg",
      "metadata": {"lastMessage": "Hey, how are you?", "messageType": "text"},
      "fullName": "John Doe",
      "displayName": "johndoe",
      "updatedAt": "2025-02-10T12:00:00Z",
      "users": [
        {
          "Id": "101",
          "UserId": 101,
          "FullName": "John Doe",
          "DisplayName": "johndoe",
          "ProfilePicture": "https://randomuser.me/api/portraits/men/1.jpg",
          "Email": "johndoe@example.com",
          "IsOnline": true,
          "IsVerified": true,
          "Blocked": [],
          "BlockedBy": [],
          "LastSeen": "2025-02-10T12:30:00Z",
          "CreatedAt": "2024-06-15T08:45:00Z",
          "UpdatedAt": "2025-02-10T12:30:00Z",
          "Role": "donor"
        }
      ],
      "userUnreadCountInfo": 2,
      "clearChatInfo": null,
      "blockUser": [],
      "type": "private"
    },
    {
      "createdAt": "2025-02-09T14:45:00Z",
      "id": "chat_2",
      "authorId": "102",
      "profilePicture": "https://randomuser.me/api/portraits/women/2.jpg",
      "metadata": {"lastMessage": "See you tomorrow!", "messageType": "text"},
      "fullName": "Jane Smith",
      "displayName": "janesmith",
      "updatedAt": "2025-02-10T09:50:00Z",
      "users": [
        {
          "Id": "102",
          "UserId": 102,
          "FullName": "Jane Smith",
          "DisplayName": "janesmith",
          "ProfilePicture": "https://randomuser.me/api/portraits/women/2.jpg",
          "Email": "janesmith@example.com",
          "IsOnline": false,
          "IsVerified": true,
          "Blocked": [],
          "BlockedBy": [],
          "LastSeen": "2025-02-09T18:15:00Z",
          "CreatedAt": "2023-12-20T11:10:00Z",
          "UpdatedAt": "2025-02-10T10:20:00Z",
          "Role": "recipient"
        }
      ],
      "userUnreadCountInfo": 5,
      "clearChatInfo": null,
      "blockUser": ["103"],
      "type": "private"
    },
    {
      "createdAt": "2025-02-08T08:20:00Z",
      "id": "chat_3",
      "authorId": "103",
      "profilePicture": "https://randomuser.me/api/portraits/men/3.jpg",
      "metadata": {
        "lastMessage": "Let's schedule a call.",
        "messageType": "text"
      },
      "fullName": "Michael Johnson",
      "displayName": "michaelj",
      "updatedAt": "2025-02-10T08:45:00Z",
      "users": [
        {
          "Id": "103",
          "UserId": 103,
          "FullName": "Michael Johnson",
          "DisplayName": "michaelj",
          "ProfilePicture": "https://randomuser.me/api/portraits/men/3.jpg",
          "Email": "michaelj@example.com",
          "IsOnline": true,
          "IsVerified": false,
          "Blocked": [],
          "BlockedBy": ["102"],
          "LastSeen": "2025-02-10T14:05:00Z",
          "CreatedAt": "2024-02-01T09:20:00Z",
          "UpdatedAt": "2025-02-10T14:05:00Z",
          "Role": "donor"
        }
      ],
      "userUnreadCountInfo": 0,
      "clearChatInfo": null,
      "blockUser": [],
      "type": "private"
    },
    {
      "createdAt": "2025-02-07T18:00:00Z",
      "id": "chat_4",
      "authorId": "104",
      "profilePicture": "https://randomuser.me/api/portraits/women/4.jpg",
      "metadata": {
        "lastMessage": "Thank you for your help!",
        "messageType": "text"
      },
      "fullName": "Emily Davis",
      "displayName": "emilyd",
      "updatedAt": "2025-02-08T07:30:00Z",
      "users": [
        {
          "Id": "104",
          "UserId": 104,
          "FullName": "Emily Davis",
          "DisplayName": "emilyd",
          "ProfilePicture": "https://randomuser.me/api/portraits/women/4.jpg",
          "Email": "emilyd@example.com",
          "IsOnline": false,
          "IsVerified": true,
          "Blocked": [],
          "BlockedBy": [],
          "LastSeen": "2025-02-07T16:40:00Z",
          "CreatedAt": "2024-05-10T14:30:00Z",
          "UpdatedAt": "2025-02-07T16:40:00Z",
          "Role": "recipient"
        }
      ],
      "userUnreadCountInfo": 3,
      "clearChatInfo": null,
      "blockUser": [],
      "type": "private"
    },
    {
      "createdAt": "2025-02-06T11:30:00Z",
      "id": "chat_5",
      "authorId": "105",
      "profilePicture": "https://randomuser.me/api/portraits/men/5.jpg",
      "metadata": {
        "lastMessage": "Can you share the details?",
        "messageType": "text"
      },
      "fullName": "David Wilson",
      "displayName": "davidw",
      "updatedAt": "2025-02-06T19:30:00Z",
      "users": [
        {
          "Id": "105",
          "UserId": 105,
          "FullName": "David Wilson",
          "DisplayName": "davidw",
          "ProfilePicture": "https://randomuser.me/api/portraits/men/5.jpg",
          "Email": "davidw@example.com",
          "IsOnline": true,
          "IsVerified": true,
          "Blocked": [],
          "BlockedBy": [],
          "LastSeen": "2025-02-06T21:00:00Z",
          "CreatedAt": "2024-07-22T17:25:00Z",
          "UpdatedAt": "2025-02-06T21:00:00Z",
          "Role": "donor"
        }
      ],
      "userUnreadCountInfo": 1,
      "clearChatInfo": null,
      "blockUser": [],
      "type": "private"
    },
    {
      "createdAt": "2025-02-10T09:30:00Z",
      "id": "chat_1",
      "authorId": "201",
      "profilePicture": "https://randomuser.me/api/portraits/men/11.jpg",
      "metadata": {
        "lastMessage": "Hello! How’s your day?",
        "messageType": "text"
      },
      "fullName": "Robert King",
      "displayName": "robertking",
      "updatedAt": "2025-02-10T10:00:00Z",
      "users": [
        {
          "Id": "201",
          "UserId": 201,
          "FullName": "Robert King",
          "DisplayName": "robertking",
          "ProfilePicture": "https://randomuser.me/api/portraits/men/11.jpg",
          "Email": "robertking@example.com",
          "IsOnline": true,
          "IsVerified": true,
          "Blocked": [],
          "BlockedBy": [],
          "LastSeen": "2025-02-10T10:15:00Z",
          "CreatedAt": "2024-06-20T08:45:00Z",
          "UpdatedAt": "2025-02-10T10:15:00Z",
          "Role": "donor"
        }
      ],
      "userUnreadCountInfo": 3,
      "clearChatInfo": null,
      "blockUser": [],
      "type": "private"
    },
    {
      "createdAt": "2025-02-09T14:00:00Z",
      "id": "chat_2",
      "authorId": "202",
      "profilePicture": "https://randomuser.me/api/portraits/women/12.jpg",
      "metadata": {"lastMessage": "See you later!", "messageType": "text"},
      "fullName": "Sophia Martinez",
      "displayName": "sophiam",
      "updatedAt": "2025-02-10T09:30:00Z",
      "users": [
        {
          "Id": "202",
          "UserId": 202,
          "FullName": "Sophia Martinez",
          "DisplayName": "sophiam",
          "ProfilePicture": "https://randomuser.me/api/portraits/women/12.jpg",
          "Email": "sophiam@example.com",
          "IsOnline": false,
          "IsVerified": true,
          "Blocked": [],
          "BlockedBy": [],
          "LastSeen": "2025-02-09T18:10:00Z",
          "CreatedAt": "2023-12-15T11:30:00Z",
          "UpdatedAt": "2025-02-10T09:40:00Z",
          "Role": "recipient"
        }
      ],
      "userUnreadCountInfo": 6,
      "clearChatInfo": null,
      "blockUser": ["204"],
      "type": "private"
    },
    {
      "createdAt": "2025-02-08T08:50:00Z",
      "id": "chat_3",
      "authorId": "203",
      "profilePicture": "https://randomuser.me/api/portraits/men/13.jpg",
      "metadata": {"lastMessage": "Check your email.", "messageType": "text"},
      "fullName": "James Anderson",
      "displayName": "jamesa",
      "updatedAt": "2025-02-10T08:30:00Z",
      "users": [
        {
          "Id": "203",
          "UserId": 203,
          "FullName": "James Anderson",
          "DisplayName": "jamesa",
          "ProfilePicture": "https://randomuser.me/api/portraits/men/13.jpg",
          "Email": "jamesa@example.com",
          "IsOnline": true,
          "IsVerified": false,
          "Blocked": [],
          "BlockedBy": ["202"],
          "LastSeen": "2025-02-10T14:30:00Z",
          "CreatedAt": "2024-01-05T09:00:00Z",
          "UpdatedAt": "2025-02-10T14:30:00Z",
          "Role": "donor"
        }
      ],
      "userUnreadCountInfo": 1,
      "clearChatInfo": null,
      "blockUser": [],
      "type": "private"
    },
    {
      "createdAt": "2025-02-07T16:20:00Z",
      "id": "chat_4",
      "authorId": "204",
      "profilePicture": "https://randomuser.me/api/portraits/women/14.jpg",
      "metadata": {
        "lastMessage": "I'll send the details soon.",
        "messageType": "text"
      },
      "fullName": "Olivia Brown",
      "displayName": "oliviab",
      "updatedAt": "2025-02-08T07:50:00Z",
      "users": [
        {
          "Id": "204",
          "UserId": 204,
          "FullName": "Olivia Brown",
          "DisplayName": "oliviab",
          "ProfilePicture": "https://randomuser.me/api/portraits/women/14.jpg",
          "Email": "oliviab@example.com",
          "IsOnline": false,
          "IsVerified": true,
          "Blocked": [],
          "BlockedBy": [],
          "LastSeen": "2025-02-07T16:40:00Z",
          "CreatedAt": "2024-03-22T14:30:00Z",
          "UpdatedAt": "2025-02-07T16:40:00Z",
          "Role": "recipient"
        }
      ],
      "userUnreadCountInfo": 4,
      "clearChatInfo": null,
      "blockUser": [],
      "type": "private"
    },
    {
      "createdAt": "2025-02-06T11:50:00Z",
      "id": "chat_5",
      "authorId": "205",
      "profilePicture": "https://randomuser.me/api/portraits/men/15.jpg",
      "metadata": {
        "lastMessage": "Can we discuss this later?",
        "messageType": "text"
      },
      "fullName": "William Harris",
      "displayName": "willh",
      "updatedAt": "2025-02-06T19:10:00Z",
      "users": [
        {
          "Id": "205",
          "UserId": 205,
          "FullName": "William Harris",
          "DisplayName": "willh",
          "ProfilePicture": "https://randomuser.me/api/portraits/men/15.jpg",
          "Email": "willh@example.com",
          "IsOnline": true,
          "IsVerified": true,
          "Blocked": [],
          "BlockedBy": [],
          "LastSeen": "2025-02-06T21:20:00Z",
          "CreatedAt": "2024-04-25T17:25:00Z",
          "UpdatedAt": "2025-02-06T21:20:00Z",
          "Role": "donor"
        }
      ],
      "userUnreadCountInfo": 0,
      "clearChatInfo": null,
      "blockUser": [],
      "type": "private"
    }
  ];

// Add 10 more unique chat entries in the same structure...

  var initiateChatList = <Room>[].obs;
  TabController? _controller;
  var selectedIndex = Rxn<int>();
  var isRecipient;
  var badgeCount = 0.obs;

  @override
  void initState() {
    if (AppStorage.getUserData() != null) {
      isRecipient =
          AppStorage.getUserData()!.roleId == UserRole.recipient.number;
    } else {
      isRecipient = false;
    }
    init();
    super.initState();
  }

  init() async {
    _controller = TabController(length: 2, vsync: this);
    _controller?.addListener(tabListener);
    selectedIndex.value = 0;
    ctrl.searchCtrl.clear();
    for (var v in dummyChats) {
      roomList.add(Room.fromJson(v));
    }
  }

  tabListener() {
    if (_controller?.index != selectedIndex.value) {
      selectedIndex.value = _controller!.index;
    }
  }

  Widget _buildAvatar(List<User> users, Room room, bool isInitiate) {
    var otherUser = users[0];

    return Opacity(
      opacity: room.blockUser != null && room.blockUser!.contains(otherUser.id)
          ? 0.5
          : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: (room.userUnreadCountInfo ?? 0) > 0
                ? AppColors.lightPink
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(children: [
              Container(
                height: 55,
                width: 55,
                // padding: EdgeInsets.symmetric(horizontal: 5),
                child: CachedNetworkImage(
                  imageUrl: (otherUser.profilePicture ??
                      ""), //CustomText.imgEndPoint +
                  errorListener: (value) {},
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyBorder),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                  placeholder: (context, url) => Container(
                      height: 10,
                      width: 10,
                      alignment: Alignment.center,
                      child: Custom.loader()),
                  errorWidget: (context, url, error) {
                    return Container(
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(color: AppColors.greyBorder),
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
              if (otherUser.isOnline ?? false) ...[
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
            hSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          otherUser.displayName ?? otherUser.fullName ?? 'N/A',
                      style: AppFontStyle.heading4
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 19),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: otherUser.isVerified ?? false
                              ? Custom.svgIconData(AppSvgIcons.verify, size: 18)
                              : SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            hSpace(10),
            if (room.blockUser != null &&
                room.blockUser!.contains(otherUser.id)) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Custom.svgIconData(
                    AppSvgIcons.block,
                  ),
                  hSpace(5),
                  Text(
                    "Blocked",
                    style: AppFontStyle.greyRegular16pt
                        .copyWith(color: AppColors.redError),
                  )
                ],
              )
            ],
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              badges.Badge(
                position: badges.BadgePosition.topEnd(top: -25, end: 0),
                badgeAnimation: badges.BadgeAnimation.scale(),
                showBadge: (room.userUnreadCountInfo ?? 0) > 0,
                badgeStyle: badges.BadgeStyle(
                  badgeColor: AppColors.primaryRed,
                ),
                badgeContent: Text(
                  (room.userUnreadCountInfo ?? 0).toString(),
                  style: AppFontStyle.heading6
                      .copyWith(fontSize: 14, color: AppColors.white),
                ),
                child: SizedBox(),
              ),
            ]),
            if (isInitiate && isRecipient) ...[
              hSpace(15),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                      gradient: buttonGradient,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    'Accept',
                    textAlign: TextAlign.center,
                    style: AppFontStyle.blackRegular14pt.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  getUserList(List<Room> list) async {
    if (ctrl.searchCtrl.text.trim().isEmpty) {
      roomList.clear();
      for (var element in list) {
        roomList.add(element);
      }
    } else {
      for (var i = 0; i < list.length; i++) {
        var flag = 0;
        for (var element in roomList) {
          if (element.id == list[i].id) {
            flag = 1;
          }
        }
        if (flag == 1) {
          roomList.removeWhere((value) => value.id == list[i].id);
          roomList.add(list[i]);
          flag = 0;
        }
      }
    }

    initiateChatList.clear();
    for (var i = 0; i < list.length; i++) {
      initiateChatList.add(list[i]);
    }
    if (badgeCount.value != await initiateChatList.length) {
      badgeCount.value = await initiateChatList.length;
    }
  }

  appBar() {
    return AppBar(
      // title: SizedBox(),
      backgroundColor: AppColors.white,
      toolbarHeight: 0,
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: Stack(
          alignment: Alignment.center,
          children: [
            TabBar(
              indicator: BoxDecoration(color: Colors.transparent),
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
              padding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              dividerHeight: 1,
              dividerColor: AppColors.greyBorder,
              splashBorderRadius: BorderRadius.circular(100),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: AppFontStyle.blackRegular18pt
                  .copyWith(fontWeight: FontWeight.w600),
              labelColor: AppColors.primaryRed,
              unselectedLabelColor: AppColors.black,
              controller: _controller,
              tabs: [
                Tab(
                  child: Text("All"),
                ),
                Tab(
                  child: Text(isRecipient ? "New request" : "Requested"),
                )
              ],
              onTap: (value) {},
              isScrollable: false,
            ),
            Custom.svgIconData(AppSvgIcons.horizontalDiv,
                color: AppColors.greyBorder)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      appBar: appBar(),
      body: */
        Container(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              TabBar.secondary(
                indicator: BoxDecoration(color: Colors.transparent),
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                padding: EdgeInsets.all(0),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                dividerHeight: 1,
                dividerColor: AppColors.greyBorder,
                splashBorderRadius: BorderRadius.circular(100),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: AppFontStyle.blackRegular18pt
                    .copyWith(fontWeight: FontWeight.w600),
                labelColor: AppColors.primaryRed,
                unselectedLabelColor: AppColors.black,
                controller: _controller,
                tabs: [
                  Tab(
                    child: Text(
                      "All",
                    ),
                  ),
                  Tab(
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,

                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              FittedBox(
                                child: Text(isRecipient
                                    ? "New request${/*initiateChatList.isNotEmpty ? " (${initiateChatList.length}" : ""*/ ""}"
                                    : "Request sent${/*initiateChatList.isNotEmpty ? " (${initiateChatList.length}" : ""*/ ""}"),
                              ),
                              hSpace(10),
                              badges.Badge(
                                // position:
                                //     badges.BadgePosition.topEnd(top: -15, end: -50),
                                badgeAnimation: badges.BadgeAnimation.scale(),
                                showBadge: badgeCount.value != 0,
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: AppColors.primaryRed,
                                ),
                                badgeContent: Text(
                                  badgeCount.value.toString(),
                                  style: AppFontStyle.heading6.copyWith(
                                      fontSize: 14, color: AppColors.white),
                                ),
                              ),
                            ],
                          ))
                      //  Text(),
                      )
                ],
                onTap: (value) {},
                isScrollable: false,
              ),
              Custom.svgIconData(AppSvgIcons.horizontalDiv,
                  color: AppColors.greyBorder)
            ],
          ),
          Expanded(
            child: TabBarView(controller: _controller, children: [
              Obx(() => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: CustomTextField(
                          controller: ctrl.searchCtrl,
                          hintText: "Search chats ",
                          onChanged: (value) {
                            // roomList.clear();
                            // if (value.isNotEmpty) {
                            //   for (var data in snapshot.data!) {
                            //     var currentUser = data.users[0];
                            //     var str = currentUser.displayName ??
                            //         currentUser.fullName ??
                            //         "";
                            //     if (str
                            //         .toLowerCase()
                            //         .contains(value.toLowerCase())) {
                            //       roomList.add(data);
                            //     }
                            //   }
                            // } else {
                            //   getUserList(snapshot.data!);
                            // }
                          },
                          prefixIcon: Custom.svgIconData(AppSvgIcons.search,
                              color: AppColors.black),
                          validator: (p0) => null,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: roomList.length,
                          itemBuilder: (context, index) {
                            final user = roomList[index].users;
                            final room = roomList[index];
                            return GestureDetector(
                              onTap: () async {
                                Get.to(ChatPage(
                                  room: roomList[index],
                                  otherUser: roomList[index].users[0],
                                ));

                                // await chatOnPressed(
                                //     user[0].id ==
                                //             FirebaseChatCore
                                //                 .instance
                                //                 .firebaseUser
                                //                 ?.id
                                //         ? user[1].id.toString()
                                //         : user[0].id.toString(),
                                //     context);
                              },
                              child: Container(
                                // color: AppColors.lightPink,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: _buildAvatar(user, room, false),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
              Obx(
                () => ListView.builder(
                  itemCount: initiateChatList.length,
                  itemBuilder: (context, index) {
                    final user = initiateChatList[index].users;
                    final room = initiateChatList[index];
                    return GestureDetector(
                      onTap: () async {
                        // await chatOnPressed(
                        //     user[0].id ==
                        //             FirebaseChatCore
                        //                 .instance.firebaseUser?.id
                        //         ? user[1].id.toString()
                        //         : user[0].id.toString(),
                        //     context);
                        Get.to(ChatPage(
                          room: roomList[index],
                          otherUser: roomList[index].users[0],
                        ));
                      },
                      child: Container(
                        // color: AppColors.lightPink,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: _buildAvatar(user, room, true),
                      ),
                    );
                  },
                ),
              )
            ]),
          ),
        ],
        // ),
      ),
    );
  }
}
