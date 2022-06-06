class Token {
  //Token();
  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'] as String;
    tokenType = json['token_type'] as String;
    expiresIn = json['expires_in'] as int;
    scope = json['scope'] as String;
    createTime = DateTime.now();
  }
  late String accessToken;
  late String tokenType;
  late int expiresIn;
  late String scope;
  late DateTime createTime;
}
