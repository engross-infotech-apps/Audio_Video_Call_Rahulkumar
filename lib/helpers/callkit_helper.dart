import 'package:demo_agora/calling_page/calling_controller/calling_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

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
      extra: {
        'deepLink': 'myapp://call/accept?id=${data['id']}&caller=${data['nameCaller']}',

        "channel": data['channel_id'], "call_type": data['call_type']},
      android: const AndroidParams(
        // Customize your Android full-screen notification here:
        isCustomNotification: true,
        ringtonePath: 'system_ringtone_default',
        // More customization options as needed
      ),
      ios: const IOSParams(
        iconName: 'CallKitLogo',
        supportsVideo: true,
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
          String channelId = event.body["extra"]["channel"];
          String callType = event.body["extra"]["call_type"];
          debugPrint("event--> ${callType}");
          if (callType == "1") {
            controller.joinVideoChannel(channelId: channelId);
          } else if (callType == "0") {
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
        default:
          break;
      }
    });
  }
}
