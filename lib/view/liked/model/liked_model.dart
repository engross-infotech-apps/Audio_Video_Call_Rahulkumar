import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class LikeDataModel extends Decodable<LikeDataModel> {
  int? totalCount;
  List<LikeModel>? likes;
  LikeDataModel({this.likes, this.totalCount});

  factory LikeDataModel.fromMap(Map<String, dynamic> json) => LikeDataModel(
        totalCount: json["TotalCount"],
        likes: List<LikeModel>.from(
            json["likes"].map((x) => LikeModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TotalCount": totalCount,
        "likes": likes != null
            ? List<dynamic>.from(likes!.map((x) => x.toMap()))
            : [],
      };

  @override
  LikeDataModel decode(json) {
    totalCount = json["TotalCount"];
    likes =
        List<LikeModel>.from(json["likes"].map((x) => LikeModel.fromMap(x)));
    return this;
  }
}

class LikeModel {
  int? userId;
  String? fullName;
  String? displayName;
  String? profilePicture;
  String? city;
  String? state;
  dynamic isVerified;
  int? actionType, age;
  DateTime? createdDate;
  bool? actionByYou;
  bool? isOnline, isRead;

  LikeModel({
    this.userId,
    this.fullName,
    this.displayName,
    this.profilePicture,
    this.city,
    this.state,
    this.isVerified,
    this.actionType,
    this.createdDate,
    this.actionByYou,
    this.age,
    this.isOnline,
    this.isRead,
  });

  factory LikeModel.fromMap(Map<String, dynamic> json) => LikeModel(
        userId: json["UserId"],
        fullName: json["FullName"],
        displayName: json["DisplayName"],
        profilePicture: json["ProfilePicture"],
        city: json["City"],
        state: json["State"],
        isVerified: json["IsVerified"],
        actionType: json["ActionType"],
        createdDate: json["CreatedDate"] == null
            ? null
            : DateTime.parse(json["CreatedDate"]),
        actionByYou: json["ActionByYou"],
        age: json["Age"],
        isRead: json["IsRead"],
      );

  Map<String, dynamic> toMap() => {
        "UserId": userId,
        "FullName": fullName,
        "DisplayName": displayName,
        "ProfilePicture": profilePicture,
        "City": city,
        "State": state,
        "IsVerified": isVerified,
        "ActionType": actionType,
        "CreatedDate": createdDate?.toIso8601String(),
        "ActionByYou": actionByYou,
        "Age": age,
        "IsRead": isRead,
      };
}
