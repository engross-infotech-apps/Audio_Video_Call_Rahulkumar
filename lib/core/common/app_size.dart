import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/services/app_services/navigation_service.dart';

class AppScreenSize {
  // static Size screenSize = WidgetsBinding.instance.window.physicalSize;
  static Size screenSize =
      MediaQuery.of(NavigationService.navigatorKey.currentContext!).size;
  static double width = screenSize.width;
  static double height = screenSize.height;

  static heightInPercentage(double percentage) {
    return (height * percentage) / 100;
  }

  static widthInPercentage(double percentage) {
    return (width * percentage) / 100;
  }
}
