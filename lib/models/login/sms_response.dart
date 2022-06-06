class SmsResponse {
  SmsResponse({this.isSuccess=false});

  SmsResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'] as bool;
  }
  SmsResponse.fromMap(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'] as bool;
  }
late  bool isSuccess;
}
