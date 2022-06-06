import 'dart:async';
import 'package:mozaik_common/api-common/action_response.dart';
import 'package:mozaik_common/api-common/response.dart';
import 'package:mozaik_common/api-common/result.dart';

import '../common/repository_util.dart';
import '../models/core/mobile_approval_api_request.dart';
import '../models/login/token.dart';
import '../services/offline_service.dart';
// import 'package:ziraat_mobile_approval/common/utilities/repository_util.dart';
// import 'package:ziraat_mobile_approval/models/core/mobile_approval_api_request.dart';
// import 'package:ziraat_mobile_approval/models/token.dart';
// import 'package:ziraat_mobile_approval/services/offline_service.dart';

class OfflineTokenRepository {
  OfflineTokenRepository() {
    _offlineService = OfflineService(offlineServiceUrl: '/token/getOfflineToken');
  }

  late OfflineService _offlineService;

  Future< ActionResponse<Token>> getOfflineToken(ApiRequest request) async {
    ActionResponse<Token> actionResponse = ActionResponse();
    Result<Response> response = await _offlineService.postData(request, isCreateToken: true, withAuthentication: false, useOnlineToken: false);

    if (response.isSuccess) {
      actionResponse.isSuccess = true;
      actionResponse.actionData = Token.fromJson(RepositoryUtil.responseToMap(response));
      actionResponse.requestId = request.transactionHeader.requestId;
      //return Token.fromJson(RepositoryUtil.responseToMap(response));
    } else {
      actionResponse = await RepositoryUtil.prepareExceptionalResponse<Token>(response, request);
    }

    return actionResponse;
  }

  
}
