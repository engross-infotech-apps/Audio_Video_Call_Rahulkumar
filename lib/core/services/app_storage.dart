import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:gokidu_app_tour/core/services/api_services/models/user_model.dart';

class AppStorage {
  static final appStorage = GetStorage();

  static String userData = 'userdata';
  static String token = 'token';
  static String email = 'email';
  static String started = 'startedScreen';
  static String lookupApi = 'lookupApi';
  static String currentRoomId = 'roomId';
  static String addBankAccountTimeDate = 'addBankAccountTimeDate';
  static String addBankAccountPopCount = 'addBankAccountPopCount';
  static String layoutStyle = 'layoutStyle';
  static String legalTemplate = 'legalTemplate';
  static String performingAction = 'performingAction';

  static String getToken() => appStorage.read(token) ?? "";
  static String getUserEmail() => appStorage.read(email) ?? "";
  static bool startedPage() => appStorage.read(started) ?? false;
  static String getLookupApi() => appStorage.read(lookupApi) ?? "";
  static String? getRoomId() => appStorage.read(currentRoomId);
  static String? getBankAccountTimeDate() =>
      appStorage.read(addBankAccountTimeDate);
  static int? getBankAccountPopCount() =>
      appStorage.read(addBankAccountPopCount);
  static int? getLayoutStyle() => appStorage.read(layoutStyle);
  static bool? getPerformingAction() => appStorage.read(performingAction);

  static UserBasicDetailsModel? getUserData() {
    if (appStorage.read(userData) != null) {
      var data = jsonDecode(appStorage.read(userData));
      return UserBasicDetailsModel.fromMap(data);
    } else {
      return null;
    }
  }
}
