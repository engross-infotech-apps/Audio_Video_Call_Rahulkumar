// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';

class AgeView extends StatefulWidget {
  const AgeView({
    super.key,
    required this.lookupList,
    required this.list,
    required this.onTap,
    required this.title,
  });

  final List<LookupModelPO> list;
  final List<LookupModelPO> lookupList;
  final Function(List<LookupModelPO>) onTap;
  final String title;

  @override
  State<AgeView> createState() => AgeList();
}

class AgeList extends State<AgeView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController otherOption = TextEditingController();
  TextEditingController searchCntrl = TextEditingController();

  onSearch(String value, isNotEmpty, VoidCallback) {
    if (isNotEmpty) {
      widget.lookupList.clear();
      for (var element in widget.lookupList) {
        if (element.name.toLowerCase().contains(value.toLowerCase())) {
          widget.lookupList.add(LookupModelPO(
            id: element.id,
            name: element.name,
            image: element.image ?? null,
            isSelected: element.isSelected,
            code: element.code,
          ));
        } else {
          continue;
        }
      }
    } else {
      widget.lookupList.clear();

      for (var element in widget.lookupList) {
        widget.lookupList.add(LookupModelPO(
          id: element.id,
          name: element.name,
          image: element.image ?? null,
          isSelected: element.isSelected,
          code: element.code,
        ));
      }
    }
  }

  addToList(LookupModelPO value) {
    if (!widget.list.contains(value)) {
      widget.list.add(value);
    } else {
      widget.list.remove(value);
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
          if (all) {
            for (LookupModelPO element in widget.lookupList) {
              widget.list.add(element);
            }
          } else {
            widget.list.clear();
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
                  onChanged: (value) async {
                    setState(() {
                      all = !all;
                    });
                    if (all) {
                      for (LookupModelPO element in widget.lookupList) {
                        widget.list.add(element);
                      }
                    } else {
                      widget.list.clear();
                    }
                    await widget.onTap(widget.list);
                  },
                ),
              )
            ]),
      ),
      vSpace(10),
      Divider(thickness: 1.5, color: AppColors.greyCardBorder),
      vSpace(10),
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: widget.lookupList.length,
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
                        hSpace(10),
                        Container(
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
            }),
      ),
    ]);
  }
}
