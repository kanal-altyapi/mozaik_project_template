import 'dart:async';
import 'package:mozaik_common/api-common/action_response.dart';
import 'package:mozaik_common/api-common/moz_model/bool_data_models.dart';
import 'package:mozaik_common/api-common/response.dart';
import 'package:mozaik_common/api-common/result.dart';
import '../common/enums/api_transaction_type.dart';
import '../common/repository_util.dart';
import '../common/storage_utils.dart';
import '../managers/user_session_manager.dart';
import '../models/core/mobile_approval_api_request.dart';
import '../models/core/mobile_approval_api_response.dart';
import '../models/login/authentication.dart';
import '../models/login/sms_response.dart';
import '../services/offline_service.dart';
import '../services/online_service.dart';

// import 'package:ziraat_mobile_approval/common/enums/api_transaction_type.dart';
// import 'package:ziraat_mobile_approval/common/utilities/utilities_export.dart';
// import 'package:ziraat_mobile_approval/models/core/mobile_approval_api_request.dart';
// import 'package:ziraat_mobile_approval/models/core/mobile_approval_api_response.dart';
// import 'package:ziraat_mobile_approval/models/models_export.dart';
// import 'package:ziraat_mobile_approval/services/offline_service.dart';
// import 'package:ziraat_mobile_approval/services/online_service.dart';
AuthenticationRepository authenticationRepository = AuthenticationRepository();

class AuthenticationRepository {
  AuthenticationRepository() {
    _offlineService = OfflineService(offlineServiceUrl: '/authentication');
    _onlineService = OnlineService();
  }

  late OfflineService _offlineService;
  late OnlineService _onlineService;

  Future<void> signOut() async {
    ApiRequest request = ApiRequest(true, tranType: ApiTransactionType.SignOut);
    BoolData boolData = BoolData(true);
    request.data = RepositoryUtil.serialize(boolData);

    final Result<Response> response = await _onlineService.postData(request);

    if (response.isSuccess) {
      UserSession.onlineAuthentication!.token.accessToken = '';
      StorageUtilities.setToken('');
    }
  }

  Future<ActionResponse<SmsResponse>> sendSms(ApiRequest request) async {
    final Result<Response> response = await _onlineService.postData(request);
    ActionResponse<SmsResponse> actionResponse = ActionResponse<SmsResponse>();
    actionResponse.isSuccess = false;
    if (response.isSuccess) {
      final ApiResponse<SmsResponse> apiResponse =
          ApiResponse.fromJsonForData(json: RepositoryUtil.responseToMap(response), data: SmsResponse(), setData: _setDataForSmsResponse);
      actionResponse.isSuccess = apiResponse.isSuccess;
      actionResponse.actionData = apiResponse.data;
      actionResponse.requestId = request.transactionHeader.requestId;
    } else {
      actionResponse.errorResponse = RepositoryUtil.prepareErrorResponse(response, '0', request);
    }

    return actionResponse;
  }

  Future<ActionResponse<SmsResponse>> verifySms(ApiRequest request) async {
    final Result<Response> response = await _onlineService.postData(request);
    ActionResponse<SmsResponse> actionResponse = ActionResponse<SmsResponse>();
    actionResponse.isSuccess = false;

    if (response.isSuccess) {
      final ApiResponse<SmsResponse> apiResponse = ApiResponse<SmsResponse>.fromJsonForData(
          json: RepositoryUtil.responseToMap(response), data: SmsResponse(), setData: _setDataForSmsResponse);
      actionResponse.isSuccess = apiResponse.isSuccess;
      actionResponse.actionData = apiResponse.data;
      actionResponse.requestId = request.transactionHeader.requestId;
    } else {
      actionResponse.errorResponse = RepositoryUtil.prepareErrorResponse(response, '0', request);
    }
    return actionResponse;
  }

  //Kullanıcı adı ve şifresi ile kullanıcı bilgilerini getirir
  Future<ActionResponse<Authentication>> verifyUser(ApiRequest request) async {
    ActionResponse<Authentication> actionResponse = ActionResponse<Authentication>(requestId: request.transactionHeader.requestId);
    final Result<Response> response = await _offlineService.postData(request, isLogin: true, useOnlineToken: false, withAuthentication: false);

    //Servisten 200 geldi.
    if (response.isSuccess) {
      Authentication authentication = Authentication.fromJson(RepositoryUtil.responseToMap(response));
      actionResponse.actionData = authentication;
      actionResponse.isSuccess = true;
      actionResponse.requestId = request.transactionHeader.requestId;
    } else {
      actionResponse = await RepositoryUtil.prepareExceptionalResponse(response, request);
    }

    return actionResponse;
  }

  SmsResponse _setDataForSmsResponse(Map<String, dynamic> json, {dynamic transferData}) {
    return SmsResponse.fromJson(json);
  }
}
