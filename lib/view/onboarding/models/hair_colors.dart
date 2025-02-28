import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';

class HairColorsModel implements Decodable<HairColorsModel> {
  int? hairColorId;
  String? color;
  String? image;
  LookupModelPO? modelPO;

  HairColorsModel({
    this.hairColorId,
    this.color,
    this.image,
    this.modelPO,
  });

  factory HairColorsModel.fromMap(Map<String, dynamic> json) => HairColorsModel(
      hairColorId: json["HairColorId"],
      color: json["Color"],
      image: json["Image"],
      modelPO: LookupModelPO(
          id: json["HairColorId"],
          name: json["Color"] ?? "",
          image: json["Image"] ?? ""));
  @override
  HairColorsModel decode(json) {
    hairColorId = json["HairColorId"];
    color = json["Color"];
    image = json["Image"];
    modelPO = LookupModelPO(
        id: json["HairColorId"],
        name: json["Color"] ?? "",
        image: json["Image"] ?? "");
    return this;
  }

  Map<String, dynamic> toMap() => {
        "HairColorId": hairColorId,
        "Color": color,
        "Image": image,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}
