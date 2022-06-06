// import 'package:ziraat_mobile_approval/common/enums/api_transaction_type.dart';
// import 'package:ziraat_mobile_approval/common/utilities/repository_util.dart';
// import 'package:ziraat_mobile_approval/models/core/api_transaction_header.dart';

// import '../models_export.dart';

// class ApiRequest {
//   Map<String, dynamic> toMap() {
//     final Map<String, dynamic> map = <String, dynamic>{};
//     map['transactionHeader'] = transactionHeader.toMap();
//     map['data'] = data;

//     return map;
//   }

//   Map<String, dynamic> toMapForLogin() {
//     final Map<String, dynamic> map = <String, dynamic>{};
//     map['transactionHeader'] = transactionHeader.toMap();
//     map['data'] = data;
//     map['scope'] = AppConfigInfo.apigatewayScope;
//     map['client_id'] = AppConfigInfo.apigatewayClientId;
//     map['client_secret'] = AppConfigInfo.apigatewayClientSecret;
//     map['username'] = AppConfigInfo.apigatewayUsername;
//     map['password'] = AppConfigInfo.apigatewayPassword;
//     return map;
//   }

//   ApiRequest(bool isOnline, {ApiTransactionType tranType, this.data}) {
//     if (tranType != null) {
//       this.transactionType = tranType.index;
//     }

//     if (isOnline) {
//       transactionHeader =
//           RepositoryUtil.crateOnlineRequestTransactionHeader(transactionType);
//     } else {
//       transactionHeader =
//           RepositoryUtil.crateOfflineRequestTransactionHeader(transactionType);
//     }
//   }

//   ApiTransactionHeader transactionHeader;
//   int transactionType;
//   String data;
// }
