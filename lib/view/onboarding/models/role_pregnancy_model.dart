import 'package:flutter/material.dart';

class RolePregnancyModel {
  int value;
  String icon;
  String title;
  String description;
  VoidCallback onPress;
  bool isHidden;
  RolePregnancyModel({
    required this.value,
    required this.icon,
    required this.title,
    required this.onPress,
    required this.isHidden,
    required this.description,
  });
}
