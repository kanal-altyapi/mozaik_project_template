import 'package:mozaik_common/api-common/exports.dart';


class GetLastSmsCodeRequest implements IApiBaseModel {
  GetLastSmsCodeRequest(this.userEmail, this.smsCode);
  String userEmail;
  String smsCode;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['userEmail'] = userEmail;
    map['smsCode'] = smsCode;
    return map;
  }
}
