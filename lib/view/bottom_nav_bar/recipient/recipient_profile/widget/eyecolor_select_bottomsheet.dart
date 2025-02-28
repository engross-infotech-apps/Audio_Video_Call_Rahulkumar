// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';

// ignore: must_be_immutable
class SelectColorsBottomSheet extends StatefulWidget {
  SelectColorsBottomSheet(
      {super.key,
      required this.list,
      required this.title,
      required this.onTap,
      required this.searchable,
      required this.selectedItem,
      this.headingFont});

  final String title;
  TextStyle? headingFont;
  final List<LookupModelPO> list, selectedItem;
  final Function(List<LookupModelPO>?, List<LookupModelPO>) onTap;
  final bool searchable;

  @override
  State<SelectColorsBottomSheet> createState() =>
      _SelectColorsBottomSheetState();
}

class _SelectColorsBottomSheetState extends State<SelectColorsBottomSheet> {
  var mainList = <LookupModelPO>[];
  var searchList = <LookupModelPO>[];
  var selectedItem = <LookupModelPO>[];
  TextEditingController searchCntrl = TextEditingController();
  // LookupModelPO? selectValue;

  @override
  void initState() {
    mainList.clear();
    // mainList.addAll(widget.list);
    super.initState();

    for (var element in widget.list) {
      mainList.add(LookupModelPO(
        id: element.id,
        name: element.name,
        isSelected: element.isSelected,
        image: element.image,
        code: element.code,
      ));
      searchList.add(LookupModelPO(
        id: element.id,
        name: element.name,
        image: element.image,
        isSelected: element.isSelected,
        code: element.code,
      ));

      if (element.isSelected) {
        selectedItem.add(LookupModelPO(
            id: element.id,
            name: element.name,
            image: element.image,
            code: element.code,
            isSelected: element.isSelected));
      }
    }
  }

  isFieldEmpty(String value, String hint) {
    if (value.trim().isEmpty) {
      return 'Please enter $hint!';
    }
    return null;
  }

  bool matchValue(LookupModelPO model) {
    for (var e in selectedItem) {
      if (e.id == model.id) {
        return true;
      }
    }
    return false;
  }

  int? selectedIndex(LookupModelPO model) {
    for (int i = 0; i < selectedItem.length; i++) {
      if (selectedItem[i].id == model.id) {
        return i;
      }
    }
    return null;
  }

  int? mainListIndex(LookupModelPO model) {
    for (int i = 0; i < mainList.length; i++) {
      if (mainList[i].id == model.id) {
        return i;
      }
    }
    return null;
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
            image: mainList[i].image,
            isSelected: mainList[i].isSelected,
            code: mainList[i].code,
          ),
        );
      }
    }
    return searchList;
  }

  Widget selectView(LookupModelPO data, int index) {
    return GestureDetector(
      onTap: () {
        if (!matchValue(searchList[index])) {
          selectedItem.add(searchList[index]);
        } else {
          var i = selectedIndex(searchList[index]);
          i != null ? selectedItem.removeAt(i) : null;
        }
        var j = mainListIndex(searchList[index]);
        mainList[j!].isSelected = !mainList[j].isSelected;

        searchList[index].isSelected = !searchList[index].isSelected;
        setState(() {});
      },
      child: Container(
        width: 80,
        child: Stack(children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            Container(height: 20),
            SizedBox(
              height: 70,
              width: 70,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage(data.image!), fit: BoxFit.cover)),
              ),
            ),
            Text(data.name, style: AppFontStyle.blackRegular16pt)
          ]),
          data.isSelected
              ? Positioned(
                  top: 3,
                  right: 3,
                  child: Custom.svgIconData(AppSvgIcons.selectArrow, size: 50))
              : SizedBox(),
        ]),
      ),
    );
  }

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
              Text("Choose ${widget.title}",
                  style: widget.headingFont ??
                      AppFontStyle.blackRegular16pt
                          .copyWith(fontWeight: FontWeight.w600)),
              vSpace(10),
              widget.searchable
                  ? CustomTextField(
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
                      hintText: "Search ${widget.title}",
                      prefixIcon: Custom.svgIconData(AppSvgIcons.searchInput),
                      validator: (v) => null)
                  : SizedBox(),

              Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 2),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: ((MediaQuery.of(context).size.width -
                                  (20 + 20 + 10)) /
                              2) /
                          175,
                    ),
                    padding: EdgeInsets.all(8.0),
                    physics: BouncingScrollPhysics(),
                    itemCount: searchList.length,
                    itemBuilder: (context, index) {
                      return selectView(searchList[index], index);
                    },
                  )),
              // ),

              vSpace(20),
              CustomPrimaryButton(
                textValue: "Done",
                callback: () async {
                  if (selectedItem.isNotEmpty) {
                    selectedItem
                        .firstWhereOrNull((element) => element.id == null);
                    widget.onTap(mainList, selectedItem);
                    Get.back();
                  } else {
                    showAppToast("Please select ${widget.title}!");
                  }
                },
              ),
              vSpace(10),
            ]),
      ),
    );
  }
}
