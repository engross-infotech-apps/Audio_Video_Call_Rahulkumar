import 'package:demo_agora/helpers/callkit_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  // Private constructor
  NotificationService._privateConstructor();

  // The single instance of the class
  static final NotificationService _instance = NotificationService._privateConstructor();

  // Factory constructor to return the same instance
  factory NotificationService() {
    return _instance;
  }

  // Firebase Messaging instance
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  //Method to generate device token..
  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("TOKEN_FCM---->:- ${token} ");

    // Any time the token refreshes, store this too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  Future<void> saveTokenToDatabase(String token) async {
    debugPrint("TOKEN_FCM:- ${token} ");
  }


  // Method to set up notifications
  void setUpNotifications() {

    // Handle when the app is launched from a terminated state with a notification
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      debugPrint("Notification received: ${message.toString()}");
      //if (message!.data['type'] == 'call') {
        // CallkitHelper().showIncomingCall(message.data);
      //}
    });

    // Listen for messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Foreground notification received: ${message.toString()}");
      if (message.data['type'] == 'call') {
        CallkitHelper().showIncomingCall(message.data);
      }
    });

    // When the user taps on the notification and the app is brought to the foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Notification opened: ${message.toString()}");
      if (message.data['type'] == 'call') {
        debugPrint("onMessageOpenedApp--> ${message.data}");
        // Navigate to the calling page or handle the action
        // Navigator.pushNamed(context, '/callingPage');
      }
    });
  }


}
