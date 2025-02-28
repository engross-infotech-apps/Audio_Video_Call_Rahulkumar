import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/tribes_alert.dart';

class EthnicityView extends StatefulWidget {
  const EthnicityView({
    super.key,
    required this.lookupList,
    required this.list,
    this.otherValue,
    required this.onTap,
    this.othercntrl,
    required this.title,
  });

  final List<LookupModelPO> list;
  final List<LookupModelPO> lookupList;
  final Function(List<LookupModelPO>) onTap;
  final String title;
  final TextEditingController? othercntrl;
  final Function(String?)? otherValue;

  @override
  State<EthnicityView> createState() => EthnicityList();
}

class EthnicityList extends State<EthnicityView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController otherOption = TextEditingController();
  TextEditingController searchCntrl = TextEditingController();
/* if (selectedItem.name
                                                .toLowerCase()
                                                .contains("native american") ||
                                            selectedItem.name
                                                .toLowerCase()
                                                .contains("american indian") ||
                                            selectedItem.name
                                                .toLowerCase()
                                                .contains("native hawaiian")) {
                                          await Future.delayed(
                                            Duration.zero,
                                            () {
                                              Get.back();
                                            },
                                          );
                                          await showDialog(
                                              context: context,
                                              builder: (context) => TribesAlert(name: 
                      element.name));

                                          cntrl.selectedEthnicity.value = null;
                                          cntrl.ethnicityCntrl.text = "";
                                         */

  addToList(LookupModelPO value) {
    if (widget.list
            .firstWhere(
              (element) => element.id == value.id,
              orElse: () => LookupModelPO(id: -1, name: ""),
            )
            .id ==
        -1) {
      if (value.name.toLowerCase().contains("native american") ||
          value.name.toLowerCase().contains("american indian") ||
          value.name.toLowerCase().contains("native hawaiian")) {
        showDialog(
            context: context,
            builder: (context) => TribesAlert(name: value.name));
      } else {
        widget.list.add(value);
      }
    } else {
      widget.list.removeWhere((element) => element.id == value.id);
    }
    // }
    setState(() {});
  }

  elementIsThere(LookupModelPO value) {
    var flage = 0;
    for (var element in widget.list) {
      if (element.id == value.id) {
        flage = 1;
        return true;
      } else {
        continue;
      }
    }
    if (flage == 0) {
      return false;
    }
  }

  var all = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () async {
            setState(() {
              all = !all;
            });
            widget.list.clear();
            if (all) {
              var isTribe = false;
              for (LookupModelPO element in widget.lookupList) {
                if (element.name.toLowerCase().contains("native american") ||
                    element.name.toLowerCase().contains("american indian") ||
                    element.name.toLowerCase().contains("native hawaiian")) {
                  isTribe = true;
                } else {
                  widget.list.add(element);
                }
              }
              if (isTribe) {
                showDialog(
                    context: context,
                    builder: (context) => TribesAlert(
                        name: "native american or native hawaiian"));
              }
            } else {
              widget.list.clear();
            }
            if (widget.lookupList.length == widget.list) {
              all = true;
            } else {
              all = false;
            }
            await widget.onTap(widget.list);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style:
                    AppFontStyle.heading4.copyWith(fontWeight: FontWeight.w500),
              ),
              Container(
                height: 20,
                width: 20,
                padding: const EdgeInsets.only(top: 10),
                child: Checkbox(
                  value: widget.list.isEmpty
                      ? all = false
                      : widget.list.length == widget.lookupList.length
                          ? all = true
                          : all,
                  activeColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.primaryRed),
                  side: const BorderSide(
                    color: Colors.grey,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  onChanged: (v) async {
                    setState(() {
                      all = !all;
                    });
                    widget.list.clear();
                    if (all) {
                      var isTribe = false;
                      for (LookupModelPO element in widget.lookupList) {
                        if (element.name
                                .toLowerCase()
                                .contains("native american") ||
                            element.name
                                .toLowerCase()
                                .contains("american indian") ||
                            element.name
                                .toLowerCase()
                                .contains("native hawaiian")) {
                          isTribe = true;
                        } else {
                          widget.list.add(element);
                        }
                      }
                      if (isTribe) {
                        showDialog(
                            context: context,
                            builder: (context) => TribesAlert(
                                name: "native american or native hawaiian"));
                      }
                    } else {
                      widget.list.clear();
                    }

                    if (widget.lookupList.length == widget.list) {
                      all = true;
                    } else {
                      all = false;
                    }
                    await widget.onTap(widget.list);
                  },
                ),
              )
            ],
          )),
      vSpace(10),
      Divider(thickness: 1.5, color: AppColors.greyCardBorder),
      vSpace(10),
      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.lookupList.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () async {
                await addToList(widget.lookupList[index]);
                setState(() {});
                if (widget.lookupList.length == widget.list.length) {
                  setState(() {
                    all = true;
                  });
                } else {
                  setState(() {
                    all = false;
                  });
                }
                await widget.onTap(widget.list);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.lookupList[index].name.toString(),
                          style: AppFontStyle.greyRegular16pt.copyWith(
                            color: AppColors.greyText,
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.blue,
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.only(top: 8),
                        child: Checkbox(
                          value: elementIsThere(widget.lookupList[index]),
                          activeColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.primaryRed),
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          onChanged: (value) {
                            addToList(widget.lookupList[index]);
                            setState(() {});
                            if (widget.lookupList.length ==
                                widget.list.length) {
                              setState(() {
                                all = true;
                              });
                            } else {
                              setState(() {
                                all = false;
                              });
                            }
                          },
                        ),
                      ),
                    ]),
              ),
            );
          },
        ),
      )
    ]);
  }
}
