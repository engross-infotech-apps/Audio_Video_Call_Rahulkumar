import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class RecipientProfile extends Decodable<RecipientProfile> {
  int? userType;
  int? roleId;
  String? profilePicture;
  String? fullName;
  String? displayName;
  String? aboutMe;
  int? donorRadiusinMile;
  String? latitude, addressLatitude;
  String? longitude, addressLongitude;
  String? eyeColorIds;
  String? hairColorIds;
  String? religiousIds;
  String? ethnicityIds;
  String? otherEthnicity;
  int? ethnicityId, nationalityId;
  String? dob, address;
  String? preferredNationalities;
  String? preferredHeights;
  String? professionIds;
  String? educationIds;
  bool? isEmailUser;
  bool? isVerified;
  bool? isUploadDocumentStatus;
  bool? isEnableNotificationsAlerts;
  bool? isEnableEmailsAlerts;

  RecipientProfile({
    this.userType,
    this.roleId,
    this.profilePicture,
    this.fullName,
    this.displayName,
    this.aboutMe,
    this.donorRadiusinMile,
    this.latitude,
    this.longitude,
    this.addressLatitude,
    this.addressLongitude,
    this.eyeColorIds,
    this.hairColorIds,
    this.ethnicityIds,
    this.ethnicityId,
    this.otherEthnicity,
    this.nationalityId,
    this.religiousIds,
    this.preferredNationalities,
    this.preferredHeights,
    this.professionIds,
    this.educationIds,
    this.isEmailUser,
    this.isVerified,
    this.isUploadDocumentStatus,
    this.isEnableNotificationsAlerts,
    this.isEnableEmailsAlerts,
    this.dob,
    this.address,
  });

  //  "IsEnableNotificationsAlerts": true,
  //   "IsEnableEmailsAlerts": true,

  factory RecipientProfile.fromMap(Map<String, dynamic> json) =>
      RecipientProfile(
        userType: json["UserType"],
        roleId: json["RoleId"],
        profilePicture: json["ProfilePicture"],
        fullName: json["FullName"],
        displayName: json["DisplayName"],
        aboutMe: json["AboutMe"],
        donorRadiusinMile: json["DonorRadiusinMile"],
        longitude: json["Longitude"],
        latitude: json["Latitude"],
        addressLatitude: json["AddressLatitude"],
        addressLongitude: json["AddressLongitude"],
        eyeColorIds: json["EyeColorIds"],
        hairColorIds: json["HairColorIds"],
        ethnicityIds: json["EthnicityIds"],
        ethnicityId: json["EthnicityId"],
        otherEthnicity: json["OtherEthnicity"],
        nationalityId: json["NationalityId"],
        religiousIds: json["ReligiousIds"],
        preferredNationalities: json["PreferredNationalities"],
        preferredHeights: json["PreferredHeights"],
        professionIds: json["ProfessionIds"],
        educationIds: json["EducationIds"],
        isEmailUser: json["IsEmailUser"],
        isVerified: json["IsVerified"],
        isEnableEmailsAlerts: json["IsEnableEmailsAlerts"],
        isEnableNotificationsAlerts: json["IsEnableNotificationsAlerts"],
        isUploadDocumentStatus: json["IsUploadDocumentStatus"],
        dob: json["DOB"],
        address: json["Address"],
      );

  Map<String, dynamic> toMap() => {
        "UserType": userType,
        "RoleId": roleId,
        "ProfilePicture": profilePicture,
        "FullName": fullName,
        "DisplayName": displayName,
        "AboutMe": aboutMe,
        "DonorRadiusinMile": donorRadiusinMile,
        "Latitude": latitude,
        "Longitude": longitude,
        "EyeColorIds": eyeColorIds,
        "HairColorIds": hairColorIds,
        "EthnicityIds": ethnicityIds,
        "EthnicityId": ethnicityId,
        "OtherEthnicity": otherEthnicity,
        "NationalityId": nationalityId,
        "PreferredNationalities": preferredNationalities,
        "PreferredHeights": preferredHeights,
        "ProfessionIds": professionIds,
        "ReligiousIds": religiousIds,
        "EducationIds": educationIds,
        "IsEmailUser": isEmailUser,
        "IsVerified": isVerified,
        "IsEnableNotificationsAlerts": isEnableNotificationsAlerts,
        "IsEnableEmailsAlerts": isEnableEmailsAlerts,
        "IsUploadDocumentStatus": isUploadDocumentStatus,
        "DOB": dob,
        "Address": address,
        "AddressLatitude": addressLatitude,
        "AddressLongitude": addressLongitude,
      };

  @override
  RecipientProfile decode(json) {
    userType = json["UserType"];
    roleId = json["RoleId"];
    profilePicture = json["ProfilePicture"];
    fullName = json["FullName"];
    displayName = json["DisplayName"];
    aboutMe = json["AboutMe"];
    donorRadiusinMile = json["DonorRadiusinMile"];
    longitude = json["Longitude"];
    latitude = json["Latitude"];
    addressLatitude = json["AddressLatitude"];
    addressLongitude = json["AddressLongitude"];
    eyeColorIds = json["EyeColorIds"];
    hairColorIds = json["HairColorIds"];
    religiousIds = json["ReligiousIds"];
    ethnicityIds = json["EthnicityIds"];
    ethnicityId = json["EthnicityId"];
    otherEthnicity = json["OtherEthnicity"];
    nationalityId = json["NationalityId"];
    preferredNationalities = json["PreferredNationalities"];
    preferredHeights = json["PreferredHeights"];
    professionIds = json["ProfessionIds"];
    educationIds = json["EducationIds"];
    isVerified = json["IsVerified"];
    isEnableEmailsAlerts = json["IsEnableEmailsAlerts"];
    isEnableNotificationsAlerts = json["IsEnableNotificationsAlerts"];
    isUploadDocumentStatus = json["IsUploadDocumentStatus"];
    isEmailUser = json["IsEmailUser"];
    dob = json["DOB"];
    address = json["Address"];
    return this;
  }
}
