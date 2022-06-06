
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

class OnlineService extends BaseService {
  OnlineService({this.onlineServiceUrl = '/onlineTransaction'});

  final String onlineServiceUrl;

  Future<Result<Response>> postData(ApiRequest request, {bool useOnlineToken = true, bool withAuthentication = true}) async {
    final Map<String, String> headers = prepareHeaders(useOnlineToken: useOnlineToken, withAuthentication: withAuthentication);

    final String requestJson = dart_convert.json.encode(request.toMap());

    final Result<Response> response = await http.post(Uri.parse(baseUrl + onlineServiceUrl),
        headers: headers,
        body: dart_convert.utf8.encode(requestJson),
        useZbSecure: true,
        timeout: Duration(seconds: appConfigInfoInstance.generalDefaultTimeOut));

    printDebugResponseAndRequest(response, requestJson);

    return response;
  }
}
