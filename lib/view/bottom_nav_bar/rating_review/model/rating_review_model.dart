import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class RatingReviewModel implements Decodable<RatingReviewModel> {
  num? averageRating;
  int? ratingCount;
  int? totalCount;
  List<Rating>? ratings;

  RatingReviewModel({
    this.averageRating,
    this.ratingCount,
    this.ratings,
    this.totalCount,
  });

  factory RatingReviewModel.fromMap(Map<String, dynamic> json) =>
      RatingReviewModel(
        averageRating: json["AverageRating"]?.toDouble(),
        ratingCount: json["RatingCount"],
        totalCount: json["TotalCount"],
        ratings: json["Ratings"] != null && json["Ratings"].isNotEmpty
            ? List<Rating>.from(json["Ratings"].map((x) => Rating.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "AverageRating": averageRating,
        "RatingCount": ratingCount,
        "TotalCount": totalCount,

        "Ratings": ratings != null
            ? List<dynamic>.from(ratings!.map((x) => x.toMap()))
            : [],
        // userLikes != null
        // ? List<UserLike>.from(userLikes!.map((x) => x.toMap()))
        // : [],
      };

  @override
  RatingReviewModel decode(json) {
    averageRating = json["AverageRating"]?.toDouble();
    ratingCount = json["RatingCount"];
    totalCount = json["TotalCount"];

    ratings = json["Ratings"] != null && json["Ratings"].isNotEmpty
        ? List<Rating>.from(json["Ratings"].map((x) => Rating.fromMap(x)))
        : [];
    return this;
  }
}

class Rating extends Decodable<Rating> {
  int? userRatingId;
  int? userProfileId;

  int? userId;
  int? createdBy;
  double? ratings;
  String? comment;
  DateTime? createdDate;
  String? profilePicture;
  String? fullName;
  String? displayName;
  bool? isVerified;

  Rating({
    this.userRatingId,
    this.userProfileId,
    this.userId,
    this.createdBy,
    this.ratings,
    this.comment,
    this.createdDate,
    this.profilePicture,
    this.fullName,
    this.displayName,
    this.isVerified,
  });

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
        userRatingId: json["UserRatingId"],
        userId: json["UserId"],
        createdBy: json["CreatedBy"],
        ratings: json["Ratings"]?.toDouble(),
        comment: json["Comment"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        profilePicture: json["ProfilePicture"],
        fullName: json["FullName"],
        displayName: json["DisplayName"],
        isVerified: json["IsVerified"],
        userProfileId: json["RatingUserId"], //RatingUserId
      );

  Map<String, dynamic> toMap() => {
        "UserRatingId": userRatingId,
        "UserId": userId,
        "CreatedBy": createdBy,
        "Ratings": ratings,
        "Comment": comment,
        "CreatedDate": createdDate?.toIso8601String(),
        "ProfilePicture": profilePicture,
        "FullName": fullName,
        "DisplayName": displayName,
        "IsVerified": isVerified,
        "RatingUserId": userProfileId,
      };

  @override
  Rating decode(json) {
    userRatingId = json["UserRatingId"];
    userId = json["UserId"];
    createdBy = json["CreatedBy"];
    ratings = json["Ratings"]?.toDouble();
    comment = json["Comment"];
    createdDate = DateTime.parse(json["CreatedDate"]);
    profilePicture = json["ProfilePicture"];
    fullName = json["FullName"];
    displayName = json["DisplayName"];
    isVerified = json["IsVerified"];
    userProfileId = json["RatingUserId"]; //RatingUserId

    return this;
  }
}

/**"UserRatingId": 37,
        "UserId": 112,
        "CreatedBy": 75,
        "Ratings": 4,
        "Comment": "Awesome",
        "CreatedDate": "2024-07-26T12:23:07.990Z",
        "ProfilePicture": "https://gokidu-files.s3.ca-central-1.amazonaws.com/avtar/8adb6abb-bc44-4351-8155-d75f7e178ff2.jpg",
        "FullName": "Kapil Engross",
        "DisplayName": "KP_EIT",
        "IsVerified": true,
        "RatingUserId": 11 */

enum RatingEnum {
  highest(0, "Highest"),
  lowest(1, "Lowest"),
  newest(2, "Newest"),
  oldest(3, "Oldest");

  const RatingEnum(this.number, this.text);

  final int number;
  final String text;
}
