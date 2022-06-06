import 'package:mozaik_common/utilities/application_utilities.dart';
 

import '../common/logger_util.dart';
import '../models/login/authentication.dart';
import '../models/login/user.dart';

mixin UserSession {
  static bool isRememberMe = false;
  static bool didShowWelcomeMessage = false;
  static late String sessionId;
  static bool didCreateSession = false;
  static String deviceId='';
  static late DateTime sessionStartTime;
  static bool _isLogin = false;
  static bool isAdminModeOn = false;

  static Authentication? offlineAuthentication;
  static Authentication? onlineAuthentication;

  static void fillUserSession(
    Authentication authenticationValue,
  ) {
    onlineAuthentication = authenticationValue;
    sessionId = Logger.getGuid();
    sessionStartTime = DateTime.now();
  }

  static void setLoginStatusCompleted() {
    _isLogin = true;
  }

  static bool isLogin() {
    return _isLogin;
  }

  static void createSession() {
    didCreateSession = true;
    sessionId = Logger.getGuid();
    sessionStartTime = DateTime.now();
    deviceId = ApplicationUtilities.getApplicationInfo().deviceId;
  }

  static String get userName {
    if (onlineAuthentication != null) {
      return onlineAuthentication!.user.userEmail;
    }
    return 'Not Login';
  }

  static String get pushRegistrationId {
    if (onlineAuthentication != null) {
      return onlineAuthentication!.user.pushRegisterId ?? '';
    }
    return '';
  }

  static bool get pushRegistered {
    if (onlineAuthentication != null) {
      return onlineAuthentication!.user.pushRegistered;
    }
    return false;
  }

  ///Sign in ve Sign out işlemleri her zaman yeni bir Session başlatır.
  static void clearUserSession() {
    onlineAuthentication = null;
    didShowWelcomeMessage = false;
    sessionId = Logger.getGuid();
    sessionStartTime = DateTime.now();
    _isLogin = false;
  }

  static User get currentUser {
    if (onlineAuthentication == null) {
      return User();
    } else {
      return onlineAuthentication!.user;
    }
  }
}
