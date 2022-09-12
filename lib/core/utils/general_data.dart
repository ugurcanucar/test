import 'package:hive/hive.dart';
import 'package:terapizone/core/utils/utilities.dart';

class GeneralData {
  static Box<dynamic>? hive;

  static const String spACCESSTOKEN = 'access_token';
  static const String spREFRESHTOKEN = 'refresh_token';
  static const String spEMAIL = 'email';
  static const String spUSERINFO = 'user_info';
  static const String spPASSWORD = 'password';
  static const String spFCMTOKEN = 'fcm_token';

  static String getAccessToken() {
    var result = Utilities.getUserSp(spACCESSTOKEN);
    if (result != null) {
      return result;
    } else {
      return '';
    }
  }

  static String getRefreshToken() {
    var result = Utilities.getUserSp(spREFRESHTOKEN);
    if (result != null) {
      return result;
    } else {
      return '';
    }
  }

  static void setAccessToken(String value) async {
    Utilities.setUserSp(spACCESSTOKEN, value);
  }

  static void setRefreshToken(String value) async {
    Utilities.setUserSp(spREFRESHTOKEN, value);
  }

  static String getEmail() {
    var result = Utilities.getUserSp(
      spEMAIL,
    );
    if (result != null) {
      return result;
    } else {
      return '';
    }
  }

  static String getUserInfo() {
    var result = Utilities.getUserSp(
      spUSERINFO,
    );
    if (result != null) {
      return result;
    } else {
      return '';
    }
  }

  static void setEmail(String value) async {
    Utilities.setUserSp(spEMAIL, value);
  }

  static void setUserInfo(String value) async {
    Utilities.setUserSp(spUSERINFO, value);
  }

  static String getPassword() {
    var result = Utilities.getUserSp(spPASSWORD);
    if (result != null) {
      return result;
    } else {
      return '';
    }
  }

  static void setPassword(String value) async {
    Utilities.setUserSp(spPASSWORD, value);
  }

  static String getFCMToken() {
    return Utilities.getUserSp(spFCMTOKEN, defaultValue: null);
  }

  static void setFCMToken(String? value) {
    Utilities.setUserSp(spFCMTOKEN, value);
  }
}
