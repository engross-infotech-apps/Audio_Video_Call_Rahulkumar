import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/alert_dialog.dart';

class TribesAlert extends StatelessWidget {
  const TribesAlert({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) => AlertMsgDialog(
        title: "Tribal Permission for Native American Gamete Donation",
        msg:
            '''In the U.S., when considering gamete donation from $name donors, recipients may need to follow specific tribal laws or regulations in addition to state and federal laws. Many $name tribes are sovereign entities, which means they govern themselves independently. Some tribes require that the head of the tribe or tribal council give permission for a tribal member to participate in gamete donation, especially if cultural or lineage concerns are involved. This is to ensure that tribal customs, values, and the future of the tribe are respected.
It is important to consult both legal experts and tribal representatives to ensure compliance with these unique cultural and legal requirements when engaging in donation from $name donors.''',
//"We are currently working to ensure our app complies with ${mainList[i].name} guidelines. At this time, we are unable to offer the option for users of ${mainList[i].name} ethnicity. We appreciate your patience and encourage you to check back later.",
        primaryText: "Okay",

        primaryBtnTap: () {
          Get.back();
        },
        textAlign: TextAlign.left,
      );
}
