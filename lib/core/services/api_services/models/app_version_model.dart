import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class AppVersionModel implements Decodable<AppVersionModel> {
  bool? isForcefullyUpdate;
  bool? isShowUpdateDialog;
  String? message;
  String? releaseNotes;
  AppVersionModel(
      {this.isForcefullyUpdate,
      this.isShowUpdateDialog,
      this.message,
      this.releaseNotes});

  factory AppVersionModel.fromMap(Map<String, dynamic> json) => AppVersionModel(
        isForcefullyUpdate: json["IsForcefullyUpdate"] ?? false,
        isShowUpdateDialog: json["IsShowUpdateDialog"] ?? false,
        message: json["Message"] ?? '',
        releaseNotes: json["ReleaseNotes"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "IsForcefullyUpdate": isForcefullyUpdate,
        "IsShowUpdateDialog": isShowUpdateDialog,
        "ReleaseNotes": releaseNotes,
        "Message": message,
      };

  @override
  AppVersionModel decode(json) {
    isForcefullyUpdate = json["IsForcefullyUpdate"] ?? false;
    isShowUpdateDialog = json["IsShowUpdateDialog"] ?? false;
    releaseNotes = json["ReleaseNotes"] ?? '';
    message = json["Message"] ?? '';
    return this;
  }
}
