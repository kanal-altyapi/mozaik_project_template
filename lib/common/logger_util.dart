import 'package:uuid/uuid.dart';

class Logger {
  static String getGuid() {
    Uuid uuid = const Uuid();
    final String guid = uuid.v4();
    return guid;
  }
}
