import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/view/chat/model/user.dart';

class ChatController extends GetxController {
  bool error = false;
  bool initialized = false;
  User? user;
  List<User> userList = [];

  final TextEditingController searchCtrl = TextEditingController();

  var colors = const [
    Color(0xffff6767),
    Color(0xff66e0da),
    Color(0xfff5a2d9),
    Color(0xfff0c722),
    Color(0xff6a85e5),
    Color(0xfffd9a6f),
    Color(0xff92db6e),
    Color(0xff73b8e5),
    Color(0xfffd7590),
    Color(0xffc78ae5),
  ];

  @override
  void onInit() {
    // initializeFlutterFire();
    super.onInit();
  }

  

  Color getUserAvatarNameColor(User user) {
    final index = user.id.hashCode % colors.length;
    return colors[index];
  }

  DateTime nowDate = DateTime.now();
  final TextEditingController search = TextEditingController();
  final TextEditingController messController = TextEditingController();

  var chatFilterList = <LookupModelPO>[
    LookupModelPO(id: 1, name: "Unread"),
    LookupModelPO(id: 2, name: "Unanswered"),
    LookupModelPO(id: 3, name: "Blocked"),
    LookupModelPO(id: 4, name: "Archived"),
  ].obs;
  var selectChatFilter = Rxn<LookupModelPO>();
  var notificationFilterList = <LookupModelPO>[
    LookupModelPO(id: 1, name: "8 hours"),
    LookupModelPO(id: 2, name: "1 week"),
    LookupModelPO(id: 3, name: "Always"),
  ].obs;
  var selectNotificationFilter = Rxn<LookupModelPO>();

  String dateDifference(DateTime date) {
    DateTime nowDate = DateTime.now();

    return nowDate.difference(date).inMinutes != 0
        ? nowDate.difference(date).inDays != 0
            ? (nowDate.difference(date).inDays / 30 >= 1
                ? "${(nowDate.difference(date).inDays ~/ 30).toString()} ${nowDate.difference(date).inDays ~/ 30 > 1 ? "months" : "month"}"
                : "${(nowDate.difference(date).inDays).toString()} ${(nowDate.difference(date).inDays) > 1 ? "days" : "day"}")
            : nowDate.difference(date).inHours != 0
                ? "${nowDate.difference(date).inHours} h"
                : nowDate.difference(date).inMinutes != 0
                    ? "${nowDate.difference(date).inMinutes} m"
                    : ''
        : 'Just now';
  }
}
