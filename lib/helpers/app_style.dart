import 'package:demo_agora/helpers/app_colors.dart';
import 'package:flutter/material.dart';

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

LinearGradient callGradient = LinearGradient(
  begin: Alignment(0.93, -0.37), // Approximate for 342.44 degrees
  end: Alignment(-0.93, 0.37),
  colors: [
    AppColors.callG1,
    AppColors.callG2,
  ],
  stops: [0.0539, 0.6071], // Converted from 5.39% and 60.71%
);
