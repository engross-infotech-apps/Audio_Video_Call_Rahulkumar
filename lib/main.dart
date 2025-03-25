// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/view/calling_page/calling_controller/calling_controller.dart';
import 'package:gokidu_app_tour/view/started_view/view/splash_screen.dart';

import 'core/callkit_helper.dart';
import 'core/firebase_options.dart';
import 'core/notification_service.dart';

bool isBackGround = false; //
bool isNotifyTap = false; //
var unreadLikeCount = 0.obs;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure Firebase is initialized
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("Background message received: ${message.data}");

  // Check if this message is for an incoming call
  // final SendPort? sendPort = IsolateNameServer.lookupPortByName('1234-rahul');
  //
  // if (sendPort != null) {
  //   // Send a message to the main isolate
  //   sendPort.send('New background message received: ${message.data}');
  //   // IsolateNameServer.removePortNameMapping("1234-rahul");
  // } else {
  //   print('Failed to find SendPort. Ensure it is registered in the main isolate.');
  // }
  if (message.data['type'] == 'call') {

    CallkitHelper().showIncomingCall(message.data);
  }

  // final ReceivePort backgroundReceivePort = ReceivePort();
// Retrieve the SendPort to communicate with the main isolate

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(CallingController());
  CallkitHelper().initializeCallKit();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Register the background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String? changes;

  @override
  void initState() {
    CallkitHelper().requestCallKitPermission();
    // CallkitHelper().initializeCallKit();
    NotificationService().setupToken();
    NotificationService().setUpNotifications();
    checkAndNavigationCallingPage();
  } // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

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
      home: SplashScreen(page: "main"),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.primaryRed,
            selectionColor: AppColors.lightPink.withOpacity(0.5),
            selectionHandleColor: AppColors.primaryRed),
        scaffoldBackgroundColor: Colors.white,
      ),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: 1.0, boldText: false),
            child: child!);
      },
      navigatorKey: NavigationService.navigatorKey,
      themeMode: ThemeMode.system,
    );
  }
}
