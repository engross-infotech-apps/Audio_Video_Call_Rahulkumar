import 'package:flutter/cupertino.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/view/calling_page/calling_page.dart';
import 'package:gokidu_app_tour/view/chat/model/user.dart';
import 'package:uuid/uuid.dart';

import '../view/calling_page/calling_controller/calling_controller.dart';

class CallkitHelper {
  // Private constructor
  CallkitHelper._privateConstructor();

  // The single instance of the class
  static final CallkitHelper _instance = CallkitHelper._privateConstructor();

  // Factory constructor to return the same instance
  factory CallkitHelper() {
    return _instance;
  }

  //Request permissions
  Future<void> requestCallKitPermission() async {
    await FlutterCallkitIncoming.requestNotificationPermission({
      "rationaleMessagePermission":
          "Notification permission is required, to show notification.",
      "postNotificationMessageRequired":
          "Notification permission is required, Please allow notification permission from setting."
    });
    await FlutterCallkitIncoming.requestFullIntentPermission();
  }

  // Method to show incoming call
  Future<void> showIncomingCall(Map<String, dynamic> data) async {
    // {type: call, channel_id: , call_type: 0,call_from:}

    final callKitParams = CallKitParams(
      id: data['callId'] ?? Uuid().v4(),
      nameCaller: data['call_from'] ?? "Unknown Caller",
      handle: data['callerId'] ?? "N/A",
      type: data['call_type'] == '1' ? 1 : 0,
      // 0 for audio, 1 for video
      extra: {"channel": data['channel_id'], "call_type": data['call_type']},
      avatar: data["avatar"],
      // Incoming call/Outgoing call display time (second). If the time is over, the call will be missed.
      duration: 30000,
      android: const AndroidParams(
          // Customize your Android full-screen notification here:
          isCustomNotification: true,
          ringtonePath: 'system_ringtone_default',
          // backgroundColor: "#ffffff",
          backgroundUrl: "assets/img/back_call.png",
          isShowFullLockedScreen: true,

          // More customization options as needed
          ),
      ios: const IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );

    // Show the native incoming call UI
    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);

    // await FlutterCallkitIncoming.startCall(callKitParams);
    // await FlutterCallkitIncoming.activeCalls().then((onValue){
    //   debugPrint("activeCalls--> ${onValue}");
    // });
  }

  void initializeCallKit() {
    //1=video 0=audio
    final CallingController controller = Get.find<CallingController>();

    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) {
      debugPrint("event--> ${event!.event}");
      switch (event!.event) {
        case Event.actionCallAccept:
          // Handle call acceptance
          debugPrint("event--> ${event.body}");
          String channelId =
              event.body["extra"]["channel"] ?? event.body["handle"];
          String callType =
              event.body["extra"]["call_type"] ?? event.body["type"].toString();
          String userId = event.body["extra"]["userId"] ?? "";
          debugPrint("event--> ${callType}");
          if (callType == "1") {
            Get.to(
                CallingPage(isVideoCall: true, callToUser: User(id: userId)));
            controller.joinVideoChannel(channelId: channelId);
          } else if (callType == "0") {
            Get.to(
                CallingPage(isVideoCall: false, callToUser: User(id: userId)));
            controller.joinAudioChannel(channelId: channelId);
          }

          //   _handleCallAccept(event);
          break;
        case Event.actionCallDecline:
          // Handle call decline
          //   showToast("On Decline call");
          debugPrint("event--> ${event.body}");

          //   _handleCallDecline(event);
          break;

        case Event.actionCallEnded:
          Get.back();
          controller.timer!.cancel();
          break;

        default:
          break;
      }
    });
  }
}

//full screen - call - locked device
//android 14