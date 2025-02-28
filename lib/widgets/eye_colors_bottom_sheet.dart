// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';

class EyeColorBottomSheet extends StatefulWidget {
  const EyeColorBottomSheet({
    super.key,
    required this.list,
    required this.onTap,
    required this.searchable,
    required this.selectedItem,
    this.back = true,
  });

  final List<LookupModelPO> list;
  final LookupModelPO? selectedItem;
  final Function(LookupModelPO?) onTap;
  final bool searchable, back;

  @override
  State<EyeColorBottomSheet> createState() => _EyeColorBottomSheetState();
}

class _EyeColorBottomSheetState extends State<EyeColorBottomSheet> {
  var mainList = <LookupModelPO>[];
  var searchList = <LookupModelPO>[];

  TextEditingController searchCntrl = TextEditingController();
  LookupModelPO? selectValue;

  @override
  void initState() {
    mainList.clear();
    super.initState();
    selectValue = widget.selectedItem;

    for (var element in widget.list) {
      mainList.add(LookupModelPO(
        id: element.id,
        name: element.name,
        image: element.image,
        isSelected: element.isSelected,
        code: element.code,
      ));
      searchList.add(LookupModelPO(
        id: element.id,
        name: element.name,
        image: element.image,
        isSelected: element.isSelected,
        code: element.code,
      ));
    }
    setState(() {});
  }

  List<LookupModelPO> buildSearchList(String userSearchTerm) {
    List<LookupModelPO> searchList = [];

    for (int i = 0; i < mainList.length; i++) {
      String name = mainList[i].name;
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        searchList.add(
          LookupModelPO(
            id: mainList[i].id,
            name: mainList[i].name,
            isSelected: mainList[i].isSelected,
            code: mainList[i].code,
            image: mainList[i].image,
          ),
        );
      }
    }
    return searchList;
  }

  Widget eyeView(LookupModelPO data) {
    return GestureDetector(
      onTap: () => setState(() {
        selectValue = data;
        if (selectValue != null) {
          widget.onTap(selectValue);
          if (widget.back) Get.back();
        }
      }),
      child: Container(
        // color: Colors.yellow,
        width: 90,
        height: 90,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage(data.image!),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                vSpace(5),
                Text(data.name, style: AppFontStyle.blackRegular16pt)
              ]),
          selectValue != null && selectValue!.id == data.id
              ? Positioned(
                  top: 1,
                  right: 4,
                  child: Custom.svgIconData(AppSvgIcons.selectArrow, size: 50),
                )
              : SizedBox(),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75),
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
                Text("Select your eye color",
                    style: AppFontStyle.blackRegular16pt
                        .copyWith(fontWeight: FontWeight.w600)),
                if (widget.searchable) ...[
                  vSpace(20),
                  CustomTextField(
                      inputType: TextInputType.name,
                      controller: searchCntrl,
                      ontap: () {},
                      onChanged: (v) {
                        if (v.isNotEmpty) {
                          searchList = buildSearchList(v);
                        } else {
                          searchList.clear();
                          for (var element in widget.list) {
                            searchList.add(LookupModelPO(
                                id: element.id,
                                name: element.name,
                                code: element.code,
                                isSelected: element.isSelected));
                          }
                        }
                        setState(() {});
                      },
                      hintText: "Search eye color",
                      prefixIcon: Custom.svgIconData(AppSvgIcons.searchInput),
                      validator: (v) => null),
                ],

                Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                      ),
                      padding: EdgeInsets.all(5.0),
                      physics: BouncingScrollPhysics(),
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        return eyeView(searchList[index]);
                      },
                    )),
                // ),

                // vSpace(20),
                // CustomPrimaryButton(
                //   textValue: "Done",
                //   callback: () async {
                //     if (selectValue != null) {
                //       debugPrint("---lenth---${selectValue!.id}");
                //       widget.onTap(selectValue);
                //       Get.back();
                //     } else {
                //       showToast("Please select eye color!");
                //     }
                //   },
                // ),
                vSpace(20),
              ]),
        ),
      ),
    );
  }
}
