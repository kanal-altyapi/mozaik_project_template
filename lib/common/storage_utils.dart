import 'package:intl/intl.dart';
import 'package:mozaik_local_storage/mozaik_shared_preferences.dart' as shared_preferences;
import 'package:mozaik_local_storage/mozaik_secure_storage.dart' as secure_storage;
import '../common/extensions/string_extension.dart';

const String MOZ_LOGIN = 'moz_login';
const String MOZ_REMEMBER_ME = 'moz_remember_me';
const String MOZ_TOKEN = 'moz_token';
const String MOZ_LOGIN_DATE = 'login_date';
const String MOZ_USER_FULL_NAME = 'moz_user_full_name';
const String MOZ_USER_MOBILE_NUMBER = 'moz_user_mobile_number';
const String MOZ_SMS_APPROVE = 'moz_sms_approve';
const String MOZ_USER_IMAGE = 'moz_user_image';
const String MOZ_CALLERINFO_USER_NAME = 'moz_callerinfo_user_name';
const String MOZ_CALLERINFO_BRANCH_ID = 'moz_callerinfo_branch_id';
const String MOZ_USER_EMAIL = 'moz_user_email';
const String MOZ_FORCE_UPDATE_USER_EMAIL = 'moz_force_update_user_email';
const String MOZ_APPLICATION_SETTINGS = 'moz_application_settings';

class StorageUtilities {
  static Future<void> setForceUpdateUserEmail(String data) async {
    await shared_preferences.setString(MOZ_FORCE_UPDATE_USER_EMAIL, data);
  }

  static Future<String> getForceUpdateUserEmail() async {
    return await shared_preferences.getString(MOZ_FORCE_UPDATE_USER_EMAIL) ?? 'none';
  }

  static Future<List<String>> getSearchHistory() async {
    return await shared_preferences.getStringList(MOZ_LOGIN) ?? <String>[];
  }

  static Future<void> setSearchHistory(List<String> data) async {
    await shared_preferences.setStringList(MOZ_LOGIN, data);
  }

  static Future<String> getLoginUser() async {
    return await shared_preferences.getString(MOZ_LOGIN) ?? '';
  }

  static Future<void> setLoginUser(String userName) async {
    await shared_preferences.setString(MOZ_LOGIN, userName);
  }

  static Future<bool> getRememberMe() async {
    return await shared_preferences.getBool(MOZ_REMEMBER_ME) ?? false;
  }

  static Future<void> setRememberMe(bool rememberMe) async {
    await shared_preferences.setBool(MOZ_REMEMBER_ME, rememberMe);
  }

  static Future<void> deleteAllSecureStorage() async {
    await secure_storage.deleteAll();
  }

  static Future<void> setToken(String token) async {
    await secure_storage.setString(MOZ_TOKEN, token);
    setLastValidLoginDate();
  }

  static Future<String> getToken() async {
    return await secure_storage.getString(MOZ_TOKEN) ?? '';
  }

  static Future<void> setLastValidLoginDate() async {
    await shared_preferences.setString(MOZ_LOGIN_DATE, DateFormat('MM.dd.yyyy').format(DateTime.now()));
  }

  static Future<String> getLastValidLoginDate() async {
    return await shared_preferences.getString(MOZ_LOGIN_DATE) ?? '';
  }

  static Future<String> getUserFullName() async {
    return await shared_preferences.getString(MOZ_USER_FULL_NAME) ?? '';
  }

  static Future<void> setUserFullName(String userFullName) async {
    await shared_preferences.setString(MOZ_USER_FULL_NAME, userFullName);
  }

  static Future<String> getUserMobileNumber() async {
    return await shared_preferences.getString(MOZ_USER_MOBILE_NUMBER) ?? '';
  }

  static Future<void> setUserMobileNumber(String userMobileNumber) async {
    await shared_preferences.setString(MOZ_USER_MOBILE_NUMBER, userMobileNumber);
  }

  static Future<String> getUserImage() async {
    return await shared_preferences.getString(MOZ_USER_IMAGE) ?? '';
  }

  static Future<void> setUserImage(String? userImage) async {
    await shared_preferences.setString(MOZ_USER_IMAGE, userImage.toNullString());
  }

  static Future<String> getCallerInfoUserName() async {
    return await shared_preferences.getString(MOZ_CALLERINFO_USER_NAME) ?? '';
  }

  static Future<void> setCallerInfoUserName(String userName) async {
    await shared_preferences.setString(MOZ_CALLERINFO_USER_NAME, userName);
  }

  static Future<String> getCallerInfoBranchId() async {
    return await shared_preferences.getString(MOZ_CALLERINFO_BRANCH_ID) ?? '';
  }

  static Future<void> setCallerInfoBranchId(String branchId) async {
    await shared_preferences.setString(MOZ_CALLERINFO_BRANCH_ID, branchId);
  }

  static Future<void> setUserFailedLoginCount(String userEmail, String bruteForceInfo) async {
    await shared_preferences.setString('UserFailedLoginCount_$userEmail', bruteForceInfo);
  }

  static Future<String> getUserFailedLoginCount(String userEmail) async {
    return await shared_preferences.getString('UserFailedLoginCount_$userEmail') ?? '';
  }

  static Future<String> getUserEmail() async {
    return await shared_preferences.getString(MOZ_USER_EMAIL) ?? '';
  }

  static Future<void> setUserEmail(String email) async {
    await shared_preferences.setString(MOZ_USER_EMAIL, email);
  }

  static Future<void> setApplicaitonSetting(String settings) async {
    await shared_preferences.setString(MOZ_APPLICATION_SETTINGS, settings);
  }

  static Future<String?> getApplicaitonSetting() async {
    return await shared_preferences.getString(MOZ_APPLICATION_SETTINGS);
  }
}
