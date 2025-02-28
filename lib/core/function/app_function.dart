import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gokidu_app_tour/core/helper/enum_helper.dart';
import 'package:gokidu_app_tour/core/services/app_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

DateTime? currentBackPressTime;

Future<bool> appOnWillPop() async {
  DateTime now = DateTime.now();

  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    await Fluttertoast.showToast(
        msg: "Press the back button once more to exit the application.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 12);

    return Future.value(false);
  }
  return Future.value(true);
}

double cmToFeetConverter(double value) {
  UnitsOfMeasurement fromUnit = UnitsOfMeasurement.centimeters;
  UnitsOfMeasurement toUnit = UnitsOfMeasurement.feet;

  double convertedValue = fromUnit.convert(value, toUnit);
  /*debugPrint(
      '$value ${fromUnit.toString().split('.').last} is equal to $convertedValue ${toUnit.toString().split('.').last}');*/
  return convertedValue;
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

String countryCodeToEmoji(String countryCode) {
  if (countryCode.isEmpty) {
    return "";
  }
  final int firstLetter =
      countryCode.toUpperCase().codeUnitAt(0) - 0x41 + 0x1F1E6;
  final int secondLetter =
      countryCode.toUpperCase().codeUnitAt(1) - 0x41 + 0x1F1E6;
  return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
}

Future<void> appLaunchUrl(url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

Future<String?> getSavedDir() async {
  String? externalStorageDirPath;
  externalStorageDirPath = (await getApplicationDocumentsDirectory()).path;
  return externalStorageDirPath;
}

Future<bool> _checkPermission() async {
  if (Platform.isIOS) {
    return true;
  }

/*  if (Platform.isAndroid) {
    final status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      return true;
    }

    final result = await Permission.storage.request();
    return result == PermissionStatus.granted;
  }*/

  throw StateError('unknown platform');
}

// String getCurrentUserRole() {
//   // var user = AppStorage.getUserData();
//   // if (user!.roleId == 1) {
//   //   return 'donor';
//   // } else {
//   //   return 'recipient';
//   // }
// }

fileNameFromUrl(String url) {
  var fileName = url.split("/").last;

  return fileName.isNotEmpty ? fileName : url;
}

double feetToCmConverter(double value) {
  UnitsOfMeasurement fromUnit = UnitsOfMeasurement.feet;
  UnitsOfMeasurement toUnit = UnitsOfMeasurement.centimeters;

  double convertedValue = fromUnit.convert(value, toUnit);
  /*debugPrint(
      '$value ${fromUnit.toString().split('.').last} is equal to $convertedValue ${toUnit.toString().split('.').last}');*/
  return convertedValue;
}

double inchToCmConverter(double value) {
  UnitsOfMeasurement fromUnit = UnitsOfMeasurement.inches;
  UnitsOfMeasurement toUnit = UnitsOfMeasurement.centimeters;

  double convertedValue = fromUnit.convert(value, toUnit);
  /*debugPrint(
      '$value ${fromUnit.toString().split('.').last} is equal to $convertedValue ${toUnit.toString().split('.').last}');*/
  return convertedValue;
}

double mileToKM(double value) {
  var kiloMeter = (value * 1.609344).roundToDouble();
  return kiloMeter;
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

String getCurrentUserRole() {
  var user = AppStorage.getUserData();
  if (user?.roleId == 1) {
    return 'donor';
  } else {
    return 'recipient';
  }
}
