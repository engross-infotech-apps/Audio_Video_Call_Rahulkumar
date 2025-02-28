import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
import 'package:gokidu_app_tour/core/function/app_function.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/core/theme/app_style.dart';
import 'package:gokidu_app_tour/widgets/custom_textfield.dart';

class NationalityView extends StatefulWidget {
  const NationalityView({
    super.key,
    required this.lookupList,
    required this.searchList,
    required this.list,
    required this.searchable,
    required this.onTap,
    required this.title,
  });

  final List<LookupModelPO> list;
  final List<LookupModelPO> lookupList, searchList;
  final Function(List<LookupModelPO>) onTap;
  final String title;
  final bool searchable;

  @override
  State<NationalityView> createState() => NationalityList();
}

class NationalityList extends State<NationalityView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController otherOption = TextEditingController();
  TextEditingController searchCntrl = TextEditingController();

  onSearch(String value, isNotEmpty, VoidCallback) {
    if (isNotEmpty) {
      widget.searchList.clear();
      for (var element in widget.lookupList) {
        if (element.name.toLowerCase().contains(value.toLowerCase())) {
          widget.searchList.add(LookupModelPO(
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
      widget.searchList.clear();

      for (var element in widget.lookupList) {
        widget.searchList.add(LookupModelPO(
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
    return Column(
      children: [
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
                  style: AppFontStyle.heading4
                      .copyWith(fontWeight: FontWeight.w500),
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
                    ))
              ],
            )),
        vSpace(10),
        Divider(thickness: 1.5, color: AppColors.greyCardBorder),
        vSpace(10),
        widget.searchable
            ? Form(
                key: formKey,
                child: CustomTextField(
                    inputType: TextInputType.name,
                    controller: searchCntrl,
                    ontap: () {},
                    onChanged: (v) {
                      if (v.isNotEmpty) {
                        onSearch(v, true, {setState(() {})});
                      } else {
                        onSearch(v, false, {setState(() {})});
                      }
                      setState(() {});
                    },
                    hintText: "Search ${widget.title}",
                    prefixIcon: Custom.svgIconData(
                      AppSvgIcons.searchInput,
                    ),
                    validator: (v) => null))
            : const SizedBox(),
        vSpace(10),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.searchList.length,
            itemBuilder: (context, index) {
              return InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () async {
                    await addToList(widget.searchList[index]);
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
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.searchList[index].code != null
                                      ? Row(
                                          children: [
                                            Text(
                                              countryCodeToEmoji(widget
                                                  .searchList[index].code!),
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            hSpace(10),
                                          ],
                                        )
                                      : SizedBox(),
                                  Expanded(
                                      child: Text(
                                          widget.searchList[index].name
                                              .toString(),
                                          style: AppFontStyle.greyRegular16pt
                                              .copyWith(
                                            color: AppColors.greyText,
                                          )))
                                ]),
                          ),
                          Container(
                              // color: Colors.blue,
                              height: 20,
                              width: 20,
                              padding: const EdgeInsets.only(top: 8),
                              child: Checkbox(
                                value: elementIsThere(widget.searchList[index]),
                                activeColor: MaterialStateColor.resolveWith(
                                    (states) => AppColors.primaryRed),
                                side: const BorderSide(
                                  color: Colors.grey,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                onChanged: (value) {
                                  addToList(widget.searchList[index]);
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
                              )),
                        ],
                      )));
            },
          ),
        )
      ],
    );
  }
}
