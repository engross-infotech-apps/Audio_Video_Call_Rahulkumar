import 'package:demo_agora/calling_page/calling_page.dart';
import 'package:demo_agora/helpers/callkit_helper.dart';
import 'package:demo_agora/helpers/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    CallkitHelper().requestCallKitPermission();
    // CallkitHelper().initializeCallKit();
    NotificationService().setupToken();
    NotificationService().setUpNotifications();
    checkAndNavigationCallingPage();
    super.initState();
  }

  Future<void> checkAndNavigationCallingPage() async {
    var currentCall = await getCurrentCall();
    if (currentCall != null) {
      debugPrint("navigate to call screen");
    }
  }

  Future<dynamic> getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List) {
      if (calls.isNotEmpty) {
        print('DATA: $calls');
        // _currentUuid = calls[0]['id'];
        return calls[0];
      } else {
        // _currentUuid = "";
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: CallingPage(),
      getPages: [],
    );
  }

  @override
  void dispose() async {
    super.dispose();
  }
}
