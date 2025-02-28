// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:gokidu_app_tour/view/started_view/view/splash_screen.dart';

bool isBackGround = false; //
bool isNotifyTap = false; //
var unreadLikeCount = 0.obs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String? changes;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

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
