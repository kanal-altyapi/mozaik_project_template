import 'package:mozaik_common/api-common/action_response.dart';
import 'package:mozaik_common/api-common/api_transaction_header.dart';
import 'package:mozaik_common/api-common/error_response.dart';
import 'package:mozaik_common/api-common/http_error_type.dart';
import 'package:mozaik_common/api-common/iapi_base_model.dart';
import 'package:mozaik_common/api-common/response.dart';
import 'package:mozaik_common/api-common/result.dart';
import 'package:mozaik_common/utilities/api_utilities.dart';

import '../managers/user_session_manager.dart';
import '../models/core/mobile_approval_api_request.dart';
import 'application_util.dart';
import 'logger_util.dart';

class RepositoryUtil {

  static ApiTransactionHeader crateOnlineRequestTransactionHeader(int? tranType) {
    ApiTransactionHeader apiTransactionHeader = ApiTransactionHeader();
    apiTransactionHeader.languageCode = 'Tr';
    apiTransactionHeader.phoneNumber = UserSession.currentUser.mobileNumber;
    apiTransactionHeader.branchId = UserSession.currentUser.userIdentityInfo.userBranchId;
    apiTransactionHeader.requestId = Logger.getGuid();
    apiTransactionHeader.applicationInfo = ApplicationUtil.applicationInfo;
    apiTransactionHeader.sessionId = UserSession.sessionId;
    apiTransactionHeader.userName = UserSession.currentUser.userIdentityInfo.userId;
    if (tranType != null) {
      apiTransactionHeader.transactionType = tranType;
    }

    return apiTransactionHeader;
  }

  static ApiTransactionHeader crateOfflineRequestTransactionHeader(int? tranType) {
    ApiTransactionHeader apiTransactionHeader = ApiTransactionHeader();
    apiTransactionHeader.languageCode = 'Tr';
    apiTransactionHeader.phoneNumber = '';
    apiTransactionHeader.branchId = 0;
    apiTransactionHeader.requestId = Logger.getGuid();
    apiTransactionHeader.applicationInfo = ApplicationUtil.applicationInfo;
    apiTransactionHeader.sessionId = UserSession.sessionId;
    apiTransactionHeader.userName = '';
     if (tranType != null) {
      apiTransactionHeader.transactionType = tranType;
    }
    return apiTransactionHeader;
  }

    static String serialize(IApiBaseModel requestModel) {
    return ApiUtilities.serialize(requestModel);
  }

    static Future<ActionResponse<T>> prepareExceptionalResponse<T>(Result<Response> response, ApiRequest apiRequest) async {
    ActionResponse<T> actionResponse = ActionResponse<T>();
    try {
      actionResponse = ActionResponse<T>();
      actionResponse.isSuccess = false;
      actionResponse.errorType = controlHttpResponseCode(response);
      actionResponse.error = response.exception != null ? response.exception.toString() : '';
      actionResponse.message = response.message ?? '';
      actionResponse.exceptionId = Logger.getGuid();

      actionResponse.errorResponse = prepareErrorResponse(response, actionResponse.exceptionId!, apiRequest);
      actionResponse.requestId = apiRequest.transactionHeader.requestId;

     
    } catch (e, s) {
      final String logId = Logger.getGuid();

     

      ErrorResponse errorResponse = ErrorResponse(e.toString(), 'UnHandled(RequestId:${apiRequest.transactionHeader.requestId})', false, logId);
      actionResponse.isSuccess = false;
      actionResponse.errorType = HttpErrorType.unhandled;
      actionResponse.exceptionId = logId;
      actionResponse.errorResponse = errorResponse;
    }

    return actionResponse;
  }

  static ErrorResponse prepareErrorResponse(Result<Response> response, String exceptionId, ApiRequest request) {
    ErrorResponse mobileErrorResponse;
    if (response.data != null && response.data!.body != '') {
      mobileErrorResponse = ErrorResponse.fromJson(RepositoryUtil.responseToMap(response));
    } else if (response.data != null && response.data!.reasonPhrase == 'Gateway Timeout') {
      mobileErrorResponse = ErrorResponse(
          'İşlem zaman aşımına uğramıştır.Daha sonra tekrar deneyiniz.(RequestId:${request.transactionHeader.requestId})',
          'GatewayTimeout',
          true,
          exceptionId);
    } else {
      mobileErrorResponse = ErrorResponse(
          'Beklemediğimiz bir hata oldu.Lütfen daha sonra tekrar deneyiniz.(RequestId:${request.transactionHeader.requestId})',
          'prepareErrorResponse',
          true,
          exceptionId);
    }
    return mobileErrorResponse;
  }

  static HttpErrorType controlHttpResponseCode(Result<Response> response) {
    return ApiUtilities.controlHttpResponseCode(response);
  }
 

  static Map<String, dynamic> responseToMap(Result<Response> response) {
    return ApiUtilities.responseToMap(response);
  }
}