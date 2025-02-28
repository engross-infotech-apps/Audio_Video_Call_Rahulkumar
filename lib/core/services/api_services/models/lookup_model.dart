import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';
import 'package:gokidu_app_tour/view/onboarding/models/country_model.dart';
import 'package:gokidu_app_tour/view/onboarding/models/eye_colors.dart';

class LookupModelPO {
  int? id;
  String name;
  String? subName;
  String? code;
  String? image;
  String? currency;
  bool isSelected, isRequested;
  bool? isFront, isBack;

  LookupModelPO({
    required this.id,
    required this.name,
    this.subName,
    this.code,
    this.image,
    this.currency,
    this.isSelected = false,
    this.isRequested = false,
    isFront = false,
    this.isBack = false,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "subName": subName,
        "code": code,
        "image": image,
        "currency": currency,
        "isSelected": isSelected,
        "isRequest": isRequested,
        "isBack": isBack,
        "isFront": isFront,
      };

  factory LookupModelPO.fromJson(Map<String, dynamic> json) => LookupModelPO(
        id: json["id"],
        name: json["name"],
        subName: json["subName"],
        code: json["code"],
        image: json["image"],
        currency: json["currency"],
        isSelected: json["isSelected"],
        isRequested: json["isRequest"],
        isBack: json["isBack"],
        isFront: json["isFront"],
      );
}

class AllLookUpModel implements Decodable<AllLookUpModel> {
  List<CountryModel>? country;
  // List<DocumentTypeModel>? documentType;
  List<Education>? education;
  List<EyeColorsModel>? eyeColor;
  List<HairColor>? hairColor;
  List<Religious>? religious;
  List<HeightModel>? height;
  List<Profession>? profession;
  List<Role>? role;
  List<AgeModel>? age;
  List<UserType>? userType;
  List<Ethnicity>? ethnicity;
  List<BloodGroup>? bloodGroup;
  List<AccountHolderTypeModel>? accountHolderType;
  List<ReimbursementType>? reimbursementType;
  List<ConversationFlag>? conversationFlag;
  List<MedicalReportType>? medicalReportType;
  List<IdentityDocumentType>? identityDocument;
  List<IdentityDocumentType>? addressDocument;

  AllLookUpModel({
    this.country,
    // this.documentType,
    this.education,
    this.eyeColor,
    this.hairColor,
    this.height,
    this.profession,
    this.role,
    this.age,
    this.userType,
    this.ethnicity,
    this.religious,
    this.bloodGroup,
    this.accountHolderType,
    this.reimbursementType,
    this.conversationFlag,
    this.medicalReportType,
    this.identityDocument,
    this.addressDocument,
  });

  @override
  AllLookUpModel decode(json) {
    country = [];
    // documentType = [];
    education = [];
    eyeColor = [];
    hairColor = [];
    height = [];
    profession = [];
    role = [];
    age = [];
    userType = [];
    ethnicity = [];
    religious = [];
    bloodGroup = [];
    accountHolderType = [];
    reimbursementType = [];
    conversationFlag = [];
    medicalReportType = [];
    identityDocument = [];
    addressDocument = [];

    if (json['Country'] != null) {
      json['Country'].forEach((item) {
        // CountryModel list = CountryModel().decode(item);
        // country?.add(list);
      });
    }

    if (json['DocumentType'] != null) {
      json['DocumentType'].forEach((item) {
        // DocumentTypeModel list = DocumentTypeModel().decode(item);
        // documentType?.add(list);
      });
    }

    if (json['Education'] != null) {
      json['Education'].forEach((item) {
        Education list = Education().decode(item);
        education?.add(list);
      });
    }

    if (json['EyeColor'] != null) {
      json['EyeColor'].forEach((item) {
        // EyeColorsModel dataEye = EyeColorsModel().decode(item);
        // eyeColor?.add(dataEye);
      });
    }

    if (json['Religious'] != null) {
      json['Religious'].forEach((item) {
        Religious list = Religious().decode(item);
        religious?.add(list);
      });
    }

    if (json['BloodGroup'] != null) {
      json['BloodGroup'].forEach((item) {
        BloodGroup list = BloodGroup().decode(item);
        bloodGroup?.add(list);
      });
    }

    if (json['HairColor'] != null) {
      json['HairColor'].forEach((item) {
        HairColor list = HairColor().decode(item);
        hairColor?.add(list);
      });
    }

    if (json['Height'] != null) {
      json['Height'].forEach((item) {
        HeightModel list = HeightModel().decode(item);
        height?.add(list);
      });
    }

    if (json['Ethnicity'] != null) {
      json['Ethnicity'].forEach((item) {
        Ethnicity list = Ethnicity().decode(item);
        ethnicity?.add(list);
      });
    }

    if (json['Profession'] != null) {
      json['Profession'].forEach((item) {
        Profession list = Profession().decode(item);
        profession?.add(list);
      });
    }

    if (json['AgeGroup'] != null) {
      json['AgeGroup'].forEach((item) {
        AgeModel list = AgeModel().decode(item);
        age?.add(list);
      });
    }

    if (json['Role'] != null) {
      json['Role'].forEach((item) {
        Role list = Role().decode(item);
        role?.add(list);
      });
    }
    if (json['UserType'] != null) {
      json['UserType'].forEach((item) {
        UserType list = UserType().decode(item);
        userType?.add(list);
      });
    }

    if (json['AccountHolderType'] != null) {
      json['AccountHolderType'].forEach((item) {
        AccountHolderTypeModel list = AccountHolderTypeModel().decode(item);
        accountHolderType?.add(list);
      });
    }

    if (json['ReimbursementType'] != null) {
      json['ReimbursementType'].forEach((item) {
        ReimbursementType list = ReimbursementType().decode(item);
        reimbursementType?.add(list);
      });
    }

    if (json['ConversationFlagType'] != null) {
      json['ConversationFlagType'].forEach((item) {
        ConversationFlag list = ConversationFlag().decode(item);
        conversationFlag?.add(list);
      });
    }

    if (json['MedicalReport'] != null) {
      json['MedicalReport'].forEach((item) {
        MedicalReportType list = MedicalReportType().decode(item);
        medicalReportType?.add(list);
      });
    }

    if (json['IdentityDocument'] != null) {
      json['IdentityDocument'].forEach((item) {
        IdentityDocumentType list = IdentityDocumentType().decode(item);
        identityDocument?.add(list);
      });
    }

    if (json['AddressDocument'] != null) {
      json['AddressDocument'].forEach((item) {
        IdentityDocumentType list = IdentityDocumentType().decode(item);
        addressDocument?.add(list);
      });
    }
    // role = List<Role>.from(json["role"].map((x) => Role.fromMap(x)));
    // userType =
    //     List<UserType>.from(json["userType"].map((x) => UserType.fromMap(x)));
    return this;
  }

  factory AllLookUpModel.fromMap(Map<String, dynamic> json) => AllLookUpModel(
        country: List<CountryModel>.from(
            json["country"].map((x) => CountryModel.fromMap(x))),
        // documentType: List<DocumentTypeModel>.from(
        //     json["documentType"].map((x) => DocumentTypeModel.fromMap(x))),
        education: List<Education>.from(
            json["education"].map((x) => Education.fromMap(x))),
        eyeColor: List<EyeColorsModel>.from(
            json["eyeColor"].map((x) => EyeColorsModel.fromMap(x))),
        hairColor: List<HairColor>.from(
            json["hairColor"].map((x) => HairColor.fromMap(x))),
        height: List<HeightModel>.from(
            json["height"].map((x) => HeightModel.fromMap(x))),
        profession: List<Profession>.from(
            json["profession"].map((x) => Profession.fromMap(x))),
        age: List<AgeModel>.from(
            json["ageGroup"].map((x) => AgeModel.fromMap(x))),
        role: List<Role>.from(json["role"].map((x) => Role.fromMap(x))),
        userType: List<UserType>.from(
            json["userType"].map((x) => UserType.fromMap(x))),
        ethnicity: List<Ethnicity>.from(
            json["ethnicity"].map((x) => Ethnicity.fromMap(x))),
        religious: List<Religious>.from(
            json["religious"].map((x) => Religious.fromMap(x))),
        bloodGroup: List<BloodGroup>.from(
            json["bloodGroup"].map((x) => BloodGroup.fromMap(x))),
        accountHolderType: List<AccountHolderTypeModel>.from(
            json["accountHolderType"]
                .map((x) => AccountHolderTypeModel.fromMap(x))),
        reimbursementType: List<ReimbursementType>.from(
            json["ReimbursementType"].map((x) => ReimbursementType.fromMap(x))),
        conversationFlag: List<ConversationFlag>.from(
            json["ConversationFlagType"]
                .map((x) => ConversationFlag.fromMap(x))),
        medicalReportType: List<MedicalReportType>.from(
            json["MedicalReport"].map((x) => MedicalReportType.fromMap(x))),
        identityDocument: json["IdentityDocument"] == null
            ? []
            : List<IdentityDocumentType>.from(json["IdentityDocument"]!
                .map((x) => IdentityDocumentType.fromJson(x))),
        addressDocument: json["AddressDocument"] == null
            ? []
            : List<IdentityDocumentType>.from(json["AddressDocument"]!
                .map((x) => IdentityDocumentType.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "country": country != null
            ? List<dynamic>.from(country!.map((x) => x.toMap()))
            : [],
        // "documentType": documentType != null
        //     ? List<dynamic>.from(documentType!.map((x) => x.toMap()))
        //     : [],
        "education": education != null
            ? List<dynamic>.from(education!.map((x) => x.toMap()))
            : [],
        "eyeColor": eyeColor != null
            ? List<dynamic>.from(eyeColor!.map((x) => x.toMap()))
            : [],
        "hairColor": hairColor != null
            ? List<dynamic>.from(hairColor!.map((x) => x.toMap()))
            : [],
        "height": height != null
            ? List<dynamic>.from(height!.map((x) => x.toMap()))
            : [],
        "profession": profession != null
            ? List<dynamic>.from(profession!.map((x) => x.toMap()))
            : [],
        "ageGroup":
            age != null ? List<dynamic>.from(age!.map((x) => x.toMap())) : [],
        "role":
            role != null ? List<dynamic>.from(role!.map((x) => x.toMap())) : [],
        "userType": userType != null
            ? List<dynamic>.from(userType!.map((x) => x.toMap()))
            : [],
        "ethnicity": ethnicity != null
            ? List<dynamic>.from(ethnicity!.map((x) => x.toMap()))
            : [],
        "religious": religious != null
            ? List<dynamic>.from(religious!.map((x) => x.toMap()))
            : [],
        "bloodGroup": bloodGroup != null
            ? List<dynamic>.from(bloodGroup!.map((x) => x.toMap()))
            : [],
        "accountHolderType": accountHolderType != null
            ? List<dynamic>.from(accountHolderType!.map((x) => x.toMap()))
            : [],
        "ReimbursementType": reimbursementType != null
            ? List<dynamic>.from(reimbursementType!.map((x) => x.toMap()))
            : [],
        "ConversationFlagType": conversationFlag != null
            ? List<dynamic>.from(conversationFlag!.map((x) => x.toMap()))
            : [],
        "MedicalReport": medicalReportType != null
            ? List<dynamic>.from(medicalReportType!.map((x) => x.toMap()))
            : [],
        "IdentityDocument": identityDocument == null
            ? []
            : List<dynamic>.from(identityDocument!.map((x) => x.toJson())),
        "AddressDocument": addressDocument == null
            ? []
            : List<dynamic>.from(addressDocument!.map((x) => x.toJson())),
      };
}

class Education implements Decodable<Education> {
  int? educationId;
  String? name;
  LookupModelPO? modelPO;
  Education({
    this.educationId,
    this.name,
    this.modelPO,
  });

  @override
  Education decode(json) {
    educationId = json["EducationId"];
    name = json["Name"];
    modelPO = LookupModelPO(id: json["EducationId"], name: json["Name"]);
    return this;
  }

  factory Education.fromMap(Map<String, dynamic> json) => Education(
        educationId: json["EducationId"],
        name: json["Name"],
        modelPO: LookupModelPO(id: json["EducationId"], name: json["Name"]),
      );

  Map<String, dynamic> toMap() => {
        "EducationId": educationId,
        "Name": name,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}

class AccountHolderTypeModel implements Decodable<AccountHolderTypeModel> {
  int? accountHolderTypeId;
  String? name;
  LookupModelPO? modelPO;

  AccountHolderTypeModel({
    this.accountHolderTypeId,
    this.name,
    this.modelPO,
  });

  factory AccountHolderTypeModel.fromMap(Map<String, dynamic> json) =>
      AccountHolderTypeModel(
        accountHolderTypeId: json["AccountHolderTypeId"],
        name: json["Name"],
        modelPO:
            LookupModelPO(id: json["AccountHolderTypeId"], name: json["Name"]),
      );

  Map<String, dynamic> toMap() => {
        "AccountHolderTypeId": accountHolderTypeId,
        "Name": name,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };

  @override
  AccountHolderTypeModel decode(json) {
    accountHolderTypeId = json["AccountHolderTypeId"];
    name = json["Name"];
    modelPO =
        LookupModelPO(id: json["AccountHolderTypeId"], name: json["Name"]);
    return this;
  }
}

class ReimbursementType implements Decodable<ReimbursementType> {
  int? reimbursementTypeId;
  String? name;
  String? subTitle;
  bool isRequested;
  bool? isDelivered;
  num? expenseCount;
  num? deliveryVerificationCount;

  LookupModelPO? modelPO;
  ReimbursementType({
    this.name,
    this.reimbursementTypeId,
    this.subTitle,
    this.modelPO,
    this.deliveryVerificationCount,
    this.expenseCount,
    this.isDelivered,
    this.isRequested = false,
  });
  factory ReimbursementType.fromMap(Map<String, dynamic> json) =>
      ReimbursementType(
        reimbursementTypeId: json["ReimbursementTypeId"],
        name: json["ReimbursementTypeName"],
        subTitle: json["ReimbursementTypeDescription"],
        deliveryVerificationCount: json["DeliveryVerificationCount"],
        expenseCount: json['ExpenseCount'],
        isDelivered: json['IsDelivered'],
        isRequested: json['IsRequested'] == 1 ? true : false,
        modelPO: LookupModelPO(
            id: json["ReimbursementTypeId"],
            name: json["ReimbursementTypeName"] ?? ""),
      );

  @override
  ReimbursementType decode(json) {
    reimbursementTypeId = json["ReimbursementTypeId"];
    name = json["ReimbursementTypeName"];
    subTitle = json["ReimbursementTypeDescription"];
    deliveryVerificationCount = json["DeliveryVerificationCount"];
    expenseCount = json['ExpenseCount'];
    isDelivered = json['IsDelivered'];
    isRequested = json['IsRequested'] == 1 ? true : false;
    modelPO = LookupModelPO(
        id: json["ReimbursementTypeId"],
        name: json["ReimbursementTypeName"] ?? "");

    return this;
  }

  Map<String, dynamic> toMap() => {
        "ReimbursementTypeId": reimbursementTypeId,
        "ReimbursementTypeName": name ?? "",
        "ReimbursementTypeDescription": subTitle,
        "ExpenseCount": expenseCount,
        "IsRequested": isRequested,
        "DeliveryVerificationCount": deliveryVerificationCount,
        "IsDelivered": isDelivered,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
  /*      {
        "ReimbursementTypeId": "TravelExpense",
        "Name": "Travel expense"
      } */
}

class ConversationFlag implements Decodable<ConversationFlag> {
  int? conversationFlagId;
  String? title;
  String? subtitle;
  LookupModelPO? modelPO;

  ConversationFlag(
      {this.conversationFlagId, this.subtitle, this.title, this.modelPO});
  @override
  ConversationFlag decode(json) {
    conversationFlagId = json["ConversationFlagId"];
    title = json["Title"];
    subtitle = json["Subtitle"];
    modelPO = LookupModelPO(
        id: json["ConversationFlagId"],
        name: json["Title"],
        subName: json["Subtitle"]);
    return this;
  }

  factory ConversationFlag.fromMap(Map<String, dynamic> json) =>
      ConversationFlag(
        conversationFlagId: json["ConversationFlagId"],
        title: json["Title"],
        subtitle: json["Subtitle"],
        modelPO: LookupModelPO(
            id: json["ConversationFlagId"],
            name: json["Title"],
            subName: json["Subtitle"]),
      );

  Map<String, dynamic> toMap() => {
        "ConversationFlagId": conversationFlagId,
        "Title": title,
        "Subtitle": subtitle,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}

class Religious implements Decodable<Religious> {
  int? religionId;
  String? name;
  LookupModelPO? modelPO;
  Religious({
    this.religionId,
    this.name,
    this.modelPO,
  });

  @override
  Religious decode(json) {
    religionId = json["ReligiousId"];
    name = json["Name"];
    modelPO = LookupModelPO(id: json["ReligiousId"], name: json["Name"]);
    return this;
  }

  factory Religious.fromMap(Map<String, dynamic> json) => Religious(
        religionId: json["ReligiousId"],
        name: json["Name"],
        modelPO: LookupModelPO(id: json["ReligiousId"], name: json["Name"]),
      );

  Map<String, dynamic> toMap() => {
        "ReligiousId": religionId,
        "Name": name,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}

class AgeModel implements Decodable<AgeModel> {
  int? ageId;
  String? title;
  int? from;
  int? to;
  LookupModelPO? modelPO;

  AgeModel({this.ageId, this.title, this.from, this.to, this.modelPO});

  factory AgeModel.fromMap(Map<String, dynamic> json) => AgeModel(
        ageId: json["AgeGroupId"],
        title: json["Title"],
        from: json["From"],
        to: json['To'],
        modelPO: LookupModelPO(id: json["AgeGroupId"], name: json["Title"]),
      );

  @override
  AgeModel decode(json) {
    ageId = json["AgeGroupId"];
    title = json["Title"];
    from = json["From"];
    to = json['To'];
    modelPO = LookupModelPO(id: json["AgeGroupId"], name: json["Title"]);

    return this;
  }

  Map<String, dynamic> toMap() => {
        "AgeGroupId": ageId,
        "Title": title,
        "From": from,
        "To": to,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}

class BloodGroup implements Decodable<BloodGroup> {
  String? name;
  int? id;
  LookupModelPO? modelPO;
  BloodGroup({
    this.name,
    this.id,
    this.modelPO,
  });

  @override
  BloodGroup decode(json) {
    name = json["GroupName"];
    id = json["BloodGroupId"];
    modelPO = LookupModelPO(id: json["BloodGroupId"], name: json["GroupName"]);
    return this;
  }

  factory BloodGroup.fromMap(Map<String, dynamic> json) => BloodGroup(
        name: json["GroupName"],
        id: json["BloodGroupId"],
        modelPO:
            LookupModelPO(id: json["BloodGroupId"], name: json["GroupName"]),
      );

  Map<String, dynamic> toMap() => {
        "GroupName": name,
        "BloodGroupId": id,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}

class HairColor implements Decodable<HairColor> {
  int? hairColorId;
  String? color;
  String? image;
  LookupModelPO? modelPO;

  HairColor({this.hairColorId, this.color, this.image, this.modelPO});

  factory HairColor.fromMap(Map<String, dynamic> json) => HairColor(
        hairColorId: json["HairColorId"],
        color: json["Color"],
        image: json["Image"],
        modelPO: LookupModelPO(
            id: json["HairColorId"], name: json["Color"], image: json['Image']),
      );

  @override
  HairColor decode(json) {
    hairColorId = json["HairColorId"];
    color = json["Color"];
    image = json["Image"];
    modelPO = LookupModelPO(
        id: json["HairColorId"], name: json["Color"], image: json['Image']);

    return this;
  }

  Map<String, dynamic> toMap() => {
        "HairColorId": hairColorId,
        "Color": color,
        "Image": image,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}

class HeightModel implements Decodable<HeightModel> {
  int? heightId;
  String? heightRange;
  String? description;

  HeightModel({
    this.heightId,
    this.heightRange,
    this.description,
  });

  factory HeightModel.fromMap(Map<String, dynamic> json) => HeightModel(
        heightId: json["HeightId"],
        heightRange: json["HeightRange"],
        description: json["Description"],
      );

  @override
  HeightModel decode(json) {
    heightId = json["HeightId"];
    heightRange = json["HeightRange"];
    description = json["Description"];
    return this;
  }

  Map<String, dynamic> toMap() => {
        "HeightId": heightId,
        "HeightRange": heightRange,
        "Description": description,
      };
}

class Ethnicity implements Decodable<Ethnicity> {
  int? ethnicityId;
  String? name;
  LookupModelPO? modelPO;

  Ethnicity({this.ethnicityId, this.name, this.modelPO});

  factory Ethnicity.fromMap(Map<String, dynamic> json) => Ethnicity(
        ethnicityId: json["EthnicityId"],
        name: json["Name"],
        modelPO: LookupModelPO(id: json["EthnicityId"], name: json["Name"]),
      );

  @override
  Ethnicity decode(json) {
    ethnicityId = json["EthnicityId"];
    name = json["Name"];
    modelPO = LookupModelPO(id: json["EthnicityId"], name: json["Name"]);

    return this;
  }

  Map<String, dynamic> toMap() => {
        "EthnicityId": ethnicityId,
        "Name": name,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}

class Profession implements Decodable<Profession> {
  int? professionId;
  String? name;
  LookupModelPO? modelPO;

  Profession({
    this.professionId,
    this.name,
    this.modelPO,
  });

  factory Profession.fromMap(Map<String, dynamic> json) => Profession(
        professionId: json["ProfessionId"],
        name: json["Name"],
        modelPO: LookupModelPO(id: json["ProfessionId"], name: json["Name"]),
      );

  @override
  Profession decode(json) {
    professionId = json["ProfessionId"];
    name = json["Name"];
    modelPO = LookupModelPO(id: json["ProfessionId"], name: json["Name"]);

    return this;
  }

  Map<String, dynamic> toMap() => {
        "ProfessionId": professionId,
        "Name": name,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}

class Role implements Decodable<Role> {
  int? roleId;
  String? name;
  LookupModelPO? modelPO;

  Role({this.roleId, this.name, this.modelPO});

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        roleId: json["RoleId"],
        name: json["Name"],
      );

  @override
  Role decode(json) {
    roleId = json["RoleId"];
    name = json["Name"];
    return this;
  }

  Map<String, dynamic> toMap() => {
        "RoleId": roleId,
        "Name": name,
      };
}

class UserType implements Decodable<UserType> {
  int? userTypeId;
  String? name;
  LookupModelPO? modelPO;

  UserType({
    this.userTypeId,
    this.name,
  });

  factory UserType.fromMap(Map<String, dynamic> json) => UserType(
        userTypeId: json["UserTypeId"],
        name: json["Name"],
      );

  @override
  UserType decode(json) {
    userTypeId = json["UserTypeId"];
    name = json["Name"];
    return this;
  }

  Map<String, dynamic> toMap() => {
        "UserTypeId": userTypeId,
        "Name": name,
      };
}

class MedicalReportType implements Decodable<MedicalReportType> {
  int? medicalReportId;
  String? medicalReportName;
  String? medicalReportDescription;
  LookupModelPO? modelPO;
  MedicalReportType(
      {this.medicalReportDescription,
      this.medicalReportId,
      this.medicalReportName,
      this.modelPO});

  factory MedicalReportType.fromMap(Map<String, dynamic> json) =>
      MedicalReportType(
        medicalReportId: json["MedicalReportId"],
        medicalReportName: json["MedicalReportName"],
        medicalReportDescription: json["MedicalReportDescription"],
        modelPO: LookupModelPO(
            id: json["MedicalReportId"],
            name: json["MedicalReportName"],
            subName: json["MedicalReportDescription"]),
      );

  @override
  MedicalReportType decode(json) {
    medicalReportId = json["MedicalReportId"];
    medicalReportName = json["MedicalReportName"];
    medicalReportDescription = json["MedicalReportDescription"];
    modelPO = LookupModelPO(
        id: json["MedicalReportId"],
        name: json["MedicalReportName"],
        subName: json["MedicalReportDescription"]);
    return this;
  }

  Map<String, dynamic> toMap() => {
        "MedicalReportId": medicalReportId,
        "MedicalReportName": medicalReportName,
        "MedicalReportDescription": medicalReportDescription,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };
}

class IdentityDocumentType implements Decodable<IdentityDocumentType> {
  int? documentId;
  String? documentType;
  String? description;
  bool? isFront;
  bool? isBack;
  LookupModelPO? modelPO;

  IdentityDocumentType({
    this.documentId,
    this.documentType,
    this.description,
    this.isFront,
    this.isBack,
    this.modelPO,
  });

  factory IdentityDocumentType.fromJson(Map<String, dynamic> json) =>
      IdentityDocumentType(
        documentId: json["DocumentID"],
        documentType: json["DocumentType"],
        description: json["Description"],
        isFront: json["IsFront"],
        isBack: json["IsBack"],
        modelPO: LookupModelPO(
          id: json["DocumentID"],
          name: json["DocumentType"],
          isBack: json["IsBack"],
          isFront: json["IsFront"],
        ),
      );

  Map<String, dynamic> toJson() => {
        "DocumentID": documentId,
        "DocumentType": documentType,
        "Description": description,
        "IsFront": isFront,
        "IsBack": isBack,
        "modelPO": modelPO != null ? modelPO!.toMap() : [],
      };

  @override
  IdentityDocumentType decode(json) {
    documentId = json["DocumentID"];
    documentType = json["DocumentType"];
    description = json["Description"];
    isFront = json["IsFront"];
    isBack = json["IsBack"];
    modelPO = LookupModelPO(
      id: json["DocumentID"],
      name: json["DocumentType"],
      isBack: json["IsBack"],
      isFront: json["IsFront"],
    );
    return this;
  }
}
