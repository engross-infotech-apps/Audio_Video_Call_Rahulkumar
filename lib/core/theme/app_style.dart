import 'package:flutter/material.dart';
import 'package:gokidu_app_tour/core/theme/app_colors.dart';
// import 'package:pinput/pinput.dart';

LinearGradient gradient = LinearGradient(
  begin: const Alignment(-0.00, 1.00),
  end: const Alignment(0, -1),
  colors: [
    AppColors.primaryRed,
    AppColors.primaryRed,
    AppColors.primaryDarkYellow
  ],
);

LinearGradient buttonGradient = LinearGradient(
  begin: Alignment(-1.00, 0.00),
  end: Alignment(1, 0),
  colors: [
    AppColors.primaryYellow,
    AppColors.primaryRed,
    AppColors.primaryRed,
  ],
);

LinearGradient boxGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    AppColors.primaryRed,
    AppColors.primaryRed,
    AppColors.gradientYellow,
  ],
);

// final defaultPinTheme = PinTheme(
//   width: 50,
//   height: 56,
//   textStyle: const TextStyle(
//     fontSize: 22,
//     color: Color.fromRGBO(30, 60, 87, 1),
//   ),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(10),
//     border: Border.all(color: AppColors.greyBorder),
//   ),
// );

// final focusPinTheme = PinTheme(
//   width: 54,
//   height: 60,
//   textStyle: const TextStyle(
//     fontSize: 22,
//     color: Color.fromRGBO(30, 60, 87, 1),
//   ),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(10),
//     border: Border.all(color: AppColors.greyText),
//   ),
// );

Widget vSpace(double size) => SizedBox(height: size);
Widget hSpace(double size) => SizedBox(width: size);
