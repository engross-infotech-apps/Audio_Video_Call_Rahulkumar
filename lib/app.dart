import 'package:demo_agora/calling_page/calling_controller/calling_controller.dart';
import 'package:demo_agora/calling_page/calling_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: CallingPage(),
    );
  }



  @override
  void dispose() async {
    super.dispose();
  }
}
