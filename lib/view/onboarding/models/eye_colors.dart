import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';

class EyeColorsModel implements Decodable<EyeColorsModel> {
  int? eyeColorId;
  String? color;
  String? image;
  LookupModelPO? modelPO;

  EyeColorsModel({
    this.eyeColorId,
    this.color,
    this.image,
    this.modelPO,
  });

  factory EyeColorsModel.fromMap(Map<String, dynamic> json) => EyeColorsModel(
      eyeColorId: json["EyeColorId"],
      color: json["Color"],
      image: json["Image"],
      modelPO: LookupModelPO(
          id: json["EyeColorId"],
          name: json["Color"] ?? "",
          image: json["Image"] ?? ""));
  @override
  EyeColorsModel decode(json) {
    eyeColorId = json["EyeColorId"];
    color = json["Color"];
    image = json["Image"];
    modelPO = LookupModelPO(
        id: json["EyeColorId"],
        name: json["Color"] ?? "",
        image: json["Image"] ?? "");
    return this;
  }

  Map<String, dynamic> toMap() => {
        "EyeColorId": eyeColorId,
        "Color": color,
        "Image": image,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}
