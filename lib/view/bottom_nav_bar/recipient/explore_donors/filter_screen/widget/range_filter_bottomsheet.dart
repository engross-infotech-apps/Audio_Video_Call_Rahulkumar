// // ignore_for_file: prefer_const_constructors

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';
// import 'package:get/get.dart';
// import 'package:gokidu_app_tour/core/common/alert_dialog.dart';
// import 'package:gokidu_app_tour/core/common/app_buttons.dart';
// import 'package:gokidu_app_tour/core/common/app_svg_images.dart';
// import 'package:gokidu_app_tour/core/common/custom_widgets.dart';
// import 'package:gokidu_app_tour/core/function/app_function.dart';
// import 'package:gokidu_app_tour/core/services/app_storage.dart';
// import 'package:gokidu_app_tour/core/theme/app_colors.dart';
// import 'package:gokidu_app_tour/core/theme/app_font_style.dart';
// import 'package:gokidu_app_tour/core/theme/app_style.dart';
// import 'package:map_location_picker/map_location_picker.dart';

// // ignore: must_be_immutable
// class RangeFilterBottomSheet extends StatefulWidget {
//   RangeFilterBottomSheet(
//       {super.key,
//       this.headingFont,
//       this.latitudeDefault,
//       this.initialCameraPosition,
//       this.longitudeDefault,
//       this.radius,
//       required this.onTap});
//   TextStyle? headingFont;
//   double? latitudeDefault;
//   double? radius;
//   CameraPosition? initialCameraPosition;
//   double? longitudeDefault;
//   final Function(dynamic, dynamic) onTap;
//   @override
//   State<RangeFilterBottomSheet> createState() => RangeFilter();
// }

// class RangeFilter extends State<RangeFilterBottomSheet> {
//   // final = Get.put(DonorsListController());

//   var latitude;
//   var longitude;
//   var radius = 25.00.obs;
//   var currentPosition = Rxn<LatLng>();
//   var country = AppStorage.getUserData()?.countryId;
//   final markers = <Marker>{}.obs;
//   var circle = <Circle>{}.obs;
//   GoogleMapController? mController;
//   var markerIcon;

//   @override
//   void initState() {
//     init();
//     super.initState();
//     // createMap();
//   }

// //======================Donor finding range ======================

//   init() async {
//     await Future.delayed(
//       Duration.zero,
//       () async {
//         markerIcon = await getBytesFromAsset(AppImage.simpleMarkerPng, 100);
//       },
//     );
//     // await createMap();
//   }

//   createMap(VoidCallback callback) async {
//     radius.value = widget.radius ?? 25.00;
//     if (widget.latitudeDefault == null || widget.longitudeDefault == null) {
//       getUserCurrentLocation().then((value) {
//         currentPosition.value = LatLng(value.latitude, value.longitude);
//       }).then((value) => getLocation());
//     } else {
//       latitude = widget.latitudeDefault;
//       longitude = widget.longitudeDefault;
//       currentPosition.value =
//           LatLng(widget.latitudeDefault!, widget.longitudeDefault!);
//       getLocation();
//     }
//     callback();
//   }

//   double reciprocal(double d) =>
//       country != null && country == 2 ? 1000 * d : 1609.34 * d;

//   void addRadiusToMap() {
//     circle.add(Circle(
//       circleId: CircleId("01"),
//       fillColor: Colors.white.withOpacity(0.5),
//       strokeWidth: 1,
//       strokeColor: AppColors.primaryRed,
//       center: currentPosition.value ?? LatLng(0.0, 0.0),
//       radius: reciprocal(radius.value.toDouble()),
//     ));
//   }

//   getLocation() async {
//     if (currentPosition.value != null) {
//       markers.add(
//         Marker(
//           markerId: MarkerId("0"),
//           icon: BitmapDescriptor.fromBytes(markerIcon),
//           position: LatLng(currentPosition.value!.latitude,
//               currentPosition.value!.longitude),
//           infoWindow: const InfoWindow(
//             title: 'My Current Location',
//           ),
//         ),
//       );
//     }

//     addRadiusToMap();

//     CameraPosition cameraPosition = CameraPosition(
//       target: LatLng(
//           currentPosition.value!.latitude, currentPosition.value!.longitude),
//       zoom: getZoomLevel(),
//     );

//     final GoogleMapController controller = mController!;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//     // });
//     setState(() {});
//   }

//   double getZoomLevel() {
//     double zoomLevel = 11;
//     var r = reciprocal(radius.value.toDouble());
//     if (r > 0) {
//       double radiusElevated = r - r / 2;
//       double scale = radiusElevated / 500;
//       zoomLevel = 14 - log(scale) / log(2);
//     }
//     zoomLevel = num.parse(zoomLevel.toStringAsFixed(2)).toDouble();
//     return zoomLevel;
//   }

//   var isSettingOpen = false.obs;

//   openAppDialog(text) {
//     showDialog(
//       context: Get.context!,
//       builder: (context) => AlertMsgDialog(
//         title: "Permission",
//         msg: "Please enable $text permission from app setting.",
//         primaryText: "Open Settings",
//         secondaryText: "Cancel",
//         image: AppSvgIcons.myLocation,
//         primaryBtnTap: () async {
//           await Geolocator.openAppSettings();
//           isSettingOpen.value = true;
//           Navigator.pop(context);
//         },
//         secondaryBtnTap: () {
//           isSettingOpen.value = true;

//           Navigator.pop(context);
//         },
//       ),
//     );
//   }

//   Future<Position> getUserCurrentLocation() async {
//     if (await Geolocator.checkPermission() != LocationPermission.whileInUse) {
//       await Geolocator.requestPermission().then((value) async {
//         if (value == LocationPermission.deniedForever ||
//             value == LocationPermission.denied) {
//           openAppDialog("Location");
//         }
//       }).onError((error, stackTrace) async {
//         await Geolocator.requestPermission();
//         debugPrint("ERROR" + error.toString());
//       });
//     }
//     return await Geolocator.getCurrentPosition();
//   }
// //================================================================

//   onChangeRedius(bool isPlus) async {
//     if (isPlus) {
//       radius.value < 10000.0 ? radius.value += 5.0 : null;
//       await getLocation();
//     } else {
//       radius.value > 1.0 ? radius.value -= 5.0 : null;
//       await getLocation();
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(maxHeight: double.maxFinite),
//       padding: EdgeInsets.only(bottom: 20),
//       width: double.maxFinite,
//       child: SingleChildScrollView(
//         child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               vSpace(10),
//               Align(
//                 alignment: Alignment.center,
//                 child: Custom.svgIconData(AppSvgIcons.bottomSheetIcon),
//               ),
//               vSpace(20),
//               Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text("Filter donor finding range",
//                       style: widget.headingFont ??
//                           AppFontStyle.blackRegular16pt
//                               .copyWith(fontWeight: FontWeight.w600))),
//               vSpace(20),
//               Container(
//                   height: MediaQuery.of(context).size.height * 0.40,
//                   child: GoogleMap(
//                     mapType: MapType.normal,
//                     scrollGesturesEnabled: true,
//                     zoomGesturesEnabled: true,
//                     myLocationEnabled: false,
//                     zoomControlsEnabled: false,
//                     markers: markers,
//                     circles: circle,
//                     initialCameraPosition: widget.initialCameraPosition ??
//                         const CameraPosition(
//                           target: LatLng(43.651070, -79.347015),
//                         ),
//                     onTap: (value) async {
//                       setState(() {
//                         currentPosition.value =
//                             LatLng(value.latitude, value.longitude);
//                       });
//                       await getLocation();
//                       setState(() {});
//                     },
//                     onMapCreated: (GoogleMapController controller) {
//                       mController = controller;
//                       createMap(() {
//                         setState(() {});
//                       });

//                       setState(() {});
//                     },
//                   )),
//               vSpace(30),
//               Align(
//                   child: Text(
//                 "We'll find donors within the radius of",
//                 style:
//                     AppFontStyle.greyBlueRegular16pt.copyWith(fontSize: 1 + 18),
//               )),
//               vSpace(10),
//               Obx(
//                 () => Align(
//                     child: Text(
//                   "${radius.value != 0 ? radius.value.toStringAsFixed(2) : "1.0"}0 ${country != null && country == 2 ? "km" : "miles"}",
//                   style: AppFontStyle.greyBlueRegular16pt.copyWith(
//                       fontSize: 1 + 20,
//                       color: AppColors.black,
//                       fontWeight: FontWeight.bold),
//                 )),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                           onTap: () {
//                             onChangeRedius(false);
//                           },
//                           child: Container(
//                               height: 30,
//                               width: 30,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: Colors.transparent,
//                                   border:
//                                       Border.all(color: AppColors.greyBorder)),
//                               child: Icon(Icons.remove))),
//                       InkWell(
//                           onTap: () {
//                             onChangeRedius(true);
//                           },
//                           child: Container(
//                               height: 30,
//                               width: 30,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: Colors.transparent,
//                                   border:
//                                       Border.all(color: AppColors.greyBorder)),
//                               child: Icon(Icons.add))),
//                     ]),
//               ),
//               Obx(
//                 () => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: FlutterSlider(
//                     handlerHeight: 30,
//                     min: 1,
//                     max: 10000,
//                     onDragging: (handlerIndex, lowerValue, upperValue) async {
//                       radius.value = lowerValue;
//                       await getLocation();
//                       setState(() {});
//                     },
//                     jump: true,
//                     handler: FlutterSliderHandler(
//                       decoration: BoxDecoration(color: Colors.transparent),
//                       child: Container(
//                         height: 35,
//                         width: 35,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors.primaryRed),
//                       ),
//                     ),
//                     trackBar: FlutterSliderTrackBar(
//                       inactiveTrackBar: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: AppColors.lightPink1,
//                       ),
//                       activeTrackBar: BoxDecoration(
//                         borderRadius: BorderRadius.circular(4),
//                         gradient: LinearGradient(
//                             begin: Alignment(-1.00, 0.00),
//                             end: Alignment(1, 0),
//                             colors: [
//                               AppColors.primaryRed,
//                               AppColors.primaryRed,
//                               AppColors.primaryYellow,
//                               AppColors.primaryYellow,
//                             ]),
//                       ),
//                     ),
//                     values: [radius.value == 0 ? 1 : radius.value],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('1 ${country != null && country == 2 ? "km" : "mile"}',
//                         style: AppFontStyle.greyRegular16pt),
//                     Text(
//                         '10000 ${country != null && country == 2 ? "km" : "miles"}',
//                         style: AppFontStyle.greyRegular16pt),
//                   ],
//                 ),
//               ),
//               vSpace(10),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: CustomPrimaryButton(
//                   textValue: "Done",
//                   callback: () {
//                     Get.back();
//                     widget.onTap(currentPosition.value, radius.value);
//                     // latitude = currentPosition.value!.latitude;
//                     // longitude = currentPosition.value!.longitude;
//                   },
//                 ),
//               )
//             ]),
//       ),
//     );
//   }
// }
