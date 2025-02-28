import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class UploadImageModel implements Decodable<UploadImageModel> {
  String? originalUrl;
  // String? signedUrl;
  String? name;

  UploadImageModel({
    this.originalUrl,
    // this.signedUrl,
    this.name,
  });

  @override
  UploadImageModel decode(json) {
    originalUrl = json["url"];
    // signedUrl = json["signedUrl"];
    name = json["name"];

    return this;
  }

  factory UploadImageModel.fromMap(Map<String, dynamic> json) =>
      UploadImageModel(
        originalUrl: json["originalUrl"],
        // signedUrl: json["signedUrl"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "originalUrl": originalUrl,
        // "signedUrl": signedUrl,
        "name": name,
      };
}

class PickedImageModel {
  String? image;
  String? imgUrl;
  UploadImageStatus? imgStatus;
  bool? isExisting;
  int? imageId;

  PickedImageModel({
    this.image,
    this.imgUrl,
    this.imgStatus,
    this.isExisting,
    this.imageId,
  });
}
