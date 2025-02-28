import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';
import 'package:gokidu_app_tour/view/bottom_nav_bar/rating_review/model/rating_review_model.dart';

class DonorProfileModel implements Decodable<DonorProfileModel> {
  DonorProfileDetail? donorProfileDetail;
  List<UserImage>? userImage;
  List<Rating>? donorRatingsReviews;
  List<OtherMedicalReport>? otherMedicalReport;

  DonorProfileModel({
    this.donorProfileDetail,
    this.userImage,
    this.donorRatingsReviews,
    this.otherMedicalReport,
  });

  factory DonorProfileModel.fromMap(Map<String, dynamic> json) =>
      DonorProfileModel(
        donorProfileDetail:
            DonorProfileDetail.fromMap(json["DonorProfileDetail"]),
        donorRatingsReviews: json["DonorRatingsAndReviews"] == null
            ? []
            : List<Rating>.from(
                json["DonorRatingsAndReviews"].map((x) => Rating.fromMap(x))),
        userImage: List<UserImage>.from(
            json["UserImage"].map((x) => UserImage.fromMap(x))),
        otherMedicalReport: json["MedicalReports"] == null
            ? []
            : List<OtherMedicalReport>.from(
                json["MedicalReports"]
                    .map((x) => OtherMedicalReport.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        "DonorProfileDetail":
            donorProfileDetail != null ? donorProfileDetail!.toMap() : [],
        "UserImage": userImage != null
            ? List<dynamic>.from(userImage!.map((x) => x.toMap()))
            : [],
        "DonorRatingsAndReviews": donorRatingsReviews != null
            ? List<dynamic>.from(donorRatingsReviews!.map((x) => x.toMap()))
            : [],
        "MedicalReports":
            otherMedicalReport != null && otherMedicalReport!.isNotEmpty
                ? List<dynamic>.from(otherMedicalReport!.map((x) => x.toMap()))
                : [],
      };

  @override
  DonorProfileModel decode(json) {
    donorProfileDetail = DonorProfileDetail.fromMap(json["DonorProfileDetail"]);
    userImage = List<UserImage>.from(
        json["UserImage"].map((x) => UserImage.fromMap(x)));
    donorRatingsReviews = json["DonorRatingsAndReviews"] == null
        ? []
        : List<Rating>.from(
            json["DonorRatingsAndReviews"].map((x) => Rating.fromMap(x)));
    otherMedicalReport = json["MedicalReports"] == null
        ? []
        : List<OtherMedicalReport>.from(
            json["MedicalReports"].map((x) => OtherMedicalReport.fromMap(x)));

    return this;
  }
}

class DonorProfileDetail implements Decodable<DonorProfileDetail> {
  num? distance;
  int? id;
  int? userId;
  int? profileCompletionPercentage;
  int? userType;
  int? roleId;
  bool? isVerified;
  String? displayName;
  String? dob;
  String? email;
  String? fullName;
  String? profilePicture;
  String? aboutMe;
  int? likeCount;
  num? averageRating;
  int? ratingCount;
  int? age;
  String? address;
  String? city;
  String? state;
  String? latitude;
  String? longitude;
  int? height;
  int? hairColorId;
  String? hairColor;
  int? eyeColorId;
  String? eyeColor;
  int? ethnicityId, nationalityId;
  String? ethnicityName;
  String? otherEthnicity;
  int? countryId;
  String? countryName;
  String? nationality;
  int? religiousId;
  String? otherReligious;
  String? religiousName;
  String? bloodGroup;
  // String? currentOccupation;
  int? educationId;
  String? educationName;
  int? professionId;
  String? professionName;
  bool? stdTestStatus;
  String? stdTestReportFile;
  bool? geneticTestStatus;
  String? geneticTestReportFile;
  bool? semenTestStatus;
  String? semenTestReportFile;
  bool? isEnableNotificationsAlerts;
  bool? isEnableEmailsAlerts;
  bool? isBookmark;
  bool? isLiked, isDisLiked;
  bool isDeliveryVerification;

  List<String>? userImage;
  bool? isEmailUser;
  bool? isUploadDocumentStatus;
  DateTime? stdTestReportDate;
  DateTime? geneticTestReportDate;
  DateTime? semenTestReportDate;

  // bool? isVerified;

  DonorProfileDetail({
    this.distance,
    this.id,
    this.userId,
    this.profileCompletionPercentage,
    this.userType,
    this.roleId,
    this.isVerified,
    this.displayName,
    this.dob,
    this.email,
    this.fullName,
    this.professionId,
    this.professionName,
    this.profilePicture,
    this.aboutMe,
    this.likeCount,
    this.averageRating = 0.0,
    this.ratingCount,
    this.age,
    this.address,
    this.city,
    this.state,
    this.latitude,
    this.longitude,
    this.height,
    this.hairColorId,
    this.hairColor,
    this.eyeColorId,
    this.eyeColor,
    this.ethnicityId,
    this.ethnicityName,
    this.otherEthnicity,
    this.countryId,
    this.countryName,
    this.nationality,
    this.nationalityId,
    this.religiousId,
    this.otherReligious,
    this.religiousName,
    this.bloodGroup,
    // this.currentOccupation,
    this.educationId,
    this.educationName,
    this.stdTestStatus,
    this.stdTestReportFile,
    this.geneticTestStatus,
    this.geneticTestReportFile,
    this.semenTestStatus,
    this.semenTestReportFile,
    this.isEnableEmailsAlerts,
    this.isEnableNotificationsAlerts,
    this.isBookmark,
    this.isLiked,
    this.userImage,
    this.isEmailUser,
    this.isUploadDocumentStatus,
    this.isDeliveryVerification = false,
    this.geneticTestReportDate,
    this.semenTestReportDate,
    this.stdTestReportDate,
    this.isDisLiked,
    // this.isVerified,
  });

  factory DonorProfileDetail.fromMap(Map<String, dynamic> json) =>
      DonorProfileDetail(
        distance: json["Distance"],
        id: json["DonorProfileDetailId"],
        userId: json["DonorUserId"],
        profileCompletionPercentage: json["ProfileCompletionPercentage"],
        userType: json["UserType"],
        roleId: json["RoleId"],
        displayName: json["DisplayName"],
        dob: json["DOB"],
        email: json["Email"],
        fullName: json["FullName"],
        professionId: json["ProfessionId"],
        professionName: json["ProfessionName"],
        profilePicture: json["ProfilePicture"],
        aboutMe: json["AboutMe"],
        likeCount: json["LikesCount"],
        averageRating: json["AverageRating"],
        ratingCount: json["RatingCount"],
        age: json["Age"],
        address: json["Address"],
        city: json["City"],
        state: json["State"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        height: json["Height"],
        hairColorId: json["HairColorId"],
        hairColor: json["HairColor"],
        eyeColorId: json["EyeColorId"],
        eyeColor: json["EyeColor"],
        ethnicityId: json["EthnicityId"],
        ethnicityName: json["EthnicityName"],
        otherEthnicity: json["OtherEthnicity"],
        countryId: json["CountryId"],
        countryName: json["CountryName"],
        nationality: json["Nationality"],
        nationalityId: json["NationalityId"],
        religiousId: json["ReligiousId"],
        otherReligious: json["OtherReligious"],
        religiousName: json["ReligiousName"],
        bloodGroup: json["BloodGroup"],
        // currentOccupation: json["CurrentOccupation"],
        educationId: json["EducationId"],
        educationName: json["EducationName"],
        stdTestStatus: json["STDTestStatus"],
        stdTestReportFile: json["STDTestReportFile"],
        geneticTestStatus: json["GeneticTestStatus"],
        geneticTestReportFile: json["GeneticTestReportFile"],
        semenTestStatus: json["SemenTestStatus"],
        semenTestReportFile: json["SemenTestReportFile"],
        isEnableEmailsAlerts: json["IsEnableEmailsAlerts"] ?? true,
        isEnableNotificationsAlerts:
            json["IsEnableNotificationsAlerts"] ?? true,
        isLiked: json["IsLiked"] ?? false,
        isBookmark: json["IsBookmarked"] ?? false,
        isDisLiked: json["IsDisLiked"] ?? false,
        userImage: json["UserImages"] != null && json["UserImages"].isNotEmpty
            ? List<String>.from(json["UserImages"]!.map((x) => x))
            : [json["ProfilePicture"].toString()],
        isEmailUser: json["IsEmailUser"] ?? false,
        isUploadDocumentStatus: json["IsUploadDocumentStatus"],
        isVerified: json["IsVerified"],
        isDeliveryVerification: json["IsDeliveryVerification"] ?? false,
        stdTestReportDate: json["STDTestReportDate"] != null
            ? DateTime.parse(json["STDTestReportDate"])
            : null,
        semenTestReportDate: json["SemenTestReportDate"] != null
            ? DateTime.parse(json["SemenTestReportDate"])
            : null,
        geneticTestReportDate: json["GeneticTestReportDate"] != null
            ? DateTime.parse(json["GeneticTestReportDate"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "Distance": distance,
        "DonorProfileDetailId": id,
        "DonorUserId": userId,
        "ProfileCompletionPercentage": profileCompletionPercentage,
        "RoleId": roleId,
        "IsVerified": isVerified,
        "UserType": userType,
        "DisplayName": displayName,
        "DOB": dob,
        "Email": email,
        "FullName": fullName,
        "ProfessionName": professionName,
        "ProfessionId": professionId,
        "ProfilePicture": profilePicture,
        "AboutMe": aboutMe,
        "LikesCount": likeCount,
        "AverageRating": averageRating,
        "RatingCount": ratingCount,
        "Age": age,
        "Address": address,
        "City": city,
        "State": state,
        "Latitude": latitude,
        "Longitude": longitude,
        "Height": height,
        "HairColorId": hairColorId,
        "HairColor": hairColor,
        "EyeColorId": eyeColorId,
        "EyeColor": eyeColor,
        "EthnicityId": ethnicityId,
        "EthnicityName": ethnicityName,
        "OtherEthnicity": otherEthnicity,
        "CountryId": countryId,
        "CountryName": countryName,
        "Nationality": nationality,
        "NationalityId": nationalityId,
        "ReligiousId": religiousId,
        "OtherReligious": otherReligious,
        "ReligiousName": religiousName,
        "BloodGroup": bloodGroup,
        // "CurrentOccupation": currentOccupation,
        "EducationId": educationId,
        "EducationName": educationName,
        "STDTestStatus": stdTestStatus,
        "STDTestReportFile": stdTestReportFile,
        "GeneticTestStatus": geneticTestStatus,
        "GeneticTestReportFile": geneticTestReportFile,
        "SemenTestStatus": semenTestStatus,
        "SemenTestReportFile": semenTestReportFile,
        "IsEnableEmailsAlerts": isEnableEmailsAlerts,
        "IsEnableNotificationsAlerts": isEnableNotificationsAlerts,
        "IsLiked": isLiked,
        "IsBookmarked": isBookmark,
        "IsDisLiked": isDisLiked,
        "UserImages": userImage != null && userImage!.isNotEmpty
            ? List<dynamic>.from(userImage!.map((x) => x))
            : [profilePicture],
        "IsEmailUser": isEmailUser,
        "IsUploadDocumentStatus": isUploadDocumentStatus,
        "IsDeliveryVerification": isDeliveryVerification,
        "STDTestReportDate": stdTestReportDate?.toIso8601String(),
        "SemenTestReportDate": semenTestReportDate?.toIso8601String(),
        "GeneticTestReportDate": geneticTestReportDate?.toIso8601String(),
      };

  @override
  DonorProfileDetail decode(json) {
    distance = json["Distance"];
    id = json["DonorProfileDetailId"];
    userId = json["DonorUserId"];
    profileCompletionPercentage = json["ProfileCompletionPercentage"];
    userType = json["UserType"];
    roleId = json["RoleId"];
    isVerified = json["IsVerified"];
    displayName = json["DisplayName"];
    dob = json["DOB"];
    email = json["Email"];
    fullName = json["FullName"];
    professionId = json["ProfessionId"];
    professionName = json["ProfessionName"];
    profilePicture = json["ProfilePicture"];
    aboutMe = json["AboutMe"];
    likeCount = json["LikesCount"];
    averageRating = json["AverageRating"]?.toDouble();
    ratingCount = json["RatingCount"];
    age = json["Age"];
    address = json["Address"];
    city = json["City"];
    state = json["State"];
    latitude = json["Latitude"];
    longitude = json["Longitude"];
    height = json["Height"];
    hairColorId = json["HairColorId"];
    hairColor = json["HairColor"];
    eyeColorId = json["EyeColorId"];
    eyeColor = json["EyeColor"];
    ethnicityId = json["EthnicityId"];
    ethnicityName = json["EthnicityName"];
    otherEthnicity = json["OtherEthnicity"];
    countryId = json["CountryId"];
    countryName = json["CountryName"];
    nationality = json["Nationality"];
    nationalityId = json["NationalityId"];

    religiousId = json["ReligiousId"];
    otherReligious = json["OtherReligious"];
    religiousName = json["ReligiousName"];
    bloodGroup = json["BloodGroup"];
    // currentOccupation = json["CurrentOccupation"];
    educationId = json["EducationId"];
    educationName = json["EducationName"];
    stdTestStatus = json["STDTestStatus"];
    stdTestReportFile = json["STDTestReportFile"];
    geneticTestStatus = json["GeneticTestStatus"];
    geneticTestReportFile = json["GeneticTestReportFile"];
    semenTestStatus = json["SemenTestStatus"];
    semenTestReportFile = json["SemenTestReportFile"];
    isEnableEmailsAlerts = json["IsEnableEmailsAlerts"] ?? true;
    isEnableNotificationsAlerts = json["IsEnableNotificationsAlerts"] ?? true;
    isLiked = json["IsLiked"];
    isBookmark = json["IsBookmarked"];
    isDisLiked = json["IsDisLiked"] ?? false;
    userImage = json["UserImages"] == null || json["UserImages"].isEmpty
        ? [json["ProfilePicture"].toString()]
        : List<String>.from(json["UserImages"]!.map((x) => x));
    isEmailUser = json["IsEmailUser"] ?? false;
    isUploadDocumentStatus = json["IsUploadDocumentStatus"];
    isDeliveryVerification = json["IsDeliveryVerification"] ?? false;
    stdTestReportDate = json["STDTestReportDate"] != null
        ? DateTime.parse(json["STDTestReportDate"])
        : null;
    semenTestReportDate = json["SemenTestReportDate"] != null
        ? DateTime.parse(json["SemenTestReportDate"])
        : null;
    geneticTestReportDate = json["GeneticTestReportDate"] != null
        ? DateTime.parse(json["GeneticTestReportDate"])
        : null;
    return this;
  }
}

class Height implements Decodable<Height> {
  int? inCm;
  int? inFootInches;

  Height({
    this.inCm,
    this.inFootInches,
  });

  factory Height.fromMap(Map<String, dynamic> json) =>
      Height(inCm: json["inCm"] ?? 0, inFootInches: json["inFootInches"] ?? 0);

  Map<String, dynamic> toMap() => {
        "inCm": inCm,
        "inFootInches": inFootInches,
      };

  @override
  Height decode(json) {
    inCm = json["inCm"];
    inFootInches = json["inFootInches"];

    return this;
  }
}

class UserImage implements Decodable<UserImage> {
  int? userImageId;
  String? imageName;

  UserImage({
    this.userImageId,
    this.imageName,
  });

  factory UserImage.fromMap(Map<String, dynamic> json) => UserImage(
        userImageId: json["UserImageId"],
        imageName: json["ImageName"],
      );

  Map<String, dynamic> toMap() => {
        "UserImageId": userImageId,
        "ImageName": imageName,
      };

  @override
  UserImage decode(json) {
    userImageId = json["UserImageId"];
    imageName = json["ImageName"];
    return this;
  }
}

class ProfilePercentageModel implements Decodable<ProfilePercentageModel> {
  num? profilePercentage;

  ProfilePercentageModel({this.profilePercentage});

  @override
  ProfilePercentageModel decode(json) {
    profilePercentage = json["ProfilePercentage"];
    return this;
  }

  factory ProfilePercentageModel.fromMap(Map<String, dynamic> json) =>
      ProfilePercentageModel(profilePercentage: json["ProfilePercentage"]);

  Map<String, dynamic> toMap() => {"ProfilePercentage": profilePercentage};
}

class OtherMedicalReport implements Decodable<OtherMedicalReport> {
  int? userOtherMedicalReportId;
  int? medicalReportId;
  String? medicalReportName;
  String? filePath;
  DateTime? uploadedOn;
  OtherMedicalReport({
    this.filePath,
    this.medicalReportId,
    this.medicalReportName,
    this.userOtherMedicalReportId,
    this.uploadedOn,
  });

  @override
  OtherMedicalReport decode(json) {
    userOtherMedicalReportId = json["UserMedicalReportId"];
    medicalReportId = json["MedicalReportId"];
    medicalReportName = json["MedicalReportName"];
    filePath = json["FilePath"];
    uploadedOn =
        json["UploadedOn"] != null ? DateTime.parse(json["UploadedOn"]) : null;

    return this;
  }

  factory OtherMedicalReport.fromMap(Map<String, dynamic> json) =>
      OtherMedicalReport(
        userOtherMedicalReportId: json["UserMedicalReportId"],
        medicalReportId: json["MedicalReportId"],
        medicalReportName: json["MedicalReportName"],
        filePath: json["FilePath"],
        uploadedOn: json["UploadedOn"] != null
            ? DateTime.parse(json["UploadedOn"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "UserMedicalReportId": userOtherMedicalReportId,
        "MedicalReportId": medicalReportId,
        "MedicalReportName": medicalReportName,
        "FilePath": filePath,
        "UploadedOn": uploadedOn!.toIso8601String(),
      };
}
