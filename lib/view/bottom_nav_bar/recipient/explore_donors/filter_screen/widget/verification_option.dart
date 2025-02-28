// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';

class VerificationOption extends StatefulWidget {
  VerificationOption({
    super.key,
    required this.onTap,
    required this.status,
    required this.list,
  });
  bool? status;
  final Function(List<LookupModelPO>) onTap;
  final List<LookupModelPO> list;

  @override
  State<VerificationOption> createState() => Verification();
}

class Verification extends State<VerificationOption> {
  var verified = LookupModelPO(id: 1, name: "Verified");
  var notVerified = LookupModelPO(id: 2, name: "Not-Verified");
  addToList(LookupModelPO value) {
    if (!(widget.list.firstWhereOrNull((element) => element.id == value.id) !=
        null)) {
      widget.list.add(value);
    } else {
      widget.list.removeWhere(
        (element) => element.id == value.id,
      );
    }
    setState(() {});
  }

  elementIsThere(LookupModelPO value) {
    var flag = 0;
    for (var element in widget.list) {
      if (element.id == value.id) {
        flag = 1;
        return true;
      } else {
        continue;
      }
    }
    if (flag == 0) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Profile',
          style: AppFontStyle.heading4.copyWith(fontWeight: FontWeight.w500),
        ),
        vSpace(10),
        Divider(thickness: 1.5, color: AppColors.greyCardBorder),
        /*vSpace(10),
        Text(
          'The donor has confirmed their identity by uploading government-issued identification documents.',
          style: AppFontStyle.greyRegular14pt.copyWith(fontSize: 13),
        )*/
      ]),
      vSpace(20),
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            addToList(verified);
            setState(() {});
            widget.onTap(widget.list);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Verified',
                  style: AppFontStyle.greyRegular16pt,
                ),
                Container(
                  height: 20,
                  width: 20,
                  // padding: const EdgeInsets.only(top: 8),
                  child: Checkbox(
                    value: elementIsThere(verified),
                    activeColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.primaryRed),
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    onChanged: (value) {
                      addToList(verified);
                      setState(() {});
                      widget.onTap(widget.list);
                    },
                  ),
                ),
                // InkWell(
                //   splashColor: Colors.transparent,
                //   focusColor: Colors.transparent,
                //   onTap: () {
                //     widget.status = false;

                //     addToList(verified);
                //     setState(() {});
                //     widget.onTap(widget.list);
                //   },
                //   child: Container(
                //     width: 25,
                //     height: 25,
                //     // margin: EdgeInsets.only(top: 3),
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       border: Border.all(
                //           color: widget.status != null && widget.status == true
                //               ? AppColors.primaryRed
                //               : Colors.grey,
                //           width: widget.status == true ? 8 : 1.5),
                //     ),
                //   ),
                // )
              ],
            ),
          )),
      vSpace(15),
      InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          addToList(notVerified);
          setState(() {});
          widget.onTap(widget.list);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          color: Colors.transparent,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Not-Verified',
                  style: AppFontStyle.greyRegular16pt,
                ),
                Container(
                  height: 20,
                  width: 20,
                  // padding: const EdgeInsets.only(top: 8),
                  child: Checkbox(
                    value: elementIsThere(notVerified),
                    activeColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.primaryRed),
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    onChanged: (value) {
                      addToList(notVerified);
                      setState(() {});
                      widget.onTap(widget.list);
                    },
                  ),
                ),
                // InkWell(
                //   splashColor: Colors.transparent,
                //   focusColor: Colors.transparent,
                //   onTap: () {
                //     widget.status = false;
                //     var data = LookupModelPO(id: 2, name: "Not-Verified");
                //     addToList(data);
                //     setState(() {});
                //     widget.onTap(widget.list);
                //   },
                //   child: Container(
                //     width: 25,
                //     height: 25,
                //     // margin: EdgeInsets.only(top: 5),
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       border: Border.all(
                //           color: widget.status != null && widget.status == false
                //               ? AppColors.primaryRed
                //               : Colors.grey,
                //           width: widget.status == false ? 8 : 1.5),
                //     ),
                //   ),
                // )
              ]),
        ),
      ),
    ]);
  }
}
