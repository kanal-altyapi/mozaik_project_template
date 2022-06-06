import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class LoginWidgetUtil {
  LoginWidgetUtil(this.applicationNamePrefix);
  final String applicationNamePrefix;
  String _getUniqueName(String constValue) {
    return constValue;
  }

  Future<void> setLoginUser(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_getUniqueName(MOZ_LOGIN_KEY), userName);
  }

  Future<String> getLoginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_getUniqueName(MOZ_LOGIN_KEY)) ?? '';
  }

  Future<void> setRememberMe(bool rememberMe) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_getUniqueName(MOZ_REMEMBER_ME_KEY), rememberMe);
  }

  Future<bool> getRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_getUniqueName(MOZ_REMEMBER_ME_KEY)) ?? false;
  }
}
