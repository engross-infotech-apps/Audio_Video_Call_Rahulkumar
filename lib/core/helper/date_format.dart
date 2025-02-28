import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:intl/intl.dart';

String formatDate(String format, DateTime date) {
  return DateFormat(format).format(date.toLocal()).toString();
}

DateTime parseDate(String format, String date) {
  return DateFormat(format).parse(date).toLocal();
}

int userAge(String usersBirthDate) {
  DateTime birthDate = parseDate("dd/mm/yyyy", usersBirthDate);
  DateTime curruntDate = DateTime.now().toLocal();
  Duration parse = curruntDate.difference(birthDate).abs();
  return (parse.inDays ~/ 360);
}

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} h ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} m ago";
  }
  return "just now";
}

DateTime convertDateFromUtcTOLocal(String date) {
  return DateTime.parse(date).toLocal();
}

dateDifference(DateTime? date) {
  var nowDate = DateTime.now();
  return date != null
      ? nowDate.difference(date).inMinutes != 0
          ? nowDate.difference(date).inDays != 0
              ? (nowDate.difference(date).inDays / 30 >= 1
                  ? "${(nowDate.difference(date).inDays ~/ 30).toString()} ${nowDate.difference(date).inDays ~/ 30 > 1 ? "months" : "month"}"
                  : "${(nowDate.difference(date).inDays).toString()} ${(nowDate.difference(date).inDays) > 1 ? "days" : "day"}")
              : nowDate.difference(date).inHours != 0
                  ? "${nowDate.difference(date).inHours} h"
                  : nowDate.difference(date).inMinutes != 0
                      ? "${nowDate.difference(date).inMinutes} m"
                      : ''
          : 'Just now'
      : '';
}

Widget chatMsgString(String text, bool isSend, bool isBold, {String? svg}) {
  return Container(
    constraints: BoxConstraints(
        maxWidth: (MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                .size
                .width /
            1.8)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSend) ...[
          Text("You:",
              style: AppFontStyle.blackRegular14pt.copyWith(
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w500)),
          hSpace(2),
        ],
        if (svg != null) ...[
          Custom.svgIconData(svg, size: 14, color: AppColors.black),
          hSpace(3),
        ],
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppFontStyle.blackRegular14pt.copyWith(
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}
