class UserConfiguration {
  UserConfiguration() {
    isPilotUser = false;
    logLevel = 3;
    isBlacklistUser = false;
    userName = '';
  }

  UserConfiguration.fromMap(Map<String, dynamic> map) {
    try {
      userName = map['userName'] != null ? map['userName'].toString() : '';
      if (map['isPilotUser'] != null) {
        isPilotUser = map['isPilotUser'] as bool;
      } else {
        isPilotUser = false;
      }
      logLevel = map['logLevel'] != null ? map['logLevel'] as int : 3;
      if (map['isBlacklistUser'] != null) {
        isBlacklistUser = map['isBlacklistUser'] as bool;
      } else {
        isBlacklistUser = false;
      }
    } catch (e) {
      isPilotUser = false;
      logLevel = 3;
      isBlacklistUser = false;
    }
  }
  late String userName;
  late bool isPilotUser;
  late int logLevel;
  late bool isBlacklistUser;
}
