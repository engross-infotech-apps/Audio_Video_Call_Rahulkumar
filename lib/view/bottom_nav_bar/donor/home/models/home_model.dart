import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class HomeDashboardModel implements Decodable<HomeDashboardModel> {
  List<UserModel>? users;
  int? profileCompletionPercentage;
  double averageRating;
  int userLikesCount, unreadLikeCount;
  String? fullName;
  bool? isVerified, isUploadDocumentStatus, isFeedbackShow;
  List<UserLike>? userLikes;
  List<RecentChat>? recentChats;

  HomeDashboardModel({
    this.users,
    this.profileCompletionPercentage,
    this.averageRating = 0.0,
    this.userLikesCount = 00,
    this.userLikes,
    this.recentChats,
    this.fullName,
    this.isUploadDocumentStatus,
    this.isVerified,
    this.isFeedbackShow,
    this.unreadLikeCount = 0,
  });

  factory HomeDashboardModel.fromMap(Map<String, dynamic> json) =>
      HomeDashboardModel(
        fullName: json["FullName"],
        isUploadDocumentStatus: json["IsUploadDocumentStatus"],
        isVerified: json["IsVerified"],
        users:
            List<UserModel>.from(json["User"].map((x) => UserModel.fromMap(x))),
        profileCompletionPercentage: json["ProfileCompletionPercentage"],
        averageRating: json["AverageRating"]?.toDouble(),
        userLikesCount: json["LikesCount"],
        unreadLikeCount: json["UnreadLikeCount"] ?? 0,
        userLikes: List<UserLike>.from(
            json["UserLikes"].map((x) => UserLike.fromMap(x))),
        isFeedbackShow: json["IsFeedbackShow"],
        // recentChats: List<RecentChat>.from(
        //     json["RecentChats"].map((x) => RecentChat.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "FullName": fullName,
        "IsUploadDocumentStatus": isUploadDocumentStatus,
        "IsVerified": isVerified,
        "User": users != null
            ? List<UserModel>.from(users!.map((x) => x.toMap()))
            : [],
        "ProfileCompletionPercentage": profileCompletionPercentage,
        "AverageRating": averageRating,
        "LikesCount": userLikesCount,
        "UserLikes": userLikes != null
            ? List<UserLike>.from(userLikes!.map((x) => x.toMap()))
            : [],
        "IsFeedbackShow": isFeedbackShow,
        "UnreadLikeCount": unreadLikeCount,
        // "RecentChats": recentChats != null
        //     ? List<dynamic>.from(recentChats!.map((x) => x.toMap()))
        //     : [],
      };

  @override
  HomeDashboardModel decode(json) {
    fullName = json["FullName"];
    isUploadDocumentStatus = json["IsUploadDocumentStatus"];
    isVerified = json["IsVerified"];
    users = List<UserModel>.from(json["User"].map((x) => UserModel.fromMap(x)));
    profileCompletionPercentage = json["ProfileCompletionPercentage"];
    averageRating =
        json["AverageRating"] != null ? json["AverageRating"]?.toDouble() : 0.0;
    userLikesCount = json["LikesCount"];
    unreadLikeCount = json["UnreadLikeCount"] ?? 0;
    userLikes =
        List<UserLike>.from(json["UserLikes"].map((x) => UserLike.fromMap(x)));
    isFeedbackShow = json["IsFeedbackShow"];
    // recentChats = List<RecentChat>.from(
    //     json["RecentChats"].map((x) => RecentChat.fromMap(x)));

    return this;
  }
}

class RecentChat {
  // int? chatSessionId;
  // int? messageId;
  // int? userId;
  // String? fullName;
  // String? profilePicture;
  // String? messageContent;
  // String? createdDate;

  // RecentChat({
  //   this.chatSessionId,
  //   this.messageId,
  //   this.userId,
  //   this.fullName,
  //   this.profilePicture,
  //   this.messageContent,
  //   this.createdDate,
  // });

  // factory RecentChat.fromMap(Map<String, dynamic> json) => RecentChat(
  //       chatSessionId: json["ChatSessionId"],
  //       messageId: json["MessageId"],
  //       userId: json["UserId"],
  //       fullName: json["FullName"],
  //       profilePicture: json["ProfilePicture"],
  //       messageContent: json["MessageContent"],
  //       createdDate: json["CreatedDate"],
  //     );

  // Map<String, dynamic> toMap() => {
  //       "ChatSessionId": chatSessionId,
  //       "MessageId": messageId,
  //       "UserId": userId,
  //       "FullName": fullName,
  //       "ProfilePicture": profilePicture,
  //       "MessageContent": messageContent,
  //       "CreatedDate": createdDate,
  //     };
}

class UserModel {
  int? userId;
  String? fullName;
  String? latitude, longitude;
  num? distance;
  String? profilePicture;

  UserModel({
    this.userId,
    this.fullName,
    this.latitude,
    this.longitude,
    this.profilePicture,
    this.distance,
  });

  //  "UserId": 42,
  //       "UserName": "Receiver",
  //       "Latitude": "21.1855869",
  //       "Longitude": "72.78325040000001",
  //       "ProfilePicture": "https://gokidu-files.s3.ca-central-1.amazonaws.com/avtar/6d40891d-6069-4e4a-9a36-7d229949ec1d.jpg",
  //       "Distance": 245.6

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      userId: json["UserId"],
      fullName: json["UserName"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      profilePicture: json["ProfilePicture"],
      distance: json["Distance"] ?? 00.00.toDouble());

  Map<String, dynamic> toMap() => {
        "UserName": fullName,
        "Latitude": latitude,
        "Longitude": longitude,
        "ProfilePicture": profilePicture,
        "Distance": distance
      };
}

class UserLike {
  int? userId;
  String? fullName, displayName;
  String? city, state;
  String? profilePicture;
  bool? isVerified;
  DateTime? createdDate;

  UserLike({
    this.userId,
    this.fullName,
    this.city,
    this.state,
    this.displayName,
    this.createdDate,
    this.profilePicture,
    this.isVerified,
  });

  // DonorId": 38,
  //       "FullName": "krishna",
  //       "DisplayName": "krishna26",
  //       "ProfilePicture": "https://gokidu-files.s3.ca-central-1.amazonaws.com/avtar/040667dd-f137-4555-9afd-2d38c56ca484.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAYV6B2KQVEGLI34CV%2F20240527%2Fca-central-1%2Fs3%2Faws4_request&X-Amz-Date=20240527T105658Z&X-Amz-Expires=604800&X-Amz-Signature=de5b2408fbf1f2acba4aa3a6910eedc25cc6ef89f30f434b1cb9d3877cce22b0&X-Amz-SignedHeaders=host&response-content-disposition=inline",
  //       "City": "Navi Mumbai",
  //       "State": "Maharashtra",
  //       "IsVerified": false,
  //       "CreatedDate": "2024-05-06T11:47:38.677Z"

  factory UserLike.fromMap(Map<String, dynamic> json) => UserLike(
      userId: json["UserId"],
      fullName: json["FullName"],
      displayName: json["DisplayName"],
      profilePicture: json["ProfilePicture"],
      city: json["City"],
      state: json["State"],
      isVerified: json["IsVerified"],
      createdDate: DateTime.parse(json["CreatedDate"]));

  Map<String, dynamic> toMap() => {
        "UserId": userId,
        "FullName": fullName,
        "DisplayName": displayName,
        "ProfilePicture": profilePicture,
        "City": city,
        "State": state,
        "IsVerified": isVerified,
        "CreatedDate": createdDate?.toIso8601String(),
      };
}
