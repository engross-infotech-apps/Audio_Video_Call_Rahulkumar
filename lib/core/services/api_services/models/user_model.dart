import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class UserBasicDetailsModel implements Decodable<UserBasicDetailsModel> {
  int? userId;
  int? userType;
  int? roleId;
  String? displayName;
  String? fullName;
  String? email;
  DateTime? dob;
  String? profilePicture;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  int? countryId;
  bool? isVerified;
  bool? isEnableNotificationsAlerts;
  bool? isEnableEmailsAlerts;
  bool? isUploadDocumentStatus;
  bool? isEmailUser;
  String? stripeConnectAccountId;
  String? documentFrontImage;
  String? documentBackImage;
  bool? isAddedBankAccount;
  String? currency, currencySymbol;

  UserBasicDetailsModel({
    this.userId,
    this.userType,
    this.roleId,
    this.displayName,
    this.fullName,
    this.email,
    this.dob,
    this.profilePicture,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.countryId,
    this.isVerified,
    this.isEnableNotificationsAlerts,
    this.isEnableEmailsAlerts,
    this.isUploadDocumentStatus,
    this.isEmailUser,
    this.stripeConnectAccountId,
    this.documentFrontImage,
    this.documentBackImage,
    this.isAddedBankAccount,
    this.currency,
    this.currencySymbol = "\$",
  });

  factory UserBasicDetailsModel.fromMap(Map<String, dynamic> json) =>
      UserBasicDetailsModel(
        userId: json["UserId"],
        userType: json["UserType"],
        roleId: json["RoleId"],
        displayName: json["DisplayName"],
        fullName: json["FullName"],
        email: json["Email"],
        dob: json["DOB"] == null ? null : DateTime.parse(json["DOB"]),
        profilePicture: json["ProfilePicture"],
        address: json["Address"],
        city: json["City"],
        state: json["State"],
        country: json["Country"],
        zipCode: json["ZipCode"],
        countryId: json["CountryId"],
        isVerified: json["IsVerified"],
        isEnableNotificationsAlerts: json["IsEnableNotificationsAlerts"],
        isEnableEmailsAlerts: json["IsEnableEmailsAlerts"],
        isUploadDocumentStatus: json["IsUploadDocumentStatus"],
        isEmailUser: json["IsEmailUser"],
        stripeConnectAccountId: json["StripeConnectAccountId"],
        documentFrontImage: json["DocumentFrontImage"],
        documentBackImage: json["DocumentBackImage"],
        isAddedBankAccount: json["IsAddedBankAccount"],
        currency: json["Currency"],
        currencySymbol: json["CurrencySymbol"] ?? "\$",
      );

  Map<String, dynamic> toMap() => {
        "UserId": userId,
        "UserType": userType,
        "RoleId": roleId,
        "DisplayName": displayName,
        "FullName": fullName,
        "Email": email,
        "DOB": dob?.toIso8601String(),
        "ProfilePicture": profilePicture,
        "Address": address,
        "City": city,
        "State": state,
        "Country": country,
        "ZipCode": zipCode,
        "CountryId": countryId,
        "IsVerified": isVerified,
        "IsEnableNotificationsAlerts": isEnableNotificationsAlerts,
        "IsEnableEmailsAlerts": isEnableEmailsAlerts,
        "IsUploadDocumentStatus": isUploadDocumentStatus,
        "IsEmailUser": isEmailUser,
        "StripeConnectAccountId": stripeConnectAccountId,
        "DocumentFrontImage": documentFrontImage,
        "DocumentBackImage": documentBackImage,
        "IsAddedBankAccount": isAddedBankAccount,
        "CurrencySymbol": currencySymbol,
        "Currency": currency,
      };

  @override
  UserBasicDetailsModel decode(json) {
    userId = json["UserId"];
    userType = json["UserType"];
    roleId = json["RoleId"];
    displayName = json["DisplayName"];
    fullName = json["FullName"];
    email = json["Email"];
    dob = json["DOB"] == null ? null : DateTime.parse(json["DOB"]);
    profilePicture = json["ProfilePicture"];
    address = json["Address"];
    city = json["City"];
    state = json["State"];
    country = json["Country"];
    zipCode = json["ZipCode"];
    countryId = json["CountryId"];
    isVerified = json["IsVerified"];
    isEnableNotificationsAlerts = json["IsEnableNotificationsAlerts"];
    isEnableEmailsAlerts = json["IsEnableEmailsAlerts"];
    isUploadDocumentStatus = json["IsUploadDocumentStatus"];
    isEmailUser = json["IsEmailUser"];
    stripeConnectAccountId = json["StripeConnectAccountId"];
    documentFrontImage = json["DocumentFrontImage"];
    documentBackImage = json["DocumentBackImage"];
    isAddedBankAccount = json["IsAddedBankAccount"];
    currency = json["Currency"];
    currencySymbol = json["CurrencySymbol"] ?? "\$";
    return this;
  }
}
