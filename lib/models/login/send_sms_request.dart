import 'package:mozaik_common/api-common/exports.dart';
import 'package:mozaik_common/models/sms_type.dart';

class SendSmsRequest implements IApiBaseModel {
  SendSmsRequest(this.userEmail, this.mobileNumber, this.smsType);
  SendSmsRequest.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'] as String;
    mobileNumber = json['mobileNumber'] as String;
    smsType = SmsType.values[json['smsType'] as int];
  }

  late String userEmail;
  late String mobileNumber;
  late SmsType smsType;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['userEmail'] = userEmail;
    map['mobileNumber'] = mobileNumber;
    map['smsType'] = smsType.index;
    return map;
  }
}
