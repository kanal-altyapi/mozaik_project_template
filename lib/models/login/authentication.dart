 

import 'token.dart';
import 'user.dart';

class Authentication {
  //Authentication();
  Authentication.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user_info']['data'] as Map<String, dynamic>);
    token = Token.fromJson(json['token_info'] as Map<String, dynamic>);
  }

  late User user;
  late Token token;
}
