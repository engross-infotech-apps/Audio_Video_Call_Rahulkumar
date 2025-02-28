import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/donor/profile/model/donor_profile_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/rating_review/model/rating_review_model.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/recipient/recipient_profile/model/donor_preferences_model.dart';

class RecipientProfileModel extends Decodable<RecipientProfileModel> {
  RecipientProfileDetails? recipientProfileDetail;
  RecipientProfile? recipientProfile;
  List<UserImage>? userImage;
  List<Rating>? recipientRatingsAndReviews;

  RecipientProfileModel({
    this.recipientProfileDetail,
    this.userImage,
    this.recipientRatingsAndReviews,
    this.recipientProfile,
  });

  factory RecipientProfileModel.fromMap(Map<String, dynamic> json) =>
      RecipientProfileModel(
        recipientProfileDetail: json["RecipientProfile"] != null
            ? RecipientProfileDetails.fromMap(json["RecipientProfile"])
            : null,
        recipientProfile: json["RecipientProfileDetail"] != null
            ? RecipientProfile.fromMap(json["RecipientProfileDetail"])
            : null,
        recipientRatingsAndReviews: json["RecipientRatingsAndReviews"] == null
            ? []
            : List<Rating>.from(json["RecipientRatingsAndReviews"]
                .map((x) => Rating.fromMap(x))),
        userImage: json["UserImage"] == null
            ? []
            : List<UserImage>.from(
                json["UserImage"].map((x) => UserImage.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "RecipientProfile": recipientProfileDetail?.toMap(),
        "UserImage": userImage != null
            ? List<dynamic>.from(userImage!.map((x) => x.toMap()))
            : [],
        "RecipientProfileDetail": recipientProfile?.toMap(),
        "RecipientRatingsAndReviews": recipientRatingsAndReviews != null
            ? List<dynamic>.from(
                recipientRatingsAndReviews!.map((x) => x.toMap()))
            : [],
      };

  @override
  RecipientProfileModel decode(json) {
    recipientProfileDetail = json["RecipientProfile"] != null
        ? RecipientProfileDetails.fromMap(json["RecipientProfile"])
        : null;

    recipientProfile = json["RecipientProfileDetail"] != null
        ? RecipientProfile.fromMap(json["RecipientProfileDetail"])
        : null;
    userImage = json["UserImage"] == null
        ? []
        : List<UserImage>.from(
            json["UserImage"].map((x) => UserImage.fromMap(x)));
    recipientRatingsAndReviews = json["RecipientRatingsAndReviews"] == null
        ? []
        : List<Rating>.from(
            json["RecipientRatingsAndReviews"].map((x) => Rating.fromMap(x)));
    return this;
  }
}

class RecipientProfileDetails extends Decodable<RecipientProfileDetails> {
  num? distance;
  int? userId;
  String? profilePicture;
  String? displayName;
  String? fullName;
  bool? isVerified;
  String? aboutMe;
  num? likesCount;
  num averageRating;
  num? age;
  String? city;
  String? state;
  String? country;
  String? rowNum;
  num? ratingCount;
  bool isLiked, isDisliked;
  bool isBookmark, isLikedByRecipient;
  List<String>? userImage;
  bool? isDeliveryVerification;

  int? countryId;

  RecipientProfileDetails(
      {this.distance,
      this.userId,
      this.profilePicture,
      this.displayName,
      this.fullName,
      this.isVerified = false,
      this.aboutMe,
      this.likesCount,
      this.age,
      this.city,
      this.averageRating = 0,
      this.state,
      this.country,
      this.rowNum,
      this.isLiked = false,
      this.ratingCount,
      this.isLikedByRecipient = false,
      this.userImage,
      this.countryId,
      this.isBookmark = false,
      this.isDisliked = false,
      this.isDeliveryVerification});
  @override
  RecipientProfileDetails decode(json) {
    distance = json["Distance"];
    userId = json["UserId"];
    profilePicture = json["ProfilePicture"];
    displayName = json["DisplayName"];
    fullName = json["FullName"];
    isVerified = json["IsVerified"];
    aboutMe = json["AboutMe"];
    likesCount = json["LikesCount"];
    age = json["Age"];
    averageRating = json["AverageRating"];
    city = json["City"];
    state = json["State"];
    country = json["Country"];
    countryId = json["CountryId"];
    ratingCount = json["RatingCount"];
    rowNum = json["RowNum"];
    isLiked = json["IsLiked"] ?? false;
    isDisliked = json["IsDisLiked"] ?? false;
    isBookmark = json["IsBookmarked"] ?? false;
    isLikedByRecipient = json["IsLikedByRecipient"];
    userImage = json["UserImage"] == null || json["UserImage"].isEmpty
        ? [json["ProfilePicture"].toString()]
        : List<String>.from(json["UserImage"]!.map((x) => x));
    isDeliveryVerification = json["IsDeliveryVerification"];
    return this;
  }

  factory RecipientProfileDetails.fromMap(Map<String, dynamic> json) =>
      RecipientProfileDetails(
        distance: json["Distance"],
        userId: json["UserId"],
        profilePicture: json["ProfilePicture"],
        displayName: json["DisplayName"],
        fullName: json["FullName"],
        isVerified: json["IsVerified"],
        aboutMe: json["AboutMe"],
        likesCount: json["LikesCount"],
        age: json["Age"],
        ratingCount: json["RatingCount"],
        city: json["City"],
        state: json["State"],
        country: json["Country"],
        averageRating: json["AverageRating"],
        countryId: json["CountryId"],
        rowNum: json["RowNum"],
        isLiked: json["IsLiked"] ?? false,
        isDisliked: json["IsDisLiked"] ?? false,
        isBookmark: json["IsBookmarked"] ?? false,
        isLikedByRecipient: json["IsLikedByRecipient"],
        userImage: json["UserImage"] == null || json["UserImage"].isEmpty
            ? json["ProfilePicture"] != null
                ? [json["ProfilePicture"].toString()]
                : []
            : List<String>.from(json["UserImage"]!.map((x) => x)),
        isDeliveryVerification: json["IsDeliveryVerification"],
      );

  Map<String, dynamic> toMap() => {
        "Distance": distance,
        "UserId": userId,
        "ProfilePicture": profilePicture,
        "DisplayName": displayName,
        "FullName": fullName,
        "IsVerified": isVerified,
        "AboutMe": aboutMe,
        "LikesCount": likesCount,
        "Age": age,
        "City": city,
        "State": state,
        "Country": country,
        "AverageRating": averageRating,
        "CountryId": countryId,
        "RatingCount": ratingCount,
        "RowNum": rowNum,
        "IsLiked": isLiked,
        "IsBookmarked": isBookmark,
        "IsDisLiked": isDisliked,
        "UserImage": userImage != null && userImage!.isEmpty
            ? List<dynamic>.from(userImage!.map((x) => x))
            : [profilePicture],
        "IsLikedByRecipient": isLikedByRecipient,
        "IsDeliveryVerification": isDeliveryVerification,
      };
}
