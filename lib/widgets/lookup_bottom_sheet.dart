import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_buttons.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/common/dialogs.dart';
import 'package:gokidu_app_tour/core/function/app_function.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';
import 'package:gokidu_app_tour/widgets/tribes_alert.dart';

class LookupBottomSheet extends StatefulWidget {
  LookupBottomSheet(
      {super.key,
      required this.list,
      required this.onTap,
      required this.searchable,
      this.otherEthnicityValue,
      this.otherEthnicitycntrl,
      this.shouldRequested = false,
      this.additionalTitle = false,
      this.isRequestedTap,
      required this.title});

  final List<LookupModelPO> list;

  final Function(List<LookupModelPO>, List<LookupModelPO>) onTap;
  final String title;
  final bool searchable;
  final bool additionalTitle;
  final bool shouldRequested;
  final TextEditingController? otherEthnicitycntrl;
  final Function(String?)? otherEthnicityValue;
  final Function(String?)? isRequestedTap;

  @override
  State<LookupBottomSheet> createState() => _LookupBottomSheetState();
}

class _LookupBottomSheetState extends State<LookupBottomSheet> {
  final formKey = GlobalKey<FormState>();

  var mainList = <LookupModelPO>[];
  var searchList = <LookupModelPO>[];
  var selectedItem = <LookupModelPO>[];
  var isAllSelect = false;
  TextEditingController otherEthnicity = TextEditingController();
  TextEditingController searchCntrl = TextEditingController();

  @override
  void initState() {
    mainList.clear();
    // mainList.addAll(widget.list);
    super.initState();

    if (widget.otherEthnicitycntrl?.text != null) {
      otherEthnicity.text = widget.otherEthnicitycntrl?.text ?? "";
    }
    // if (selectedItem.id != null) {
    //   otherEthnicity.clear();
    // }

    for (var element in widget.list) {
      mainList.add(LookupModelPO(
        id: element.id,
        name: element.name,
        isSelected: element.isSelected,
        code: element.code,
        isRequested: element.isRequested,
      ));
      searchList.add(LookupModelPO(
        id: element.id,
        name: element.name,
        isSelected: element.isSelected,
        isRequested: element.isRequested,
        code: element.code,
      ));

      if (element.isSelected) {
        selectedItem.add(LookupModelPO(
            id: element.id,
            name: element.name,
            isRequested: element.isRequested,
            code: element.code,
            isSelected: element.isSelected));
      }
    }
    isAllSelect = selectedItem.length == mainList.length;
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
            isSelected: mainList[i].isSelected,
            isRequested: mainList[i].isRequested,
            code: mainList[i].code,
          ),
        );
      }
    }
    return searchList;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.75,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.80),
        padding: EdgeInsets.only(
            // left: 20,
            // right: 20,
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
                  child: Text(
                      "${widget.additionalTitle ? "" : "Choose"} ${widget.title}",
                      style: AppFontStyle.blackRegular16pt
                          .copyWith(fontWeight: FontWeight.w600)),
                ),
                vSpace(widget.searchable ? 10 : 0),
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
                                  searchList.add(LookupModelPO(
                                      id: element.id,
                                      name: element.name,
                                      code: element.code,
                                      isRequested: element.isRequested,
                                      isSelected: element.isSelected));
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
                vSpace(10),
                Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 2.15),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: searchList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        index == 0
                            ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      isAllSelect = !isAllSelect;
                                      selectedItem.clear();
                                      var isRequestd = false;
                                      for (int i = 0;
                                          i < mainList.length;
                                          i++) {
                                        if (isAllSelect) {
                                          if (widget.shouldRequested ==
                                              searchList[i].isRequested) {
                                            if (mainList[i].name.toLowerCase().contains("native american") ||
                                                mainList[i]
                                                    .name
                                                    .toLowerCase()
                                                    .contains(
                                                        "american indian") ||
                                                mainList[i]
                                                    .name
                                                    .toLowerCase()
                                                    .contains(
                                                        "native hawaiian")) {
                                              continue;
                                            } else {
                                              mainList[i].isSelected =
                                                  isAllSelect;

                                              selectedItem.add(mainList[i]);
                                            }
                                          } else {
                                            isRequestd = true;
                                            continue;
                                          }
                                        }
                                      }
                                      for (int i = 0;
                                          i < searchList.length;
                                          i++) {
                                        if (mainList[i]
                                                .name
                                                .toLowerCase()
                                                .contains("native american") ||
                                            mainList[i]
                                                .name
                                                .toLowerCase()
                                                .contains("american indian") ||
                                            mainList[i]
                                                .name
                                                .toLowerCase()
                                                .contains("native hawaiian") ||
                                            (widget.shouldRequested !=
                                                searchList[i].isRequested)) {
                                          continue;
                                        } else {
                                          searchList[i].isSelected =
                                              isAllSelect;
                                        }
                                      }
                                      if (isAllSelect &&
                                          mainList.firstWhereOrNull((element) =>
                                                  element.name.toLowerCase().contains("native american") ||
                                                  element.name
                                                      .toLowerCase()
                                                      .contains(
                                                          "american indian") ||
                                                  element.name
                                                      .toLowerCase()
                                                      .contains(
                                                          "native hawaiian")) !=
                                              null) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => TribesAlert(
                                                name:
                                                    "native american or native hawaiian"));
                                      }

                                      if (selectedItem.length ==
                                          mainList.length) {
                                        isAllSelect = true;
                                      } else {
                                        isAllSelect = false;
                                      }
                                      if (isRequestd) {
                                        if (widget.isRequestedTap != null)
                                          widget.isRequestedTap!(null);
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text("All",
                                                style: AppFontStyle
                                                    .greyRegular16pt),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: Checkbox(
                                              side: BorderSide(
                                                  color: AppColors.greyBorder),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                              activeColor: AppColors.primaryRed,
                                              value: isAllSelect,
                                              onChanged: (value) {
                                                isAllSelect = !isAllSelect;
                                                selectedItem.clear();
                                                var isRequestd = false;
                                                for (int i = 0;
                                                    i < mainList.length;
                                                    i++) {
                                                  if (isAllSelect) {
                                                    if (widget
                                                            .shouldRequested ==
                                                        searchList[i]
                                                            .isRequested) {
                                                      if (mainList[i].name.toLowerCase().contains("native american") ||
                                                          mainList[i]
                                                              .name
                                                              .toLowerCase()
                                                              .contains(
                                                                  "american indian") ||
                                                          mainList[i]
                                                              .name
                                                              .toLowerCase()
                                                              .contains(
                                                                  "native hawaiian")) {
                                                        continue;
                                                      } else {
                                                        mainList[i].isSelected =
                                                            isAllSelect;

                                                        selectedItem
                                                            .add(mainList[i]);
                                                      }
                                                    } else {
                                                      isRequestd = true;
                                                      continue;
                                                    }
                                                  }
                                                }
                                                for (int i = 0;
                                                    i < searchList.length;
                                                    i++) {
                                                  if (mainList[i].name.toLowerCase().contains("native american") ||
                                                      mainList[i]
                                                          .name
                                                          .toLowerCase()
                                                          .contains(
                                                              "american indian") ||
                                                      mainList[i]
                                                          .name
                                                          .toLowerCase()
                                                          .contains(
                                                              "native hawaiian") ||
                                                      (widget.shouldRequested !=
                                                          searchList[i]
                                                              .isRequested)) {
                                                    continue;
                                                  } else {
                                                    searchList[i].isSelected =
                                                        isAllSelect;
                                                  }
                                                }
                                                if (isAllSelect &&
                                                    mainList.firstWhereOrNull((element) =>
                                                            element.name.toLowerCase().contains("native american") ||
                                                            element.name
                                                                .toLowerCase()
                                                                .contains(
                                                                    "american indian") ||
                                                            element.name
                                                                .toLowerCase()
                                                                .contains(
                                                                    "native hawaiian")) !=
                                                        null) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          TribesAlert(
                                                              name:
                                                                  "native american or native hawaiian"));
                                                }

                                                if (selectedItem.length ==
                                                    mainList.length) {
                                                  isAllSelect = true;
                                                } else {
                                                  isAllSelect = false;
                                                }
                                                if (isRequestd) {
                                                  if (widget.isRequestedTap !=
                                                      null)
                                                    widget
                                                        .isRequestedTap!(null);
                                                }
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Divider(
                                        thickness: 1,
                                        height: 1,
                                      ))
                                ],
                              )
                            : SizedBox(),
                        GestureDetector(
                          onTap: () {
                            if (widget.shouldRequested ==
                                searchList[index].isRequested) {
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
                                    builder: (context) => TribesAlert(
                                        name: searchList[index].name));
                              } else {
                                if (!matchValue(searchList[index])) {
                                  selectedItem.add(searchList[index]);
                                } else {
                                  var i = selectedIndex(searchList[index]);
                                  i != null ? selectedItem.removeAt(i) : null;
                                }
                                var j = mainListIndex(searchList[index]);
                                mainList[j!].isSelected =
                                    !mainList[j].isSelected;

                                searchList[index].isSelected =
                                    !searchList[index].isSelected;
                                isAllSelect =
                                    selectedItem.length == mainList.length;
                              }
                              setState(() {});
                            } else {
                              if (widget.isRequestedTap != null)
                                widget.isRequestedTap!(searchList[index].name);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            color: Colors.transparent,
                            child: Row(children: [
                              searchList[index].code != null
                                  ? Text(
                                      countryCodeToEmoji(
                                          searchList[index].code!),
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  : SizedBox(),
                              hSpace(searchList[index].code != null ? 15 : 0),
                              Expanded(
                                child: Text(
                                    searchList[index].subName ??
                                        searchList[index].name,
                                    style: AppFontStyle.greyRegular16pt),
                              ),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Checkbox(
                                  side: BorderSide(color: AppColors.greyBorder),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                  activeColor: AppColors.primaryRed,
                                  value: searchList[index].isSelected,
                                  onChanged: (value) {
                                    if (widget.shouldRequested ==
                                        searchList[index].isRequested) {
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
                                            builder: (context) => TribesAlert(
                                                name: searchList[index].name));
                                      } else {
                                        if (!matchValue(searchList[index])) {
                                          selectedItem.add(searchList[index]);
                                        } else {
                                          var i =
                                              selectedIndex(searchList[index]);
                                          i != null
                                              ? selectedItem.removeAt(i)
                                              : null;
                                        }
                                        var j =
                                            mainListIndex(searchList[index]);
                                        mainList[j!].isSelected =
                                            !mainList[j].isSelected;

                                        searchList[index].isSelected =
                                            !searchList[index].isSelected;
                                        isAllSelect = selectedItem.length ==
                                            mainList.length;
                                      }
                                    } else {
                                      if (widget.isRequestedTap != null)
                                        widget.isRequestedTap!(
                                            searchList[index].name);
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            ]),
                          ),
                        ),
                        if (searchList[index].isSelected &&
                            widget.otherEthnicitycntrl != null &&
                            searchList[index].id == null) ...[
                          vSpace(5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextField(
                              controller: otherEthnicity,
                              hintText: "Enter your ethnicity",
                              validator: (v) => isFieldEmpty(v!, "ethnicity"),
                            ),
                          ),
                        ],
                        index == mainList.length - 1
                            ? vSpace(20)
                            : const SizedBox(),
                      ]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                vSpace(10),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomPrimaryButton(
                      textValue: "Done",
                      callback: () async {
                        if (selectedItem.isNotEmpty &&
                            (formKey.currentState?.validate() ?? false)) {
                          var itemData = selectedItem.firstWhereOrNull(
                              (element) => element.id == null);
                          itemData == null ? otherEthnicity.text = "" : null;
                          widget.onTap(mainList, selectedItem);
                          Get.back();
                          widget.otherEthnicitycntrl != null &&
                                  selectedItem.isNotEmpty
                              ? widget.otherEthnicityValue!(otherEthnicity.text)
                              : null;
                        } else {
                          showAppToast("Please select ${widget.title}!");
                        }
                      },
                    ),
                  ),
                ),
                vSpace(10),
              ]),
        ),
      ),
    );
  }
}
