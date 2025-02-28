import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/api_services/http_request/api_response.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/lookup_model.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
import 'package:gokidu_app_tour/view/chat/model/room.dart';
import 'package:gokidu_app_tour/view/chat/model/user.dart';
import 'package:gokidu_app_tour/view/chat/widget/mess_bubble.dart';

class ChatViewController extends GetxController {
  var selectedOption;
  var isAttachmentUploading = false.obs;
  final TextEditingController messController = TextEditingController();
  var isOpen = true.obs;
  var isMessage = false.obs;
  var errorMess = "".obs;
  Room? roomData;
  User? otherUser;
  var otherReportList = <LookupModelPO>[].obs;

  PlatformFile? testReport;
  var flagOptionList = <LookupModelPO>[].obs;
  bool isCheck = false;
  var isAnonymous = false.obs;

  init() {
    tempChat = [
      MessBubble(
        isNotLast: false,
        isSend: true,
        child: textMessBuilder(
            "Good, i am also looking for ${AppStorage.getUserData()!.roleId != UserRole.recipient.number ? "recipient" : "donor"}"),
      ),
      MessBubble(
        isNotLast: false,
        isSend: false,
        child: textMessBuilder(
            "Hello i am finding ${AppStorage.getUserData()!.roleId != UserRole.recipient.number ? "donor" : "recipient"}"),
      ),
      MessBubble(
        isNotLast: false,
        child: textMessBuilder("Hellow how can i help you ??"),
        isSend: true,
      ),
    ];
  }

  List<String> extensionsForReport = [
    'pdf',
    'PDF',
    'jpg',
    'JPG',
    'JPEG',
    'jpeg',
    'png',
    'PNG'
  ];

  Widget textMessBuilder(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        text,
        style: AppFontStyle.blackRegular16pt,
      ),
    );
  }

  var tempChat = <MessBubble>[];
  var optionList = <LookupModelPO>[
    LookupModelPO(id: 1, name: "Document", image: AppSvgIcons.document),
    LookupModelPO(id: 2, name: "Camera", image: AppSvgIcons.camera),
    LookupModelPO(id: 3, name: "Gallery", image: AppSvgIcons.imageGallery),
    // LookupModelPO(id: 4, name: "Audio", image: AppSvgIcons.apple),
    LookupModelPO(id: 5, name: "Location", image: AppSvgIcons.simpleMarkerPng),
    // LookupModelPO(
    //     id: 6,
    //     name: AppStorage.getUserData()!.roleId == UserRole.recipient.number
    //         ? "Ask charges"
    //         : "Share reimbursement",
    //     image: AppSvgIcons.currencyDollar),
    LookupModelPO(
        id: 7,
        name: AppStorage.getUserData()!.roleId == UserRole.recipient.number
            ? "Request medical reports"
            : "Share medical reports",
        image: AppSvgIcons.medicalReports),
    // LookupModelPO(
    //     id: 8,
    //     name: "Delivery verification",
    //     image: AppSvgIcons.deliveryVerification),
  ];

  @override
  onInit() async {
    // await getLookUpData();
    var dv = LookupModelPO(
        id: 8,
        name: "Delivery verification",
        image: AppSvgIcons.deliveryVerification);
    var sr = LookupModelPO(
        id: 6, name: "Share reimbursement", image: AppSvgIcons.currencyDollar);
    if (AppStorage.getUserData()!.roleId == UserRole.donor.number &&
        !optionList.contains(dv)) {
      optionList.add(sr);
      optionList.add(dv);
    }

    AllLookUpModel? list;
    var getApi = AppStorage.getLookupApi();

    var response = await ResponseWrapper.init(
        create: () =>
            APIResponse<AllLookUpModel>(create: () => AllLookUpModel()),
        data: await DefaultAssetBundle.of(
                NavigationService.navigatorKey.currentContext!)
            .loadString("assets/json/all_lookup.json"));

    list = response.response.data;

    if (list != null) {
      for (var element in list.medicalReportType ?? []) {
        otherReportList.add(element.modelPO!);
      }
    }
    // await getServiceCharge();
    super.onInit();
  }
/*

  checkRegExp(String mess) {
    RegExp regExp = RegExp(r'^[+]{1}(?:[0-9\-\(\)\/\.]?\s?){6,15}[0-9]{1}\$');
    if (!mess.contains(regExp)) {
    } else {
      errorMess.value = "Personal details are not allow";
    }
  }

  Future<void> appLaunchUrl(url) async {
    var uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  setAttachmentUploading(bool uploading) {
    isAttachmentUploading.value = uploading;
  }

  ///--------------------------------------------------------------------------------

  getDonorReportsList({String? id}) async {
    var uid = id ?? AppStorage.getUserData()!.userId.toString();
    donorReportList.value = [];
    try {
      var list = await ChatApi().getDonorReportsList(uid);
      List<ReportModel> reports = list?.reports ?? [];
      donorReportList.addAll(reports);
      isAnonymous.value = list?.isAnonymous ?? false;
      return reports;
    } catch (e) {
      await showDialog(
        context: Get.context!,
        builder: (context) => AlertMsgDialog(
            title: "Error",
            msg: e.toString(),
            secondaryText: "Close",
            image: AppSvgIcons.report,
            secondaryBtnTap: () {
              Navigator.pop(context);
            }),
      );
    }
  }

  shareDonorExistingReports(Map parameters) async {
    try {
      await ChatApi().shareExistingReports(parameters);
      Get.back();
    } catch (e) {
      await showDialog(
        context: Get.context!,
        builder: (context) => AlertMsgDialog(
            title: "Error",
            msg: e.toString(),
            secondaryText: "Close",
            image: AppSvgIcons.report,
            secondaryBtnTap: () {
              Navigator.pop(context);
            }),
      );
    }
  }

  // reportsBottomSheet(ImageMessage message) {
  //   showLookupBottomSheet(
  //     child: SafeArea(
  //         child:
  //             ReportsBottomsheetView(roomId: roomData!.id, message: message)),
  //   );
  // }

  Future<AttachmentDetails?> uploadFile(PlatformFile report,
      {ReportType? type, String? name}) async {
    var res = await FileApi().uploadSingleFile(report.path!, showLoader: true);
    if (res?.originalUrl != null) {
      var uri = res?.originalUrl;
      var reportName = report.name;
      var size = File(report.path!).lengthSync();
      return AttachmentDetails(
          uri: uri!, name: name ?? reportName, size: size, reportType: type);
    }
    return null;
  }

  reportUploaded(String roomId) async {
    setAttachmentUploading(true);

    List<AttachmentDetails> reports = [];
    for (var e in donorReportList) {
      // int i = donorReportList.indexOf(e);
      var details = AttachmentDetails(
          uri: e.reportUrl!,
          name: e.reportName,
          size: 3215678,
          reportType: ReportType.getType(e.reportType!));

      reports.add(details);
    }
    if (reports.isNotEmpty) {
      try {
        final message =  PartialImage(
            attachment: Attachment(
                details: reports,
                type:  AttachmentMessageType.reportUploading));

        FirebaseChatCore.instance.sendMessage(message, roomId, otherUser!.id!);
        setAttachmentUploading(false);
      } catch (e) {
        debugPrint("---------errrroeeerrrrr-------$e");
      } finally {
        setAttachmentUploading(false);
      }
    }
  }

  void handleReportSelection() async {
    setAttachmentUploading(true);

    if (AppStorage.getUserData()!.roleId == UserRole.recipient.number) {
      await showLookupBottomSheet(child: RequestExistingDonorReport());
      // try {
      // var details = const AttachmentDetails(uri: "");
      // final message =  PartialImage(
      //     attachment: Attachment(
      //         details: [details],
      //         type:  AttachmentMessageType.reportRequest));

      //   FirebaseChatCore.instance.sendMessage(message, roomData. .value?.id ?? "");
      //   setAttachmentUploading(false);
      // } finally {
      //   setAttachmentUploading(false);
    } else {
      Get.to(ShareDonorReportBottomSheet());
      // await showLookupBottomSheet(
      //     child: ReportsDonorBottomsheetView(
      //   roomId: roomData. .value!.id,
      //   user: User(
      //     id: AppStorage.getUserData()!.userId.toString(),
      //     userId: AppStorage.getUserData()!.userId.toString(),
      //   ),
      // ));
      // Get.to(ShareChatDonorReportPage());
      // await reportsBottomSheet(ImageMessage(
      //   author: User(
      //     id: AppStorage.getUserData()!.userId.toString(),
      //     userId: AppStorage.getUserData()!.userId.toString(),
      //   ),
      //   id: AppStorage.getUserData()!.userId.toString(),
      //   attachment: Attachment(details: [], type: null),
      // ));
    }
  }

  ///--------------------------------------------------------------------------

  void handleLocationSelection() async {
    Get.to(
      AddressPicker(
        onTap: (add, lat, long) async {
          Get.back();
          await isRoomExits();

          await setAttachmentUploading(true);

          final message =  PartialLocation(latitude: lat, longitude: long);

          try {
            await FirebaseChatCore.instance
                .sendMessage(message, roomData?.id ?? "", otherUser!.id!);
            await setAttachmentUploading(false);
          } catch (e) {
            debugPrint("---errroerrr---$e");
          } finally {
            await setAttachmentUploading(false);
          }
        },
      ),
    );
  }

  void handlePaymentSelection() async {
    setAttachmentUploading(true);
    try {
      // if (AppStorage.getUserData()?.roleId == 2) {
      await showLookupBottomSheet(
              child: PaymentRequestBottomSheet(user: otherUser!))
          .then((v) {});

      setAttachmentUploading(false);
    } catch (e) {
      debugPrint("$e ====================================================");
    } finally {
      setAttachmentUploading(false);
    }
  }

  void handleDeliverySelection() async {
    // var data = await FirebaseFirestore.instance
    //     .collection("rooms")
    //     .doc(roomData!.id)
    //     .get();
    // var paymentRequestId = data.data()?["paymentRequestId"];
    // if (paymentRequestId == null) {
    //   await showDialog(
    //     context: Get.context!,
    //     builder: (context) => AlertMsgDialog(
    //         title: "Alert",
    //         msg:
    //             "Please initiate a payment request to proceed with the delivery.",
    //         secondaryText: "Close",
    //         // image: AppSvgIcons.report,
    //         secondaryBtnTap: () {
    //           Navigator.pop(context);
    //         }),
    //   );
    // } else {
    setAttachmentUploading(true);
    try {
      var parameters = {
        "RecipientUserId": int.parse(otherUser!.userId.toString())
      };
      var requestList = await ChatApi().getDeliveryVerification(parameters);
      var medicalReportList = requestList?.medicalReport ?? [];
      var reimbursementList = requestList?.reimbursement ?? [];
      if (medicalReportList.isEmpty && reimbursementList.isEmpty) {
        await showDialog(
          context: Get.context!,
          builder: (context) => AlertMsgDialog(
              title: "Alert",
              msg:
                  "Please initiate a payment request to proceed with the delivery.",
              secondaryText: "Close",
              secondaryBtnTap: () {
                Navigator.pop(context);
              }),
        );
      } else {
        await showLookupBottomSheet(
            child: DeliveryVerificationBottomSheet(
                user: otherUser!, requestList: requestList));
      }

      setAttachmentUploading(false);
    } catch (e) {
      await showDialog(
        context: Get.context!,
        builder: (context) => AlertMsgDialog(
            title: "Alert",
            msg:
                "Please initiate a payment request to proceed with the delivery.",
            secondaryText: "Close",
            secondaryBtnTap: () {
              Navigator.pop(context);
            }),
      );
    } finally {
      setAttachmentUploading(false);
    }
    // }
  }

  void handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null && result.files.single.path != null) {
      // await Get.to(AttachmentDocPreview(document: result.files.single));
      PlatformFile resultFile = result.files.first;
      if (resultFile.size > GlobalValue.maxFileSized) {
        showDialog(
          context: Get.context!,
          builder: (context) => AlertMsgDialog(
            title: "Warning",
            msg:
                "Please make sure the file size you choose is under the 15MB limit.",
            primaryText: CustomText.ok,
            primaryBtnTap: () {
              Get.back();
            },
          ),
        );
      } else {
        await Get.to(AttachmentDocPreview(document: result.files.single));
      }
      //   setAttachmentUploading(true);

      //   try {
      // var details = await uploadFile(result.files.single);
      //     final message =  PartialImage(
      //         attachment: Attachment(
      //             details: [details!], type:  AttachmentMessageType.file));

      //     FirebaseChatCore.instance.sendMessage(
      //       message,
      //       roomData. !.id,
      //     );
      //     setAttachmentUploading(false);
      //   } finally {
      //     setAttachmentUploading(false);
      //   }
    }
  }

  sendMessageFile(PlatformFile doc) async {
    showLoadingDialog();
    if (roomData == null) {
      final newRoom = await FirebaseChatCore.instance
          .createRoom(otherUser!, createNewRoom: true);
      roomData = await newRoom;
    }
    await setAttachmentUploading(true);

    try {
      var details = await uploadFile(doc);
      final message =  PartialImage(
          attachment: Attachment(
              details: [details!], type:  AttachmentMessageType.file));

      await FirebaseChatCore.instance
          .sendMessage(message, roomData!.id, otherUser!.id!);
      await closeLoadingDialog();

      await setAttachmentUploading(false);
    } catch (e) {
      await closeLoadingDialog();
    } finally {
      await setAttachmentUploading(false);
    }
  }

  Future<List<AttachmentDetails>> uploadMultiFile(List<XFile> _images) async {
    List<AttachmentDetails> imgUrls = [];
    try {
      var res = await FileApi()
          .uploadMultipleFile(_images.map((e) => e.path).toList());
      // res.map((e) {
      if (res.isNotEmpty) {
        for (int i = 0; i < res.length; i++) {
          var name = _images[i].name;
          var size = File(_images[i].path).lengthSync();
          var details = AttachmentDetails(
              uri: res[i].originalUrl!, name: name, size: size);
          imgUrls.add(details);
        }
        return imgUrls;
      }
    } catch (e) {
      debugPrint("----ee---$e");
    }

    return imgUrls;
  }

  void handleImageSelection(bool isGallery) async {
    List<AttachmentDetails> urls = [];

    if (isGallery) {
      final imgs = await ImagePicker().pickMultiImage(
        imageQuality: 70,
        maxWidth: 1440,
      );
      if (imgs.length > 0) {
        Get.to(AttachmentPreview(
          list: imgs,
          name: otherUser?.displayName ?? otherUser?.fullName ?? "N/A",
        ));
      }
      // urls = await uploadMultiFile(imgs);
    } else {
      var img = await ImagePicker().pickImage(
        imageQuality: 70,
        maxWidth: 1440,
        source: ImageSource.camera,
      );
      if (img != null) {
        var res = await FileApi().uploadSingleFile(img.path);
        if (res != null) {
          var uri = res.originalUrl!;
          var name = img.name;
          var size = File(img.path).lengthSync();
          var url = AttachmentDetails(uri: uri, name: name, size: size);
          urls.add(url);
        }
      }

      if (urls.isNotEmpty) {
        if (roomData == null) {
          showLoadingDialog();
          final newRoom = await FirebaseChatCore.instance
              .createRoom(otherUser!, createNewRoom: true);
          await closeLoadingDialog();
          roomData = await newRoom;
        }

        await setAttachmentUploading(true);
        try {
          final message = await  PartialImage(
              attachment: Attachment(
                  details: urls, type:  AttachmentMessageType.image));

          await FirebaseChatCore.instance
              .sendMessage(message, roomData!.id, otherUser!.id!);

          await setAttachmentUploading(false);
        } catch (e) {
          debugPrint("--errroerrr----$e");
        } finally {
          await setAttachmentUploading(false);
        }
      }
    }
  }

  sendImgMessage(List<XFile> imgs) async {
    var urls = await uploadMultiFile(imgs);
    if (urls.isNotEmpty) {
      await isRoomExits();
      await setAttachmentUploading(true);

      try {
        final message =  PartialImage(
            attachment: Attachment(
                details: urls, type:  AttachmentMessageType.image));

        await FirebaseChatCore.instance
            .sendMessage(message, roomData!.id, otherUser!.id!);

        await setAttachmentUploading(false);
      } catch (e) {
        debugPrint("--errroerrr----$e");
      } finally {
        setAttachmentUploading(false);
      }
    }
  }

  Future<bool> isRoomExits() async {
    if (roomData == null) {
      showLoadingDialog();
      final newRoom = await FirebaseChatCore.instance
          .createRoom(otherUser!, createNewRoom: true);
      await closeLoadingDialog();
      roomData = await newRoom;

      return true;
    }
    return true;
  }

  /*void handleMessageTap(BuildContext _,  Message message) async {
    if (message is  FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            roomData!.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            roomData!.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }*/

  void handlePreviewDataFetched(
     TextMessage message,
     PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, roomData!.id);
  }

  Future<void> handleSendPressed( PartialText message) async {
    if (roomData != null) {
      if (message.text.isNotEmpty) {
        FirebaseChatCore.instance
            .sendMessage(message, roomData!.id, otherUser!.id!);
      }
      messController.text = "";
    } else {
      await showLoadingDialog();
      final newRoom = await FirebaseChatCore.instance
          .createRoom(otherUser!, createNewRoom: true);
      roomData = await newRoom;
      await closeLoadingDialog();
      if (message.text.isNotEmpty) {
        await FirebaseChatCore.instance
            .sendMessage(message, roomData!.id, otherUser!.id!);
        messController.text = "";
      }
    }
  }

  bool blockDialog() {
    if (roomData!.blockUser != null && roomData!.blockUser!.isNotEmpty) {
      var isBLockedBy = roomData!.blockUser!
          .contains(FirebaseChatCore.instance.firebaseUser?.id);
      animatedDialog(
          child: Container(
        width: AppScreenSize.width / 1.5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isBLockedBy
                    ? "Blocked by ${otherUser?.displayName ?? otherUser?.fullName ?? "User"}"
                    : "Blocked ${otherUser?.displayName ?? otherUser?.fullName ?? "User"}",
                style: AppFontStyle.blackRegular16pt
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              vSpace(20),
              Text(
                isBLockedBy
                    ? "You have been blocked by ${otherUser?.displayName ?? otherUser?.fullName ?? "User"}."
                    : "You have blocked ${otherUser?.displayName ?? otherUser?.fullName ?? "User"}. Unblock them to interact.",
                style: AppFontStyle.greyRegular14pt,
                textAlign: TextAlign.center,
              ),
              vSpace(20),
              CustomPrimaryButton(
                textValue: "Close",
                height: 40,
                textSize: 14,
                callback: () {
                  Get.back();
                },
              ),
              SizedBox(height: 10),
            ]),
      ));
      return false;
    } else {
      return true;
    }
  }

  requestMedicalReport(
      {List<int>? medicalReportIds,
      bool isExistReport = false,
      bool loader = true}) async {
    var parameters = {
      "RoomId": roomData?.id,
      "DonorUserId": int.parse(otherUser?.userId.toString() ?? ""),
      "MedicalReportIds": medicalReportIds ?? [],
      "IsExistReport": isExistReport
    };

    try {
      await ChatApi().medicalReportRequest(parameters, loader: loader);
      await showAppToast("Submitted Successfully");
    } catch (e) {
      showDialog(
        context: Get.context!,
        builder: (context) => AlertMsgDialog(
          title: "Warning",
          msg: e.toString(),
          primaryText: CustomText.ok,
          primaryBtnTap: () {
            Get.back();
          },
        ),
      );
    }
  }

  Future<MedicalReportModel?> getRequestedReportList(Map parameter) async {
    try {
      var res = await ChatApi().getRequestedMedicalReport(parameter);
      return res;
    } catch (e) {
      showDialog(
        context: navigator!.context,
        builder: (context) => AlertMsgDialog(
          title: "Warning",
          msg: e.toString(),
          primaryText: CustomText.ok,
          primaryBtnTap: () {
            Get.back();
          },
        ),
      );
    }
    return null;
  }

  // void handleAudioSelection() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.audio,
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     setAttachmentUploading(true);
  //     final name = result.files.single.name;
  //     final filePath = result.files.single.path!;
  //     final file = File(filePath);
  //     final player = AudioPlayer();
  //     var duration = await player.setUrl(result.paths.first!);
  //     await isRoomExits();

  //     try {
  //       var res = await FileApi().uploadSingleFile(file.path, showLoader: true);
  //       var uri = res != null ? res.signedUrl! : "";

  //       final message =  PartialAudio(
  //         mimeType: lookupMimeType(filePath),
  //         name: name,
  //         size: result.files.single.size,
  //         uri: uri,
  //         duration: duration!,
  //       );
  //       FirebaseChatCore.instance
  //           .sendMessage(message, roomData!.id, otherUser!.id!);
  //       setAttachmentUploading(false);
  //       debugPrint("success ===============================");
  //     } catch (e) {
  //       debugPrint("$e ====================================================");
  //     } finally {
  //       setAttachmentUploading(false);
  //     }
  //   }
  // }

  flageUser() async {
    AllLookUpModel? list;
    flagOptionList.clear();
    var getApi = AppStorage.getLookupApi();

    if (getApi.isNotEmpty) {
      var data = await jsonDecode(getApi);
      list = AllLookUpModel.fromMap(data);
    } else {
      list = await LookUpApi().allLookupData();
    }

    for (var element in list!.conversationFlag!) {
      flagOptionList.add(element.modelPO!);
    }
    flagOptionList.add(LookupModelPO(id: null, name: "Other"));
    showLookupBottomSheet(
        child: FlagUserBottomSheet(
      list: flagOptionList,
      onTap: (
          {List<LookupModelPO>? mainList,
          otherFlagComment,
          List<LookupModelPO>? selectedList}) async {
        var selectedFlag = <int>[];
        var flagList = <FlagDetails>[];

        if (selectedList != null && selectedList.isNotEmpty) {
          for (var element in selectedList) {
            selectedFlag.add(element.id ?? -1);
            flagList.add(FlagDetails(
                flagDescription: element.subName,
                flagId: element.id,
                flagName: element.name));
          }
        }
        if (otherFlagComment != null && otherFlagComment.isNotEmpty) {
          selectedFlag.add(-1);
          flagList.add(
            FlagDetails(
                flagDescription: otherFlagComment,
                flagId: -1,
                flagName: otherFlagComment),
          );
        }
        var otherUserId =
            roomData!.users[0].id == FirebaseChatCore.instance.firebaseUser?.id
                ? roomData!.users[1].id
                : roomData!.users[0].id;
        var parameters = {
          "UserId": int.parse(otherUserId.toString()),
          "RoomId": roomData!.id,
          "ConversationFlagId": selectedFlag,
          "ProblemDescription":
              otherFlagComment != null && otherFlagComment.isNotEmpty
                  ? otherFlagComment
                  : null
        };
        // log(jsonEncode(parameters));
        try {
          await ChatApi().flagUser(parameters);

          Get.back();
          if (flagList.isNotEmpty) {
            var message = FlagInfo(flagDetails: flagList);

            await FirebaseChatCore.instance
                .sendMessage(message, roomData!.id, otherUser!.id!);
          }
          await showAppToast("Submitted Successfully");
        } catch (e) {
          showDialog(
            context: navigator!.context,
            builder: (context) => AlertMsgDialog(
              title: "Warning",
              msg: e.toString(),
              primaryText: CustomText.ok,
              primaryBtnTap: () {
                Get.back();
              },
            ),
          );
        }
      },
    ));
  }

  shareDonorReportsSelf(Map parameters) async {
    try {
      await ChatApi().shareReportSelf(parameters);
    } catch (e) {
      await showDialog(
        context: Get.context!,
        builder: (context) => AlertMsgDialog(
            title: "Error",
            msg: e.toString(),
            secondaryText: "Close",
            image: AppSvgIcons.report,
            secondaryBtnTap: () {
              Navigator.pop(context);
            }),
      );
    }
  }

  Future<bool> updateProfile(parameters) async {
    var data = jsonEncode(parameters);
    log("------parametrs---${data}");

    try {
      ProfilePercentageModel? res = await DonorApi().updateProfile(parameters);
      // await closeLoadingDialog();
      if (res != null) return true;
    } catch (e) {
      // await closeLoadingDialog();
      await showDialog(
        context: Get.context!,
        builder: (context) => AlertMsgDialog(
            title: "Error",
            msg: e.toString(),
            secondaryText: "Close",
            image: AppSvgIcons.report,
            secondaryBtnTap: () {
              Navigator.pop(context);
            }),
      );
      return false;
    }
    return false;
  }

  getRequestedReportsList(String id) async {
    try {
      var list = await ChatApi().getMedicalReportRequest(id);
      List<ReportModel> reports = list?.reports ?? [];
      donorReportList.addAll(reports);
      isAnonymous.value = list?.isAnonymous ?? false;
      return reports;
    } catch (e) {
      await showDialog(
        context: Get.context!,
        builder: (context) => AlertMsgDialog(
            title: "Error",
            msg: e.toString(),
            secondaryText: "Close",
            image: AppSvgIcons.report,
            secondaryBtnTap: () {
              Navigator.pop(context);
            }),
      );
    }
  }

  Future<DonorReportModel?>? getExistingReportsList({int? id}) async {
    donorReportList.value = [];
    try {
      var list = await ChatApi()
          .getExistingDonorMedicalReports({"RecipientUserId": id});
      List<ReportModel> reports = list?.reports ?? [];
      donorReportList.addAll(reports);
      isAnonymous.value = list?.isAnonymous ?? false;
      return list;
    } catch (e) {
      await showDialog(
        context: Get.context!,
        builder: (context) => AlertMsgDialog(
            title: "Error",
            msg: e.toString(),
            secondaryText: "Close",
            image: AppSvgIcons.report,
            secondaryBtnTap: () {
              Navigator.pop(context);
            }),
      );
    }
    return null;
  }

  showBankAccountAlert(VoidCallback onCallback) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.delayed(Duration.zero, () => false),
        child: AlertMsgDialog(
          title: 'Add Bank Account',
          msg:
              "To proceed, kindly link your bank account. This step is necessary before entering the price details.",
          secondaryText: "Cancel",
          secondaryBtnTap: () {
            Get.back();
            Get.back();
          },
          primaryText: "Add bank account",
          primaryBtnTap: () async {
            Get.back();
            Navigator.of(
              context,
            )
                .push(
                  MaterialPageRoute(
                    builder: (context) => AccountDetails(
                      isFromSetting: true,
                    ),
                  ),
                )
                .then((value) => onCallback());
            // Get.to(
            //   AccountDetails(
            //     isFromSetting: true,
            //   ),
            // )?.then((value) => onCallback());
          },
        ),
      ),
    );
  }*/
}
