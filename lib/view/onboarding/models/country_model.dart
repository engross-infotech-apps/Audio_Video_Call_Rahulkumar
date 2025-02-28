import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';

class CountryModel implements Decodable<CountryModel> {
  int? countryId;
  String? name;
  String? countryCode;
  String? emoji;
  String? nationality;
  String? currency;
  String? dialCode;
  LookupModelPO? modelPO;

  CountryModel({
    this.countryId,
    this.name,
    this.currency,
    this.countryCode,
    this.nationality,
    this.modelPO,
    this.emoji,
    this.dialCode,
  });

  @override
  CountryModel decode(json) {
    countryId = json["CountryId"];
    name = json["Name"];
    countryCode = json["CountryCode"];
    nationality = json["Nationality"];
    currency = json["Currency"];
    emoji = json["Emoji"] != null
        ? json["Emoji"].toString().replaceAll("\\\\", "\\")
        : "";
    dialCode = json['DialCode'];
    modelPO = LookupModelPO(
        id: json["CountryId"],
        name: json["Name"] ?? "",
        subName: json["Nationality"] ?? "",
        code: json["CountryCode"] ?? "",
        currency: json["Currency"] ?? "",
        image: json["Emoji"] != null
            ? json["Emoji"].toString().replaceAll("\\\\", "\\")
            : "");
    return this;
  }

  factory CountryModel.fromMap(Map<String, dynamic> json) => CountryModel(
        countryId: json["CountryId"],
        name: json["Name"],
        countryCode: json["CountryCode"],
        currency: json["Currency"],
        emoji: json["Emoji"],
        nationality: json["SubName"],
        dialCode: json['DialCode'],
        modelPO: LookupModelPO(
            id: json["CountryId"],
            name: json["Name"] ?? "",
            subName: json["SubName"],
            code: json["CountryCode"] ?? "",
            currency: json["Currency"] ?? "",
            image: json["Emoji"] ?? ""),
      );

  Map<String, dynamic> toMap() => {
        "CountryId": countryId,
        "Name": name,
        "SubName": nationality,
        "CountryCode": countryCode,
        "Emoji": emoji,
        "DialCode": dialCode,
        "Currency": currency,
        "ModelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}
