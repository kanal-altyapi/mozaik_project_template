import 'package:flutter/material.dart';
import 'package:mozaik_alertbox/cupertino_alert.dart';
import 'package:mozaik_alertbox/enum/alert_type.dart';
import 'package:mozaik_alertbox/models/cupertino_models.dart';
import 'package:mozaik_common/api-common/action_response.dart';
import 'package:mozaik_common/api-common/error_response.dart';
import '../../../common/data_connection_checker.dart';
import '../../../common/localization_util.dart' as localization;
import '../../../managers/authentication_manager.dart';
import '../../../models/login/authentication.dart';
import '../../../models/login/login_request.dart';
import '../../widgets/login/login_widget.dart';
import 'sms_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _submitting = false;
  void toggleSubmitState(bool value) {
    setState(() {
      _submitting = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoginWidget(
      'applicationIdentity',
      _login,
      true,
      loginButtonText: localization.translate(context, 'LoginButtonText')!,
      userNameValidationText: localization.translate(context, 'UserNameValidationText')!,
      userPasswordValidationText: localization.translate(context, 'UserPasswordValidationText')!,
      rememberMeText: localization.translate(context, 'RememberMeText')!,
      userNameFieldHintText: localization.translate(context, 'UserNameFieldHintText')!,
      userPasswordHintText: localization.translate(context, 'UserPasswordHintText')!,
      versionText: localization.getVersionText(context),
    );
  }

  Future<bool> _login(String userName, String userPassword) async {
    toggleSubmitState(true);

    final String password = authenticationUtil.encryptPassword(userPassword);
    final ActionResponse<Authentication> response = await authenticationUtil.verifyUser(
      LoginRequest(
        userName,
        password,
        true,
      ),
    );
    bool result = await _handleLoginResponse(response, userName: userName);

    toggleSubmitState(false);
    return result;
  }

  Future<bool> _handleLoginResponse(ActionResponse<Authentication> response, {String? userName}) async {
    ErrorResponse? err;

    if (response.isSuccess) {
      final MaterialPageRoute<dynamic> route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const SmsVerificationScreen(),
      );
      Navigator.push(context, route);
      return true;
    } else {
      toggleSubmitState(false);

      if (response.errorResponse != null && response.errorResponse != null) {
        err = response.errorResponse;

        await _showWrongCredentialError(AlertType.warning, err).then((dynamic value) {
          return false;
        });
      } else {
        err = ErrorResponse('', '', false, response.exceptionId!);
        await _showWrongCredentialError(AlertType.warning, err).then((dynamic value) {
          return false;
        });
      }
      return false;
    }
  }

  Future<CupertinoResponse?> _showWrongCredentialError(AlertType type, ErrorResponse? error) async {
    String? desc = '';
    if (error != null && error.showUser == true) {
      desc = localization.translate(context, error.errorCode);
      desc = desc ?? error.errorText;
    } else {
      final ConnectionCheckerResult checkerResult = await MozDataConnectionChecker.checkConnection();
      if (checkerResult.hasConnection) {
        desc = localization.translate(context, error!.errorCode);
      } else {
        desc = 'İnternet bağlantınızı kontrol ediniz!';
      }
    }

    return await CupertinoAlert.showAlertDialog(context, CupertinoRequest(description: desc!, okButtonText: localization.translate(context, 'Ok')!),
        onOkPressed: () {});
  }
}
