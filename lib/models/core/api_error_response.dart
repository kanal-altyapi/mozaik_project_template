/*
import 'iapi_base_model.dart';

class ApiErrorResponse implements IApiBaseModel {
  ApiErrorResponse(
      {this.errorCode, this.errorId, this.errorText, this.showUser});

  String errorText;
  String errorCode;
  bool showUser;
  String errorId;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['errorText'] = errorText;
    map['errorCode'] = errorCode;
    map['showUser'] = showUser;
    map['errorId'] = errorId;
    return map;
  }

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
        errorCode: json['errorCode'].toString(),
        errorId: json['errorId'].toString(),
        errorText: json['errorText'].toString(),
        showUser: json['showUser'] as bool);
  }
}
*/
