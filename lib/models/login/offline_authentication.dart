 
import 'token.dart';

class OfflineAuthentication {
  OfflineAuthentication();
  OfflineAuthentication.fromJson(Map<String, dynamic> json) {
    token = Token.fromJson(json['token_info'] as Map<String, dynamic>);
  }
 
  Token? token;
}
