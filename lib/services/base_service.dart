import 'package:flutter/material.dart';
import 'package:mozaik_common/api-common/response.dart';
import 'package:mozaik_common/api-common/result.dart';

import '../common/app_config_util.dart';
import '../common/offline_session_util.dart';
import '../managers/user_session_manager.dart';
// import 'package:ziraat_mobile_approval/common/utilities/app_config_utilities.dart';
// import 'package:ziraat_mobile_approval/common/utilities/flutter_local_logger.dart';
// import 'package:ziraat_mobile_approval/common/utilities/offline_session_utility.dart';
// import 'package:ziraat_mobile_approval/models/models_export.dart';

class BaseService {
  BaseService();

  String baseUrl = appConfigInfoInstance.apiBaseUrl;

  //Withauthentication True ise daha önce alınmış olan Token kullanılacağı anlamına gelir.Daha önce token alınmış , o token kullanılacak
  //UseOnlineToken True ise Online token kullanılar ,false da ise Offline token kullanılır.
  Map<String, String> prepareHeaders({required bool withAuthentication, required bool useOnlineToken}) {
    Map<String, String> headers;

    if (withAuthentication) {
      if (useOnlineToken) {
        headers = <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${UserSession.onlineAuthentication!.token.accessToken}',
        };
      } else {
        if (OfflineSessionUtility.offlineAuthentication == null || _controlOfflineTokenIsSessionExpired()) {
          OfflineSessionUtility.createSession();
        }
        headers = <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${OfflineSessionUtility.offlineAuthentication!.token!.accessToken}',
        };
      }
    } else {
      headers = <String, String>{
        'Content-type': 'application/json',
      };
    }

    return headers;
  }

  //Session süresi doldu ise true , dolmadı ise false döner
  //Session süresi dolmasına 10 saniye kalmış olsa da sesion süresi doldu olarak dönecektir.
  bool _controlOfflineTokenIsSessionExpired() {
    if (OfflineSessionUtility.offlineAuthentication != null && OfflineSessionUtility.offlineAuthentication!.token != null) {
      DateTime controlDate = OfflineSessionUtility.offlineAuthentication!.token!.createTime
          .add(Duration(seconds: OfflineSessionUtility.offlineAuthentication!.token!.expiresIn - 10));
      return controlDate.isAfter(DateTime.now()) == false ? true : false;
    }
    return true;
  }

  void printDebugResponseAndRequest(Result<Response> response, String requestJson) {
    if (response.data != null) {
      debugPrint('${DateTime.now().toString()}:request:$requestJson');
      debugPrint('${DateTime.now().toString()}:response:' + response.data!.body.toString());

      
    } else {
      debugPrint('${DateTime.now().toString()}:response is null.request : + $requestJson');
     
    }
  }
}
