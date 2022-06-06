import 'package:mozaik_common/api-common/action_response.dart';
import 'package:mozaik_common/api-common/error_response.dart';
import 'package:mozaik_common/api-common/exports.dart';
import 'package:mozaik_common/api-common/http_error_type.dart';

import 'logger_util.dart';
 

class ManagerUtil {
  //Unhandled durumlarda ActionResponse'u hazırlar ,exception log atar(Catch içinde)
  //Manager Class ları içinde alınacak hata durumlarında çağrılmalıdır.
  static ActionResponse<T> prepareUnHandledActionResponseAndLog<T>(
      ActionResponse<T> response,
      String requestId,
      IApiBaseModel content,
      String message,
      StackTrace s,
      dynamic e,
      String recordTrxCode) {
    final String logId = Logger.getGuid();
    response.isSuccess = false;
    response.requestId = requestId;
    response.errorType = HttpErrorType.unhandled;
    response.errorResponse = ErrorResponse(
        'Beklemediğimiz bir hata oldu.Lütfen daha sonra tekrar deneyiniz.',
        'unhandled',
        true,
        logId);
    
    return response;
  }
}
