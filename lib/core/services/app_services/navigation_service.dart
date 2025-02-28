import 'package:flutter/material.dart';


class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> internetKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> loaderKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> snackBarKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> toastKey = GlobalKey<NavigatorState>();

  static RenderObject? dialog =
      NavigationService.internetKey.currentContext?.findRenderObject();
}
