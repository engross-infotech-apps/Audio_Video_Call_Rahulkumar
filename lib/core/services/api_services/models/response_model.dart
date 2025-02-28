import 'package:gokidu_app_tour/core/services/api_services/http_request/decodable.dart';

class SignInResModel implements Decodable<SignInResModel> {
  bool? isProfileCompleted;
  String? token;
  String? email;
  String? msg, title, subTitle;
  int? userType;
  int? userRole;

  @override
  SignInResModel decode(json) {
    isProfileCompleted = json['IsProfileCompleted'];
    token = json['access_token'];
    email = json['Email'];
    msg = json['msg'];
    title = json['Title'];
    subTitle = json['Subtitle'];
    userType = json['UserType'];
    userRole = json['UserRole'];
    return this;
  }
}
