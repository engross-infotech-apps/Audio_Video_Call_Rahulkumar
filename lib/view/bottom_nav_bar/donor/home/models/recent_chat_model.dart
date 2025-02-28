enum MessType { Photo, Video, askCharges, Doc }

class RecentChatModel {
  int? userId;
  String? profilePicture;
  String? fullName;
  bool? isVerify;
  DateTime? dateTime;
  String? messageBody;
  MessType? messType;
  

  RecentChatModel(
      {this.fullName,
      this.userId,
      this.profilePicture,
      this.messType,
      this.messageBody,
      this.isVerify,
      this.dateTime});
}
