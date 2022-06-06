import 'package:mozaik_common/api-common/api_transaction_header.dart';
import 'package:mozaik_common/api-common/moz_api_base_request.dart';
// import 'package:ziraat_mobile_approval/common/enums/api_transaction_type.dart';
// import 'package:ziraat_mobile_approval/common/utilities/app_config_utilities.dart';
// import 'package:ziraat_mobile_approval/common/utilities/repository_util.dart';

import '../../common/app_config_util.dart';
import '../../common/enums/api_transaction_type.dart';
import '../../common/repository_util.dart';

class ApiRequest extends MozaikBaseApiRequest {
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = super.toMap();
    map['transactionHeader'] = transactionHeader.toMap();
    map['ocp'] = ocp;
    return map;
  }

  Map<String, dynamic> toMapForLogin() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['transactionHeader'] = transactionHeader.toMap();
    map['data'] = data;
    map['scope'] = appConfigInfoInstance.apigatewayOnlineScope;
    map['client_id'] = appConfigInfoInstance.apigatewayOnlineClientId;
    map['client_secret'] = appConfigInfoInstance.apigatewayOnlineClientSecret;
    map['username'] = appConfigInfoInstance.apigatewayOnlineUsername;
    map['password'] = appConfigInfoInstance.apigatewayOnlinePassword;
    map['ocp'] = ocp;
    return map;
  }

  Map<String, dynamic> toMapForOfflineToken() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['transactionHeader'] = transactionHeader.toMap();
    map['data'] = data;
    map['scope'] = appConfigInfoInstance.apigatewayOfflineScope;
    map['client_id'] = appConfigInfoInstance.apigatewayOfflineClientId;
    map['client_secret'] = appConfigInfoInstance.apigatewayOfflineClientSecret;
    map['username'] = appConfigInfoInstance.apigatewayOfflineUsername;
    map['password'] = appConfigInfoInstance.apigatewayOfflinePassword;
    map['ocp'] = ocp;
    return map;
  }

  ApiRequest(bool isOnline, {ApiTransactionType? tranType, data, this.ocp = true}) : super(data: data) {
    if (tranType != null) {
      this.transactionType = tranType.index;
    }

    if (isOnline) {
      transactionHeader = RepositoryUtil.crateOnlineRequestTransactionHeader(transactionType);
    } else {
      transactionHeader = RepositoryUtil.crateOfflineRequestTransactionHeader(transactionType);
    }
  }

  factory ApiRequest.empty(bool isOnline, ApiTransactionType tranType, {bool ocp = true}) {
    return ApiRequest(isOnline, tranType: tranType, ocp: ocp);
  }

  void setData(String? data) {
    this.data = data;
  }

  void setTranType(ApiTransactionType tranType) {
    this.transactionType = tranType.index;
    this.transactionHeader.transactionType= this.transactionType!;
  }

  late ApiTransactionHeader transactionHeader;
  int? transactionType;
  dynamic transferData;
  bool ocp;
}
