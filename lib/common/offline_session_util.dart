import 'package:mozaik_common/api-common/action_response.dart';
import 'package:mozaik_common/utilities/application_utilities.dart';
// import 'package:ziraat_mobile_approval/common/enums/enums_export.dart';
// import 'package:ziraat_mobile_approval/common/utilities/logger_utils.dart';
// import 'package:ziraat_mobile_approval/models/core/mobile_approval_api_request.dart';
// import 'package:ziraat_mobile_approval/models/models_export.dart';
// import 'package:ziraat_mobile_approval/models/offline_authentication.dart';
// import 'package:ziraat_mobile_approval/repositories/offline_token_repository.dart';

import '../models/core/mobile_approval_api_request.dart';
import '../models/login/offline_authentication.dart';
import '../models/login/token.dart';
import '../repositories/offline_token_repository.dart';
import 'enums/api_transaction_type.dart';
import 'logger_util.dart';

mixin OfflineSessionUtility {
  static bool isRememberMe = false;
  static bool didShowWelcomeMessage = false;
  static String sessionId = '0';
  static bool didCreateSession = false;
  static String deviceId = '0';
  static late DateTime sessionStartTime;
  static OfflineAuthentication? offlineAuthentication;

  static void _fillOfflineSession(
    OfflineAuthentication authenticationValue,
  ) {
    offlineAuthentication = authenticationValue;
    sessionId = Logger.getGuid();
    sessionStartTime = DateTime.now();
  }

  static Future<void> createSession() async {
    didCreateSession = true;
    sessionId = Logger.getGuid();
    sessionStartTime = DateTime.now();
    deviceId = ApplicationUtilities.getApplicationInfo().deviceId;
    OfflineTokenRepository repository = OfflineTokenRepository();

    //todo burada tranType boş olmaması için geçildi.Nasıl davranacağı test edilmelidir.
    ApiRequest apiRequest = ApiRequest(false, tranType: ApiTransactionType.AddLogRecord);

    ActionResponse<Token> offlineTokenResponse = await repository.getOfflineToken(apiRequest);

    if (offlineTokenResponse.isSuccess) {
      OfflineAuthentication offlineAuth = OfflineAuthentication()..token = offlineTokenResponse.actionData;
      _fillOfflineSession(offlineAuth);
    } else {
      didCreateSession = false;
    }
  }
}
