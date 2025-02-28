enum AccountDeleteType {
  deactivate(1),
  deleteAccount(2);

  const AccountDeleteType(this.number);

  final int number;
}

enum SocialLoginProvider {
  google(1),
  facebook(2),
  apple(3);

  const SocialLoginProvider(this.number);

  final int number;
}

enum UserRole {
  recipient(1, 'Recipient'),
  donor(2, 'Donor'),
  unknown(-1, '');

  const UserRole(this.number, this.value);

  final int number;
  final String value;

  static String getValue(int number) => UserRole.values
      .firstWhere((role) => role.number == number,
          orElse: () => UserRole.unknown)
      .value;

  static UserRole getType(int number) =>
      UserRole.values.firstWhere((role) => role.number == number,
          orElse: () => UserRole.unknown);
}

enum PregnancyTypes {
  sperm(1, "Sperm"),
  egg(2, "Egg"),
  embryo(3, "Embryo"),
  surrogate(4, "Surrogate"),
  unknown(-1, '');

  const PregnancyTypes(this.number, this.value);

  final int number;
  final String value;

  static String getValue(int number) => PregnancyTypes.values
      .firstWhere((type) => type.number == number,
          orElse: () => PregnancyTypes.unknown)
      .value;

  static PregnancyTypes getType(int number) =>
      PregnancyTypes.values.firstWhere((type) => type.number == number,
          orElse: () => PregnancyTypes.unknown);
}

enum EggType {
  extraction(1, "Extraction"),
  preservation(2, "Preservation"),
  unknown(-1, '');

  const EggType(this.number, this.value);

  final int number;
  final String value;

  static String getValue(int number) => EggType.values
      .firstWhere((type) => type.number == number,
          orElse: () => EggType.unknown)
      .value;
}

enum ChargeRequestType {
  reimbursement(1, "Reimbursement"),
  medicalReport(2, "MedicalReport"),
  unknown(-1, '');

  final int number;
  final String value;

  const ChargeRequestType(this.number, this.value);
}

enum ReportResult {
  negative(1, "Negative"),
  positive(2, "Positive"),
  notTested(3, "Not tested"),
  unknown(-1, '');

  const ReportResult(this.number, this.value);

  final int number;
  final String value;

  static String getValue(int number) => ReportResult.values
      .firstWhere((type) => type.number == number,
          orElse: () => ReportResult.unknown)
      .value;
}

enum NotificationType {
  reportRequest("medicalReportRequest"),
  reportShareNew("medicalReportShareNew"),
  reimbursementRequest("reimbursementRequest"),
  askPayment("askPayment"),
  deliveryRequest("deliveryRequest"),
  deliveryRejected("deliveryRejected"),
  Like("like"),
  Rating("rating"),
  Chat("chat"),
  Verification("verification");
  // anonyms();

  const NotificationType(this.value);

  final String value;
}

enum LayoutStyle {
  list(1, 'List'),
  grid(2, 'Grid'),
  unknown(-1, '');

  const LayoutStyle(this.number, this.value);

  final int number;
  final String value;
}

enum UserActions {
  like(1, 'Like', 1, "assets/svgs/thumb_up.svg"),
  dislike(2, 'Dislike', 3, "assets/svgs/thumb_down.svg"),
  maybe(3, 'Maybe', 2, "assets/svgs/maybe_filled.svg"),
  likeByOther(4, 'Like By Other', 0, "assets/svgs/thumb_up.svg"),
  unknown(-1, '', -1, '');

  const UserActions(this.number, this.value, this.tabIndex, this.icon);

  final int number;
  final int tabIndex;
  final String value;
  final String icon;

  static UserActions getActionByIndex(int index) =>
      UserActions.values.firstWhere((type) => type.tabIndex == index,
          orElse: () => UserActions.unknown);
}

enum UploadImageStatus {
  isNotSelected,
  isUploading,
  isUploadSuccess,
  isUploadFailed
}

enum UnitsOfMeasurement {
  meters,
  feet,
  inches,
  centimeters,
  millimeters,
}

enum LastActivity {
  donorAddChagresBeforePay(60, 'donor-chat-add-new-report-before-payment'),
  recipientViewNewReportCharge(61, 'recipient-chat-view-new-report-charge'),
  donorViewInvoice(62, 'donor-chat-view-invoice'),
  donorAddNewReportAfterPay(63, 'donor-chat-add-new-report-after-payment'),
  donorAddExistingReport(64, 'donor-chat-add-existing-report'),
  recipientViewSharedExistingReport(
      65, 'recipient-chat-view-shared-existing-report'),
  donorExploreGetRecipient(24, "donor-explore-get-recipient"),
  getDonorProfile(25, "donor-get-profile"),
  donorChatGetRecipient(30, "donor-chat-get-recipient"),
  recipientExploreGetDonor(45, "recipient-explore-get-donor"),
  getRecipientProfile(46, "recipient-get-profile"),
  recipientChatGetDonor(49, "recipient-chat-get-donor"),
  chatPage(66, "chat-page"),
  settingPage(67, "setting-page"),
  blockUser(68, "block-user"),
  legalGuidance(19, "legal-guidance"),
  unknown(-1, '');

  const LastActivity(this.number, this.value);

  final int number;
  final String value;
}

extension UnitsOfMeasurementExtension on UnitsOfMeasurement {
  double get inMeters {
    switch (this) {
      case UnitsOfMeasurement.meters:
        return 1.0;
      case UnitsOfMeasurement.feet:
        return 3.28;
      case UnitsOfMeasurement.inches:
        return 39.3700787402;
      case UnitsOfMeasurement.centimeters:
        return 100.0;
      case UnitsOfMeasurement.millimeters:
        return 1000.0;
      default:
        throw ArgumentError('Invalid UnitsOfMeasurement: $this');
    }
  }

  double convert(double value, UnitsOfMeasurement to) =>
      value / inMeters * to.inMeters;
}
