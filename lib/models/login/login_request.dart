
import 'package:mozaik_common/api-common/iapi_base_model.dart';
import '../../common/app_config_util.dart';

class LoginRequest implements IApiBaseModel {
  LoginRequest(this.email, this.password, this.sendSms);

  final String email;
  final String password;
  final bool sendSms;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['sendSms'] = sendSms;
    map['pushApplicationId'] = appConfigInfoInstance.pushApplicationId;
    map['pushApplicationName'] = appConfigInfoInstance.pushApplicationName;
    //if you use  Push notification you must handle below code OOZ
    //map['deviceToken'] = push_message.deviceInfo.token;
    //map['pushDeviceDescription'] = email + '-' + push_message.deviceInfo.model;
    //map['pushDeviceUniqueId'] = push_message.deviceInfo.id;

    return map;
  }
}
