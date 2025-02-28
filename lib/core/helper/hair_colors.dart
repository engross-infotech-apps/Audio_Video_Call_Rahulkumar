import 'dart:convert';
import 'package:gokidu_app_tour/view/onboarding/models/hair_colors.dart';

class HairColorsHelper {
  static var jsonData = """[
    {
      "HairColorId": 1,
      "Color": "Auburn",
      "Image": "assets/images/hair_colors_img/auburn.png"
    },
    {
      "HairColorId": 2,
      "Color": "Black",
      "Image": "assets/images/hair_colors_img/black.png"
    },
    {
      "HairColorId": 3,
      "Color": "Blonde",
      "Image": "assets/images/hair_colors_img/blonde.png"
    },
    {
      "HairColorId": 4,
      "Color": "Brown",
      "Image": "assets/images/hair_colors_img/brown.png"
    },
    {
      "HairColorId": 5,
      "Color": "Red",
      "Image": "assets/images/hair_colors_img/red.png"
    }
]""";

  static List<HairColorsModel> getHairColors() {
    List data = jsonDecode(jsonData);
    var hairList = data.map((e) => HairColorsModel.fromMap(e)).toList();
    return hairList;
  }
}
