
import 'package:mozaik_common/api-common/response.dart';
import 'package:mozaik_common/api-common/result.dart';
// import 'package:ziraat_mobile_approval/common/utilities/app_config_utilities.dart';
// import 'package:ziraat_mobile_approval/models/core/mobile_approval_api_request.dart';
// import 'package:ziraat_mobile_approval/services/base_service.dart';
import 'package:mozaik_http/mozaik_http.dart' as http;

import 'dart:convert' as dart_convert;

import '../common/app_config_util.dart';
import '../models/core/mobile_approval_api_request.dart';
import 'base_service.dart';

class OfflineService extends BaseService {
  OfflineService({this.offlineServiceUrl = '/approval/approvalAction'});

  String offlineServiceUrl = '/approval/approvalAction';

  Future<Result<Response>> postData(ApiRequest request,
      {bool isLogin = false, bool isCreateToken = false, bool useOnlineToken = false, bool withAuthentication = false}) async {
    final Map<String, String> headers = prepareHeaders(useOnlineToken: useOnlineToken, withAuthentication: withAuthentication);
    Result<Response> response;
    String requestJson = '';
    if (isLogin) {
      requestJson = dart_convert.json.encode(request.toMapForLogin());
      response = await http.post(Uri.parse(baseUrl + offlineServiceUrl),
          headers: headers,
          body: dart_convert.utf8.encode(requestJson),
          useZbSecure: true,
          timeout: Duration(seconds: appConfigInfoInstance.generalDefaultTimeOut));
    } else {
      if (offlineServiceUrl == '/token/getOfflineToken') {
        baseUrl = appConfigInfoInstance.apiBaseOfflineTokenUrl;
      }

      requestJson = dart_convert.json.encode(isCreateToken == true ? request.toMapForOfflineToken() : request.toMap());
      response = await http.post(Uri.parse(baseUrl + offlineServiceUrl),
          headers: headers,
          body: dart_convert.utf8.encode(requestJson),
          useZbSecure: true,
          timeout: Duration(seconds: appConfigInfoInstance.generalDefaultTimeOut));
    }

    printDebugResponseAndRequest(response, requestJson);

    return response;
  }
}
