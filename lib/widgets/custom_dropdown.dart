import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gokidu_app_tour/core/common/app_size.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.hintText,
      required this.list,
      this.onChange,
      this.title,
      this.fillColor,
      required this.validation,
      this.initValue});

  final String hintText;
  final String? title;
  final List<LookupModelPO> list;
  final Function(LookupModelPO?)? onChange;
  final Color? fillColor;
  final LookupModelPO? initValue;
  final String? Function(LookupModelPO?)? validation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        title != null
            ? Text(title!, style: AppFontStyle.greyRegular16pt)
            : SizedBox(),
        vSpace(title != null ? 10 : 0),
        DropdownButtonFormField(
          value: initValue,
          isDense: true,
          elevation: 0,
          isExpanded: true,
          alignment: AlignmentDirectional.centerEnd,
          menuMaxHeight: AppScreenSize.height / 2,
          items: list.map((LookupModelPO item) {
            return DropdownMenuItem(
              value: item,
              child: SizedBox(
                child: Text(
                  item.name,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            );
          }).toList(),
          onChanged: onChange,
          icon: Custom.svgIconData(AppSvgIcons.expandMore),
          disabledHint: Text(hintText,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              )),
          iconDisabledColor: AppColors.greyText,
          iconEnabledColor: AppColors.black,
          validator: validation,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: decoration(hintText, fillColor),
        ),
      ]),
    );
  }
}
