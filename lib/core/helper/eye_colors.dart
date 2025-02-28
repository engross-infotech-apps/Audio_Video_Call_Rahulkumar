import 'dart:convert';

import 'package:gokidu_app_tour/view/onboarding/models/eye_colors.dart';

class EyeColorHelper {
  static var jsonData = """[
    {
      "EyeColorId": 1,
      "Color": "Green",
      "Image": "assets/images/eye_colors_img/green.png"
    },
    {
      "EyeColorId": 2,
      "Color": "Hazel",
      "Image": "assets/images/eye_colors_img/hazel.png"
    },
    {
      "EyeColorId": 3,
      "Color": "Gray",
      "Image": "assets/images/eye_colors_img/gray.png"
    },
    {
      "EyeColorId": 4,
      "Color": "Brown",
      "Image": "assets/images/eye_colors_img/brown.png"
    },
    {
      "EyeColorId": 5,
      "Color": "Black",
      "Image": "assets/images/eye_colors_img/black.png"
    },
    {
      "EyeColorId": 6,
      "Color": "Blue",
      "Image": "assets/images/eye_colors_img/blue.png"
    }
]""";

  static List<EyeColorsModel> getEyeColors() {
    List data = jsonDecode(jsonData);
    var eyeList = data.map((e) => EyeColorsModel.fromMap(e)).toList();
    return eyeList;
  }
}
