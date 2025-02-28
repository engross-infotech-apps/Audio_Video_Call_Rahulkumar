import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';

class TextInputBottomSheet extends StatefulWidget {
  const TextInputBottomSheet(
      {super.key,
      required this.title,
      this.textInput,
      this.child,
      required this.onTap});
  final String title;
  final CustomTextField? textInput;
  final VoidCallback onTap;
  final Widget? child;

  @override
  State<TextInputBottomSheet> createState() => _TextInputBottomSheetState();
}

class _TextInputBottomSheetState extends State<TextInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      padding: EdgeInsets.only(
          right: 20,
          left: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSpace(10),
              Align(
                alignment: Alignment.center,
                child: Custom.svgIconData(AppSvgIcons.bottomSheetIcon),
              ),
              vSpace(20),
              Text(widget.title,
                  style: AppFontStyle.blackRegular16pt
                      .copyWith(fontWeight: FontWeight.w600)),
              vSpace(20),
              widget.textInput ?? SizedBox(),
              widget.child ?? SizedBox(),
              vSpace(20),
              CustomPrimaryButton(
                textValue: "Done",
                callback: widget.onTap,
              ),
              vSpace(10),
            ]),
      ),
    );
  }
}
