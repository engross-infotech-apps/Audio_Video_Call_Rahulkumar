import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class RecipientHomeModel implements Decodable<RecipientHomeModel> {
  List<NearByUser>? nearByUser;
  List<LikeBookmarkUser>? userLikes;
  List<RecentChat>? recentChats;
  List<LikeBookmarkUser>? userBookmark;
  bool? isDonorPreferencesAdded;
  bool? isVerified, isFeedbackShow;
  String? fullName;
  String? displayName;
  bool? isUploadDocumentStatus;
  num? averageRating;
  int? userLikesCount, unreadLikeCount;
  int? ethnicityId, nationalityId;
  String? otherEthnicity;

  RecipientHomeModel({
    this.nearByUser,
    this.userLikes,
    this.recentChats,
    this.userBookmark,
    this.isDonorPreferencesAdded,
    this.isVerified,
    this.fullName,
    this.displayName,
    this.isUploadDocumentStatus,
    this.averageRating = 0,
    this.userLikesCount = 0,
    this.isFeedbackShow,
    this.unreadLikeCount,
    this.ethnicityId,
    this.nationalityId,
    this.otherEthnicity,
  });

  factory RecipientHomeModel.fromMap(Map<String, dynamic> json) =>
      RecipientHomeModel(
        nearByUser: json["NearByUser"] == null
            ? []
            : List<NearByUser>.from(
                json["NearByUser"]!.map((x) => NearByUser.fromMap(x))),
        userLikes: json["UserLikes"] == null
            ? []
            : List<LikeBookmarkUser>.from(
                json["UserLikes"]!.map((x) => LikeBookmarkUser.fromMap(x))),
        recentChats: json["RecentChats"] == null
            ? []
            : List<RecentChat>.from(
                json["RecentChats"]!.map((x) => RecentChat.fromMap(x))),
        userBookmark: json["UserBookmark"] == null
            ? []
            : List<LikeBookmarkUser>.from(
                json["UserBookmark"]!.map((x) => LikeBookmarkUser.fromMap(x))),
        isDonorPreferencesAdded: json["IsDonorPreferencesAdded"],
        isVerified: json["IsVerified"],
        fullName: json["FullName"],
        displayName: json["DisplayName"],
        isUploadDocumentStatus: json["IsUploadDocumentStatus"],
        averageRating: json["AverageRating"],
        userLikesCount: json["LikesCount"],
        isFeedbackShow: json["IsFeedbackShow"],
        unreadLikeCount: json["UnreadLikeCount"],
        nationalityId: json["NationalityId"],
        ethnicityId: json["EthnicityId"],
        otherEthnicity: json["OtherEthnicity"],
      );

  Map<String, dynamic> toMap() => {
        "NearByUser": nearByUser == null
            ? []
            : List<dynamic>.from(nearByUser!.map((x) => x.toMap())),
        "UserLikes": userLikes == null
            ? []
            : List<dynamic>.from(userLikes!.map((x) => x.toMap())),
        "RecentChats": recentChats == null
            ? []
            : List<dynamic>.from(recentChats!.map((x) => x.toMap())),
        "UserBookmark": userBookmark == null
            ? []
            : List<dynamic>.from(userBookmark!.map((x) => x.toMap())),
        "IsDonorPreferencesAdded": isDonorPreferencesAdded,
        "IsVerified": isVerified,
        "FullName": fullName,
        "DisplayName": displayName,
        "IsUploadDocumentStatus": isUploadDocumentStatus,
        "AverageRating": averageRating,
        "LikesCount": userLikesCount,
        "IsFeedbackShow": isFeedbackShow,
        "UnreadLikeCount": unreadLikeCount,
        "EthnicityId": ethnicityId,
        "NationalityId": nationalityId,
        "OtherEthnicity": otherEthnicity,
      };

  @override
  RecipientHomeModel decode(json) {
    nearByUser = json["NearByUser"] == null
        ? []
        : List<NearByUser>.from(
            json["NearByUser"]!.map((x) => NearByUser.fromMap(x)));
    userLikes = json["UserLikes"] == null
        ? []
        : List<LikeBookmarkUser>.from(
            json["UserLikes"]!.map((x) => LikeBookmarkUser.fromMap(x)));
    recentChats = json["RecentChats"] == null
        ? []
        : List<RecentChat>.from(
            json["RecentChats"]!.map((x) => RecentChat.fromMap(x)));
    userBookmark = json["UserBookmark"] == null
        ? []
        : List<LikeBookmarkUser>.from(
            json["UserBookmark"]!.map((x) => LikeBookmarkUser.fromMap(x)));

    isDonorPreferencesAdded = json["IsDonorPreferencesAdded"];
    isVerified = json["IsVerified"];
    fullName = json["FullName"];
    displayName = json["DisplayName"];
    isUploadDocumentStatus = json["IsUploadDocumentStatus"];

    averageRating = json["AverageRating"];
    userLikesCount = json["LikesCount"];
    isFeedbackShow = json["IsFeedbackShow"];
    unreadLikeCount = json["UnreadLikeCount"];
    nationalityId = json["NationalityId"];
    ethnicityId = json["EthnicityId"];
    otherEthnicity = json["OtherEthnicity"];

    return this;
  }
}

class NearByUser implements Decodable<NearByUser> {
  int? userId;
  String? userName;
  String? latitude;
  String? longitude;
  String? profilePicture;
  double? distance;

  NearByUser({
    this.userId,
    this.userName,
    this.latitude,
    this.longitude,
    this.profilePicture,
    this.distance,
  });

  factory NearByUser.fromMap(Map<String, dynamic> json) => NearByUser(
        userId: json["UserId"],
        userName: json["UserName"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        profilePicture: json["ProfilePicture"],
        distance: json["Distance"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "UserId": userId,
        "UserName": userName,
        "Latitude": latitude,
        "Longitude": longitude,
        "ProfilePicture": profilePicture,
        "Distance": distance,
      };

  @override
  NearByUser decode(json) {
    userId = json["UserId"];
    userName = json["UserName"];
    latitude = json["Latitude"];
    longitude = json["Longitude"];
    profilePicture = json["ProfilePicture"];
    distance = json["Distance"]?.toDouble();
    return this;
  }
}

class RecentChat implements Decodable<RecentChat> {
  int? chatSessionId;
  int? userId;
  String? fullName;
  DateTime? createdDate;

  RecentChat({
    this.chatSessionId,
    this.userId,
    this.fullName,
    this.createdDate,
  });

  factory RecentChat.fromMap(Map<String, dynamic> json) => RecentChat(
        chatSessionId: json["ChatSessionId"],
        userId: json["UserId"],
        fullName: json["FullName"],
        createdDate: json["CreatedDate"] == null
            ? null
            : DateTime.parse(json["CreatedDate"]),
      );

  Map<String, dynamic> toMap() => {
        "ChatSessionId": chatSessionId,
        "UserId": userId,
        "FullName": fullName,
        "CreatedDate": createdDate?.toIso8601String(),
      };

  @override
  RecentChat decode(json) {
    chatSessionId = json["ChatSessionId"];
    userId = json["UserId"];
    fullName = json["FullName"];
    createdDate = json["CreatedDate"] == null
        ? null
        : DateTime.parse(json["CreatedDate"]);
    return this;
  }
}

class LikeBookmarkUser implements Decodable<LikeBookmarkUser> {
  String? fullName;
  String? displayName;
  int? userId;
  dynamic profilePicture;

  LikeBookmarkUser({
    this.fullName,
    this.displayName,
    this.profilePicture,
    this.userId,
  });

  factory LikeBookmarkUser.fromMap(Map<String, dynamic> json) =>
      LikeBookmarkUser(
        fullName: json["FullName"],
        userId: json["UserId"],
        displayName: json["DisplayName"],
        profilePicture: json["ProfilePicture"],
      );

  Map<String, dynamic> toMap() => {
        "FullName": fullName,
        "DisplayName": displayName,
        "ProfilePicture": profilePicture,
        "UserId": userId,
      };

  @override
  LikeBookmarkUser decode(json) {
    fullName = json["FullName"];
    userId = json["UserId"];

    profilePicture = json["ProfilePicture"];
    return this;
  }
}
