import 'package:flutter/material.dart';
import 'package:mozaik_common/api-common/action_response.dart';
import 'package:mozaik_common/models/sms_type.dart';
import '../../../common/localization_util.dart' as localization;
import '../../../common/storage_utils.dart';
import '../../../managers/authentication_manager.dart';
import '../../../models/login/get_last_sms_code_request.dart';
import '../../../models/login/send_sms_request.dart';
import '../../../models/login/sms_response.dart';
import '../../widgets/login/sms_verification_widget.dart';
import '../x_operation/x_operation_screen.dart';

class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen();

  @override
  _SmsApprovePageState createState() => _SmsApprovePageState();
}

class _SmsApprovePageState extends State<SmsVerificationScreen> {
  String userFullName = '';
  String userEMail = '';
  String userMobileNumber = '';
  String smsApproveKey = '';
  String userImage = '';
 

  @override
  void initState() {
 
    getInitialData();
    super.initState();
  }

  void getInitialData() {
    StorageUtilities.getUserFullName().then((String value) {
      setState(() {
        userFullName = value;
      });
    });
    StorageUtilities.getUserEmail().then((String value) {
      setState(() {
        userEMail = value;
      });
    });
    StorageUtilities.getUserMobileNumber().then((String value) {
      setState(() {
        userMobileNumber = value;
      });
    });
    StorageUtilities.getUserImage().then((String value) {
      setState(() {
        userImage = value;
      });
    });
  }

  Future<bool> verifySms(String enteredSms) async {
    final ActionResponse<SmsResponse> smsResponse = await authenticationUtil
        .verifySms(GetLastSmsCodeRequest(userEMail, enteredSms));
    return smsResponse.isSuccess;
  }

  @override
  Widget build(BuildContext context) {
    return _buildSmsPage();
  }

  Widget _buildSmsPage() {
    return SmsVerificationWidget(
        timerDuration: 120,
        userFullName: userFullName,
        userMobileNumber: userMobileNumber,
        onSendSmsAgain: _sendSmsAgain,
        verifySmsResponse: verifySms,
        keyEmptyErrorText:
            localization.translate(context, 'SmsApprove_KeyEmptyErrorText'),
        keyWrongErrorText:
            localization.translate(context, 'SmsApprove_KeyWrongErrorText'),
        preNameText: localization.translate(context, 'SmsApprove_PreNameText'),
        infoText: hideNumber(userMobileNumber) +
            localization.translate(context, 'SmsApprove_InfoText')!,
        smsHintText: localization.translate(context, 'SmsApprove_SmsHintText'),
        enterButtonText:
            localization.translate(context, 'SmsApprove_EnterButtonText'),
        resendSmsButtonText:
            localization.translate(context, 'SmsApprove_ResendSmsButtonText'),
        onRoute: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute<dynamic>(
            builder: (_) => XOperationScreen(),
          ));
        },
        userImage: userImage,
        isCupertinoAlert: true,
         versionText: localization.getVersionText(context),
        alertBoxOkText: localization.translate(context, 'Ok'));
  }

  Future<void> _sendSmsAgain() async {
    try {
      await authenticationUtil.sendSmsAgain(
          SendSmsRequest(userEMail, userMobileNumber, SmsType.LoginValidation));
      setState(() {});
    } on Exception {
      setState(() {
        smsApproveKey = '';
      });
    }
  }

  String hideNumber(String userMobileNumber) {
    String newNumber = userMobileNumber;
    for (int i = 4; i < userMobileNumber.length - 2; i++) {
      newNumber = replaceCharAt(newNumber, i, '*');
    }
    return newNumber;
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }
}
