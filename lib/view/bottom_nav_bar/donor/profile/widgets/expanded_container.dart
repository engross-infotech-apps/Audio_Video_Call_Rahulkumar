// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';

class ExpandedContainer extends StatefulWidget {
  ExpandedContainer(
      {super.key,
      required this.title,
      required this.child,
      this.divider = true,
      this.isExpanded = false,
      this.controller,
      this.ontap});
  final String title;
  final Widget child;
  bool divider;
  bool isExpanded;
  ExpansionTileController? controller;
  Function(bool)? ontap;
  @override
  State<ExpandedContainer> createState() => ExpandedContainerState();
}

class ExpandedContainerState extends State<ExpandedContainer> {
  bool isExpanded = false;
  @override
  void initState() {
    isExpanded = widget.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            controller: widget.controller,
            iconColor: AppColors.greyText,
            collapsedIconColor: AppColors.greyText,
            tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            childrenPadding: EdgeInsets.zero,
            onExpansionChanged: (value) {
              widget.ontap != null ? widget.ontap!(value) : null;
            },
            title: Text(
              widget.title,
              style: AppFontStyle.heading4
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    child: widget.child),
              ),
            ]),
      ),
      widget.divider
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                  thickness: 1.5, height: 1.5, color: AppColors.greyCardBorder),
            )
          : SizedBox(),
    ]);

    // Column(children: [
    //   GestureDetector(
    //     onTap: () {
    //       isExpanded = !isExpanded;
    //       setState(() {});
    //     },
    //     child: Container(
    //       color: Colors.transparent,
    //       padding: EdgeInsets.symmetric(vertical: 15),
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 20),
    //         child: Row(children: [
    //           Expanded(
    //             child: Text(
    //               widget.title,
    //               style: AppFontStyle.heading4
    //                   .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
    //             ),
    //           ),
    //           Container(
    //             color: Colors.transparent,
    //             child: Custom.svgIconData(
    //                 isExpanded
    //                     ? AppSvgIcons.expandless
    //                     : AppSvgIcons.expandMore,
    //                 fit: BoxFit.scaleDown,
    //                 size: 18, ontap: () {
    //               isExpanded = !isExpanded;
    //               setState(() {});
    //             }),
    //           ),
    //         ]),
    //       ),
    //     ),
    //   ),
    //   isExpanded
    //       ? Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           child: widget.child)
    //       : SizedBox(),
    //   widget.divider
    //       ? Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           child: Divider(thickness: 1.5, color: AppColors.greyCardBorder),
    //         )
    //       : SizedBox(),
    // ]);
  }
}
