import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:demo_agora/app.dart';
import 'package:demo_agora/helpers/callkit_helper.dart';
import 'package:demo_agora/helpers/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:demo_agora/calling_page/calling_controller/calling_controller.dart';
import 'package:get/get.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // final SendPort? sendPort = IsolateNameServer.lookupPortByName('1234-rahul');

  // if (sendPort != null) {
  //   // Send a message to the main isolate
  //   print('Port already registered!!');
  // } else {
  //   registerPortForBgComm();
  //   print('Failed to find SendPort in main. Ensure it is registered in the main isolate.');
  // }

  Get.put(CallingController());
  CallkitHelper().initializeCallKit();
  // checkForOngoingCall();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Register the background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

// checkForOngoingCall()async{
//   var calls=await FlutterCallkitIncoming.activeCalls();
//   debugPrint("check active calls-> ${calls}");
//   if(calls!=null ){
//
//   }
// }


// registerPortForBgComm(){
//   // Create a ReceivePort for communication from the background isolate
//   final ReceivePort receivePort = ReceivePort();
//
//   // Register the ReceivePort with the IsolateNameServer
//   bool isRegistered = IsolateNameServer.registerPortWithName(
//     receivePort.sendPort,
//     '1234-rahul',
//   );
//
//   if (!isRegistered) {
//     // Handle the case where the port registration failed
//     print('Port registration failed. A port with the same name might already be registered.');
//   }else{
//     print('Port registration success.');
//   }
//
//   // Listen for messages from the background isolate
//   receivePort.listen((dynamic message) {
//     // Handle the message received from the background isolate
//     print('Message from background isolate: $message');
//     // Update UI or perform necessary actions based on the message
//   });
// }
