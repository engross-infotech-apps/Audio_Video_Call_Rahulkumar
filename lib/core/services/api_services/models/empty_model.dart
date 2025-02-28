import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class EmptyModel implements Decodable<EmptyModel> {
  @override
  EmptyModel decode(data) {
    return this;
  }
}

class DisplayNameModel implements Decodable<DisplayNameModel> {
  bool? isNameExists;

  DisplayNameModel({this.isNameExists});

  @override
  DisplayNameModel decode(json) {
    isNameExists = json["IsDisplayNameExists"];
    return this;
  }

  factory DisplayNameModel.fromMap(Map<String, dynamic> json) =>
      DisplayNameModel(isNameExists: json["IsDisplayNameExists"]);

  Map<String, dynamic> toMap() => {"IsDisplayNameExists": isNameExists};
}
