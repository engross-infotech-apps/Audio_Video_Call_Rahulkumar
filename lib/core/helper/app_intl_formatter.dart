import 'dart:ui';

import 'package:gokidu_app_tour/core/theme/app_colors.dart';
import 'package:intl/intl.dart';

String rupee = "\u{20B9}";

var formatter = NumberFormat('#,##,###');
final timeForm = NumberFormat('00');
String numFormatter(text) => formatter.format(text);
String timeFormatter(text) => timeForm.format(text);

String meterToKilometer(int meter) {
  if (meter == 0) {
    return "0";
  }
  double distanceInKiloMeters = meter / 1000;
  double roundDistanceInKM =
      double.parse((distanceInKiloMeters).toStringAsFixed(2));
  return roundDistanceInKM.toString();
}

Color? ratingStarColor(x) {
  if (x > 0 && x <= 2.0) {
    return AppColors.redError;
  } else if (x > 2.0 && x < 3.5) {
    return AppColors.ratingYellow;
  } else {
    return null;
  }
}
