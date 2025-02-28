// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/function/app_function.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';
import 'package:gokidu_app_tour/widgets/tribes_alert.dart';

class SingleSelectionBottomSheet extends StatefulWidget {
  const SingleSelectionBottomSheet(
      {super.key,
      required this.list,
      required this.onTap,
      required this.searchable,
      required this.selectedItem,
      required this.title,
      this.icon,
      this.nationality = false,
      this.showImage = true,
      this.back = true,
      this.otherValue,
      this.otherCntrl});

  final List<LookupModelPO> list;
  final LookupModelPO? selectedItem;
  final Function(LookupModelPO?) onTap;
  final Function(String?)? otherValue;
  final String title;
  final bool searchable;
  final String? icon;
  final TextEditingController? otherCntrl;
  final bool nationality, back, showImage;

  @override
  State<SingleSelectionBottomSheet> createState() =>
      _SingleSelectionBottomSheetState();
}

class _SingleSelectionBottomSheetState
    extends State<SingleSelectionBottomSheet> {
  var mainList = <LookupModelPO>[];
  var searchList = <LookupModelPO>[];

  final formKey = GlobalKey<FormState>();
  final ScrollController _controller = ScrollController();

  TextEditingController searchCntrl = TextEditingController();
  TextEditingController other = TextEditingController();
  LookupModelPO? selectValue;

  @override
  void initState() {
    mainList.clear();
    super.initState();

    selectValue = widget.selectedItem;
    if (widget.otherCntrl?.text != null) {
      other.text = widget.otherCntrl?.text ?? "";
    }
    if (selectValue?.id != null) {
      other.clear();
    }

    for (var element in widget.list) {
      if (selectValue?.id == element.id &&
          selectValue?.name != null &&
          selectValue!.name.isNotEmpty) {
        mainList.removeWhere((e) => e.id == selectValue?.id);
        searchList.removeWhere((e) => e.id == selectValue?.id);
        mainList.insert(
            0,
            LookupModelPO(
              id: element.id,
              name: element.name,
              image: element.image,
              subName: element.subName,
              isSelected: element.isSelected,
              currency: element.currency,
              code: element.code,
              isFront: element.isFront,
              isBack: element.isBack,
            ));
        searchList.insert(
            0,
            LookupModelPO(
              id: element.id,
              name: element.name,
              image: element.image,
              subName: element.subName,
              isSelected: element.isSelected,
              currency: element.currency,
              code: element.code,
              isFront: element.isFront,
              isBack: element.isBack,
            ));
      } else {
        mainList.add(LookupModelPO(
          id: element.id,
          name: element.name,
          image: element.image,
          subName: element.subName,
          isSelected: element.isSelected,
          currency: element.currency,
          code: element.code,
          isFront: element.isFront,
          isBack: element.isBack,
        ));
        searchList.add(LookupModelPO(
          id: element.id,
          name: element.name,
          subName: element.subName,
          image: element.image,
          currency: element.currency,
          isSelected: element.isSelected,
          code: element.code,
          isFront: element.isFront,
          isBack: element.isBack,
        ));
      }
    }
    setState(() {});
  }

  void scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent + 100,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  List<LookupModelPO> buildSearchList(String userSearchTerm) {
    List<LookupModelPO> searchList = [];

    for (int i = 0; i < mainList.length; i++) {
      String name = widget.nationality
          ? mainList[i].subName ?? mainList[i].name
          : mainList[i].name; // ;uni
      // String subName =
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        searchList.add(
          LookupModelPO(
            id: mainList[i].id,
            name: mainList[i].name,
            subName: mainList[i].subName,
            isSelected: mainList[i].isSelected,
            currency: mainList[i].currency,
            code: mainList[i].code,
            image: mainList[i].image,
            isFront: mainList[i].isFront,
            isBack: mainList[i].isBack,
          ),
        );
      }
    }
    return searchList;
  }

  isFieldEmpty(String value, String hint) {
    if (value.trim().isEmpty) {
      return 'Please enter $hint!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75),
        padding: EdgeInsets.only(
            // right: 20,
            // left: 20,
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Select your ${widget.title}",
                      style: AppFontStyle.blackRegular16pt
                          .copyWith(fontWeight: FontWeight.w600)),
                ),
                vSpace(20),
                widget.searchable
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextField(
                            inputType: TextInputType.name,
                            controller: searchCntrl,
                            ontap: () {},
                            onChanged: (v) {
                              if (v.isNotEmpty) {
                                searchList = buildSearchList(v);
                              } else {
                                searchList.clear();
                                for (var element in widget.list) {
                                  if (selectValue?.id == element.id) {
                                    searchList.insert(
                                        0,
                                        LookupModelPO(
                                          id: element.id,
                                          name: element.name,
                                          currency: element.currency,
                                          subName: element.subName,
                                          code: element.code,
                                          isSelected: element.isSelected,
                                          isFront: element.isFront,
                                          isBack: element.isBack,
                                        ));
                                  } else {
                                    searchList.add(LookupModelPO(
                                      id: element.id,
                                      name: element.name,
                                      currency: element.currency,
                                      subName: element.subName,
                                      code: element.code,
                                      isSelected: element.isSelected,
                                      isFront: element.isFront,
                                      isBack: element.isBack,
                                    ));
                                  }
                                }
                              }
                              setState(() {});
                            },
                            hintText: "Search ${widget.title}",
                            prefixIcon:
                                Custom.svgIconData(AppSvgIcons.searchInput),
                            validator: (v) => null),
                      )
                    : SizedBox(),
                Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 2.2),
                  child: ListView.separated(
                    controller: _controller,
                    physics: BouncingScrollPhysics(),
                    itemCount: searchList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (searchList[index]
                                  .name
                                  .toLowerCase()
                                  .contains("native american") ||
                              searchList[index]
                                  .name
                                  .toLowerCase()
                                  .contains("american indian") ||
                              searchList[index]
                                  .name
                                  .toLowerCase()
                                  .contains("native hawaiian")) {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    TribesAlert(name: searchList[index].name));
                          } else {
                            selectValue = searchList[index];
                            setState(() {});
                            if (selectValue!.id != null) {
                              other.text = "";
                              widget.onTap(selectValue);
                              if (widget.back) Get.back();
                            } else {
                              scrollDown();
                            }
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          color: Colors.transparent,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            vSpace(index == 0 ? 15 : 5),
                            Row(children: [
                              searchList[index].code != null
                                  ? Text(
                                      countryCodeToEmoji(
                                          searchList[index].code!),
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  : searchList[index].image != null &&
                                          widget.showImage
                                      ? Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(
                                              searchList[index].code != null
                                                  ? 13
                                                  : 0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.lightPink),
                                          child: ClipOval(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        searchList[index]
                                                            .image!),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ))
                                      : const SizedBox(),
                              hSpace(searchList[index].code != null ||
                                      (searchList[index].image != null &&
                                          widget.showImage)
                                  ? 15
                                  : 0),
                              Expanded(
                                child: Text(
                                    widget.nationality
                                        ? searchList[index].subName ??
                                            searchList[index].name
                                        : searchList[index].name,
                                    style: AppFontStyle.greyRegular16pt),
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: selectValue != null &&
                                              selectValue!.id ==
                                                  searchList[index].id
                                          ? AppColors.primaryRed
                                          : Colors.grey,
                                      width: selectValue != null &&
                                              selectValue!.id ==
                                                  searchList[index].id
                                          ? 8
                                          : 1.5),
                                ),
                              ),
                            ]),
                            vSpace(5),
                            if (selectValue != null &&
                                widget.otherCntrl != null &&
                                selectValue?.id == null &&
                                searchList[index].id == null) ...[
                              CustomTextField(
                                controller: other,
                                hintText: "Enter your ${widget.title}",
                                validator: (v) =>
                                    isFieldEmpty(v!, widget.title),
                              ),
                              vSpace(10),
                              CustomPrimaryButton(
                                textValue: "Done",
                                callback: () async {
                                  if (selectValue != null &&
                                      (formKey.currentState?.validate() ??
                                          false)) {
                                    selectValue!.id != null
                                        ? other.text = ""
                                        : null;
                                    widget.onTap(selectValue);
                                    if (widget.back) Get.back();
                                    widget.otherCntrl != null &&
                                            selectValue!.id == null
                                        ? widget.otherValue!(other.text)
                                        : null;
                                  }
                                },
                              ),
                            ],
                            index == searchList.length - 1
                                ? vSpace(20)
                                : const SizedBox(),
                          ]),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: const Divider(
                              thickness: 1,
                              height: 1,
                            )),
                  ),
                ),
                vSpace(10),
              ]),
        ),
      ),
    );
  }
}
