// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';

class StdTestingOption extends StatefulWidget {
  StdTestingOption({
    super.key,
    required this.onTap,
    required this.status,
    required this.title,
  });
  final String title;
  bool status;
  final Function(bool) onTap;

  @override
  State<StdTestingOption> createState() => STDTesting();
}

class STDTesting extends State<StdTestingOption> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '${widget.title} Testing',
        style: AppFontStyle.heading4,
      ),
      vSpace(10),
      Divider(thickness: 1.5, color: AppColors.greyCardBorder),
      vSpace(10),
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            widget.status = true;
            widget.onTap(widget.status);

            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.title}-Tested',
                style: AppFontStyle.greyRegular16pt,
              ),
              hSpace(10),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  widget.status = true;
                  widget.onTap(widget.status);

                  setState(() {});
                },
                child: Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: widget.status == true
                            ? AppColors.primaryRed
                            : Colors.grey,
                        width: widget.status == true ? 8 : 1.5),
                  ),
                ),
              )
            ],
          )),
      vSpace(15),
      InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          widget.status = false;
          widget.onTap(widget.status);
          setState(() {});
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '${widget.title}-Not Tested ',
            style: AppFontStyle.greyRegular16pt,
          ),
          hSpace(10),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              widget.status = false;
              widget.onTap(widget.status);

              setState(() {});
            },
            child: Container(
              width: 25,
              height: 25,
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: widget.status == false
                        ? AppColors.primaryRed
                        : Colors.grey,
                    width: widget.status == false ? 8 : 1.5),
              ),
            ),
          )
        ]),
      )
    ]);
  }
}
