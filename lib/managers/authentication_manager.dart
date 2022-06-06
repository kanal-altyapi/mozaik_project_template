import 'package:mozaik_common/api-common/action_response.dart';
import 'package:mozaik_common/api-common/iapi_base_model.dart';
import 'package:mozaik_crypt/moz_aes.dart';
import '../common/enums/api_transaction_type.dart';
import '../common/manager_util.dart';
import '../common/repository_util.dart';
import '../common/storage_utils.dart';
import '../models/core/mobile_approval_api_request.dart';
import '../models/login/authentication.dart';
import '../models/login/get_last_sms_code_request.dart';
import '../models/login/login_request.dart';
import '../models/login/send_sms_request.dart';
import '../models/login/sms_response.dart';
import '../repositories/authentication_repository.dart';
import 'user_session_manager.dart';

AuthenticationManager authenticationUtil = AuthenticationManager();

class AuthenticationManager {
  String encryptPassword(String password) {
    try {
      const String fortunaKey = 'NzQ1MjQ1OTg3MzY1NDQ1OA==';
      const String iv = 'Vzc0NU9LTFNUNjU0RjUxWg==';
      final MozAes aesEncrypter = MozAes();
      final String encrypted = aesEncrypter.encrypt(password, fortunaKey, ivBase64: iv);

      return encrypted;
    } catch (ex) {
      return '';
    }
  }

  Future<ActionResponse<Authentication>> verifyUser(LoginRequest login) async {
    ActionResponse<Authentication> response;
    ApiRequest request = ApiRequest(false, tranType: ApiTransactionType.Login);
    try {
      request.setData(RepositoryUtil.serialize(login));
      response = await authenticationRepository.verifyUser(request);

      if (response.isSuccess) {
        setUserInfoToStorageFromObj(response.actionData!);
      } else {}
    } catch (e, s) {
      response = ActionResponse<Authentication>();
      response = prepareUnHandledActionResponseAndLog(
          response, request.transactionHeader.requestId, login, 'verifyUser metodunda hata oldu.', s, e, 'verifyUser');
    }

    return response;
  }

  //setUserInfoToStorageFromObj
  Future<void> setUserInfoToStorageFromObj(Authentication authentication) async {
    fillUserSession(authentication);
    try {
      await StorageUtilities.setToken(authentication.token.accessToken);
      await StorageUtilities.setUserFullName(authentication.user.userFullName);
      await StorageUtilities.setUserMobileNumber(authentication.user.mobileNumber);
      await StorageUtilities.setUserImage(authentication.user.userImage);
      await StorageUtilities.setUserEmail(authentication.user.userEmail);
      await StorageUtilities.setCallerInfoUserName(authentication.user.userIdentityInfo.userId);
      await StorageUtilities.setCallerInfoBranchId(authentication.user.userIdentityInfo.userBranchId.toString());
    } catch (e) {
     
      await StorageUtilities.deleteAllSecureStorage();
    }
  }

  void fillUserSession(Authentication authentication) {
    UserSession.fillUserSession(authentication);
  }
    //Unhandled durumlarda ActionResponse'u hazırlar ,exception log atar
  ActionResponse<T> prepareUnHandledActionResponseAndLog<T>(
      ActionResponse<T> response, String requestId, IApiBaseModel content, String message, StackTrace s, dynamic e, String recordTrxCode) {
    return ManagerUtil.prepareUnHandledActionResponseAndLog(response, requestId, content, message, s, e, recordTrxCode);
  }

    Future<ActionResponse<SmsResponse>> verifySms(GetLastSmsCodeRequest smsCodeRequest) async {
    final ApiRequest request = ApiRequest(true, tranType: ApiTransactionType.GetLastSmsCode, data: RepositoryUtil.serialize(smsCodeRequest));
    ActionResponse<SmsResponse> response;
    try {
      response = await authenticationRepository.verifySms(request);
    } catch (e, s) {
      response = ActionResponse<SmsResponse>();
      response = prepareUnHandledActionResponseAndLog(
          response, request.transactionHeader.requestId, smsCodeRequest, 'verifySms metodunda hata oldu.', s, e, 'verifySms');
    }

    return response;
  }

   Future<ActionResponse<SmsResponse>> sendSmsAgain(SendSmsRequest sendSms) async {
    ActionResponse<SmsResponse> response = ActionResponse<SmsResponse>();
    ApiRequest request = ApiRequest(true, tranType: ApiTransactionType.SendSms);
    try {
      request.setData(RepositoryUtil.serialize(sendSms));
      response = await authenticationRepository.sendSms(request);
    } catch (e, s) {
      response = ActionResponse<SmsResponse>();
      response = prepareUnHandledActionResponseAndLog(
          response, request.transactionHeader.requestId, sendSms, 'sendSmsAgain metodunda hata oldu.', s, e, 'sendSmsAgain');
    }

    return response;
  }
}
