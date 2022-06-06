 import 'package:data_connection_checker_tv/data_connection_checker.dart';

class ConnectionCheckerResult {
  ConnectionCheckerResult(this.hasConnection);
  bool hasConnection;
}

class MozDataConnectionChecker {
  static Future<ConnectionCheckerResult> checkConnection() async {
    try {
      final bool result = await DataConnectionChecker().hasConnection;
      if (result == true) {
        return ConnectionCheckerResult(true);
      } else {
        return ConnectionCheckerResult(false);
      }
    } catch (e) {
      return ConnectionCheckerResult(true);
    }
  }
}
