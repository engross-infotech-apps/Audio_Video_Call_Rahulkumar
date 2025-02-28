import 'package:get/get.dart';

class ValidationHelper {
  static RegExp alphabetsOnly = RegExp('[a-zA-Z]');

  static bool isFieldEmpty(String value) => value.isEmpty;

  static bool preferencesSet = false;

  static isChatValidate(v) {
    final regex1 = RegExp(
        r'\d|zero|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|seventy|ninety|hundred|thousand',
        caseSensitive: false);

    final regex2 = RegExp(
        r'\b(?!(?:zero|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|seventy|ninety|hundred|thousand)\b)\w*(?:zero|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|seventy|ninety|hundred|thousand)\w*\b',
        caseSensitive: false);

    var firstMatches = regex1.allMatches(v).toList();
    var secondMatches = regex2.allMatches(v).toList();

    if (v.contains(RegExp(r"[@]+\s*[a-zA-Z0-9.!#$%'*+\-=?^_`{|}~]+"))) {
      return "Personal id is not permitted.";
    }
    if (v.contains(RegExp(r"[a-zA-Z0-9.!#$%&'*+\-=?^`{|}~]+\s*[@]+"))) {
      return "Personal id is not permitted.";
    }
    if ((firstMatches.length - secondMatches.length) > 7) {
      return "Too many numbers. Remove it.";
      // "Personal contact details like email or social media handle and links aren't supported";
    }
  }

  static isUsCadPhoneNum(phoneNumber) {
    // RegExp regex = RegExp(r'^(\(?\d{3}\)?[-.\s]?)?\d{3}[-.\s]?\d{4}$');
    RegExp regex = RegExp(r'^(\(?\d{3}\)?[-.\s]?)\d{3}[-.\s]?\d{4}$');

    return !regex.hasMatch(phoneNumber);
  }

  static pwdPattern(password) {
    String pattern =
        r'''^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_\[\]{}()<>^"\'\\+\-\/\=\?\.\,\:\;|`])''';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(password);
  }

  static pwdHasLowercase(password) {
    String pattern = r'''^(?=.*?[a-z])''';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(password);
  }

  static pwdHasUpperCase(password) {
    String pattern = r'''^(?=.*?[A-Z])''';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(password);
  }

  static pwdHasNumber(password) {
    String pattern = r'''^(?=.*?[0-9])''';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(password);
  }

  static pwdHasSymbol(password) {
    String pattern =
        r'''^(?=.*?[!@#\$&*~_\[\]{}()<>^"\'\\+\-\/\=\?\.\,\:\;|`])''';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(password);
  }

  static bool isPasswordValid(String password) {
    String pattern =
        // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        r'''^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_\[\]{}()<>^"\'\\+\-\/\=\?\.\,\:\;|`])(?!.*\s).{8,}$''';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(password);
  }

  static bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+[a-zA-Z]+");
    return !regex.hasMatch(email);
  }

  static bool isPhoneNumber(String phone) {
    String pattern = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(phone);
  }

  static bool isZipCode(String zip) {
    String pattern = r'([0-9]{6}$)';
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(zip);
  }

  static emailValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter email address!';
    } else if (isEmailValid(value)) {
      return 'Please enter a valid email address!';
    }
    return null;
  }

  static passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter password!';
    } else if (isPasswordValid(value)) {
      return 'Please enter a valid password!';
    }
    return null;
  }

  static otpValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter received OTP!';
    } else if (value.length < 4) {
      return 'Please enter a valid OTP!';
    }
    return null;
  }

  static List<String> prohibitedWord = [
    /* "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight", 
    "nine",
    "ten",
    "hundred",
    "thousand",*/
    "yahoo",
    "gmail",
    "instagram",
    "insta",
    "fb",
    "facebook",
    "fbook",
    "faceb",
    "whatsapp",
    "linkedin",
  ];

  static String? bioValidation(String? v) {
    final regex1 = RegExp(
        r'\d|zero|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|seventy|ninety|hundred|thousand',
        caseSensitive: false);

    final regex2 = RegExp(
        r'\b(?!(?:zero|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|seventy|ninety|hundred|thousand)\b)\w*(?:zero|one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|seventy|ninety|hundred|thousand)\w*\b',
        caseSensitive: false);

    if (v != null) {
      var firstMatches = regex1.allMatches(v).toList();
      var secondMatches = regex2.allMatches(v).toList();
      if (v.trim().isEmpty) {
        return 'Please enter bio!';
      }
      if (v.contains(RegExp(r"[@]+\s*[a-zA-Z0-9.!#$%'*+\-=?^_`{|}~]+"))) {
        return "Personal id is not permitted.";
      }
      if (v.contains(RegExp(r"[a-zA-Z0-9.!#$%&'*+\-=?^`{|}~]+\s*[@]+"))) {
        return "Personal id is not permitted.";
      }
      // if (v.contains(RegExp(r"(?:\D*\d){9,}"))) {
      if ((firstMatches.length - secondMatches.length) > 7) {
        return "Too many numbers. Remove it.";
      }
      for (var element in prohibitedWord) {
        if (v.isCaseInsensitiveContains(element)) {
          return "Personal contact details like email or social media handle and links aren't supported";
        }
      }
    }
    return null;
  }

  static checkRegExp(String mess) {
    final regex = RegExp(
      r'\(?\d{3}\)?[\S,\s]\d{0,4}[\S,\s]\d{0,4}[\S,\s]\d{0,4}\d',
    );
    final matches = regex.allMatches(mess);

    // final numberRegExp = RegExp(r'\d{7,10}');
    // if (null) {
    //   return mess;
    // } else {
    //   setState(() {
    //     mess = "Personal details are not allow";
    //   });
    //   return mess;
    // }
    for (var match in matches) {
      final sub = mess.substring(match.start, match.end).trim();
      var messList = mess.split(sub);

      mess = '${messList[0]}****${messList[1]}';
      // mess.replaceFirst(sub, '****');

      // debugPrint(result);
    }

    final regexEmail = RegExp(
      r"[a-zA-Z0-9.!#$%&'*+-=?^_`{|}~]+[!@#$%^&*(){}\[\]]*[a-zA-Z]+[!@#$%^&*(){}\[\]]+[a-zA-Z0-9]*[!@#$%^&*().{}\[\]]*[a-zA-Z]*[!@#$%^&*().{}\[\]]+[a-zA-Z]+",
    );

    final matchesEmail = regexEmail.allMatches(mess);

    for (var match in matchesEmail) {
      final sub = mess.substring(match.start, match.end).trim();
      var messList = mess.split(sub);

      mess = '${messList[0]}****${messList[1]}';
    }

    return mess;
  }
}
