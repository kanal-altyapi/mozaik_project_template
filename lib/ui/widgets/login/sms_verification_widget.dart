import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image_utils;
import 'package:mozaik_alertbox/alert_box_text.dart';
import 'package:mozaik_alertbox/cupertino_alert.dart';
import 'package:mozaik_alertbox/enum/alert_type.dart';
import 'package:mozaik_alertbox/models/cupertino_models.dart';
import '../../../common/common_util.dart';
import 'circular_count_down_timer.dart';
import 'constants.dart';

// ignore: prefer_generic_function_type_aliases
typedef Future<bool> VerifySmsResponse(String enteredSms);
typedef OnRoute = Future<void> Function();

class SmsVerificationWidget extends StatefulWidget {
   const SmsVerificationWidget({
    required this.userFullName,
    required this.userMobileNumber,
    required this.timerDuration,
    required this.onSendSmsAgain,
    required this.onRoute,
    this.userImage,
    this.infoText,
    this.keyEmptyErrorText,
    this.keyWrongErrorText,
    this.preNameText,
    this.smsHintText,
    this.enterButtonText,
    this.resendSmsButtonText,
    this.isCupertinoAlert = false,
    this.alertBoxOkText,
    this.verifySmsResponse,
    this.disableErrorHandling = false,
    this.versionText = '',
  });

  final String userFullName;
  final String userMobileNumber;
  final String? userImage;
  final int timerDuration;
  final Function onSendSmsAgain;
  final VerifySmsResponse? verifySmsResponse;
  final bool isCupertinoAlert;
  final String? alertBoxOkText;
  final String? keyEmptyErrorText;
  final String? keyWrongErrorText;
  final String? preNameText;
  final String? infoText;
  final String? smsHintText;
  final String? enterButtonText;
  final String? resendSmsButtonText;
  final OnRoute onRoute;
  final bool disableErrorHandling;
  final String versionText;

  @override
  _SmsApprovePageWidgetState createState() => _SmsApprovePageWidgetState();
}

class _SmsApprovePageWidgetState extends State<SmsVerificationWidget> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;
  bool isFinished = false;
  late CircularCountDownTimer _countDownTimer;
  late AnimationController _controller;

  bool _isSubmitting = false;
  final GlobalKey<FormState> _smsApproveFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _countDownTimer = buildCounterWidget();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
   final double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        getBackgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Stack(children: <Widget>[
                GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                        key: _smsApproveFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: AppBar().preferredSize.height * 0.7,
                            ),
                            getTopLogo(context),
                            const SizedBox(
                              height: 10,
                            ),
                            if (widget.userImage != null) buildCircleAvatar() else const SizedBox.shrink(),
                            const SizedBox(
                              height: 20,
                            ),
                            buildNameText(),
                            const SizedBox(
                              height: 10,
                            ),
                            buildInfoText(),
                            const SizedBox(
                              height: 15,
                            ),
                            buildSmsApproveTextWidget(),
                            const SizedBox(
                              height: 10,
                            ),
                            _countDownTimer,
                            const SizedBox(
                              height: 10,
                            ),
                            // ignore: prefer_if_elements_to_conditional_expressions
                            isFinished ? buildSmsSendButtonWidget() : buildSmsApproveButtonWidget(),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    automaticallyImplyLeading: true,
                  ),
                ),
              ]),
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                  height: height * 0.13,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[getBackgroundImage(), getVersion(widget.versionText, height * 0.1)],
                  )),
            ))
      ],
    );
  }

  Widget buildSmsApproveTextWidget() {
    return AutofillGroup(
        child: TextFormField(
      autovalidateMode: AutovalidateMode.disabled,
      validator: (String? value) {
        if (value!.isEmpty) {
          return widget.keyEmptyErrorText;
        }
        return null;
      },
      obscureText: _hidePassword,
      controller: _passwordController,
      scrollPadding:const EdgeInsets.all(200),
      style: style,
      keyboardType: TextInputType.number,
      // ignore: prefer_const_literals_to_create_immutables
      autofillHints: <String>[AutofillHints.oneTimeCode],
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
      decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: widget.smsHintText,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              _hidePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _hidePassword = !_hidePassword;
              });
            },
          ),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    ));
  }

  Container buildSmsApproveButtonWidget() {
    return Container(
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        color: SECONDARY_COLOR,
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: _isSubmitting
              ? null
              : () async {
                  final String enteredCode = _passwordController.text;
                  if (_smsApproveFormKey.currentState!.validate()) {
                    setState(() {
                      _isSubmitting = true;
                    });

                    final bool smsCheckResult = await widget.verifySmsResponse!(enteredCode);
                    setState(() {
                      _isSubmitting = false;
                    });
                    if (smsCheckResult) {
                      await widget.onRoute();
                    } else {
                      _passwordController.clear();
                      if (!widget.disableErrorHandling) {
                        if (enteredCode.isEmpty) {
                          _showError(AlertType.warning, widget.keyEmptyErrorText!);
                        } else {
                          _showError(AlertType.warning, widget.keyWrongErrorText!);
                        }
                      }
                    }
                  }
                },
          child: Text(widget.enterButtonText!, textAlign: TextAlign.center, style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Row buildNameText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.preNameText!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontFamily: 'Montserrat',
            fontSize: 17,
          ),
        ),
        Text(
          '${widget.userFullName},',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            fontSize: 20,
          ),
        )
      ],
    );
  }

  Widget buildInfoText() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Text(
        widget.infoText!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
          fontFamily: 'Montserrat',
          fontSize: 17,
        ),
      ),
    );
  }

  CircularCountDownTimer buildCounterWidget() {
    return CircularCountDownTimer(
      duration: widget.timerDuration,
      width: 100,
      height: 100,
      color: Colors.black,
      fillColor: Colors.white,
      strokeWidth: 4.0,
      textStyle: const TextStyle(fontSize: 18.0, color: Colors.black87, fontWeight: FontWeight.bold),
      isReverse: true,
      onComplete: (AnimationController controller) {
        setState(() {
          isFinished = true;
        });
        _controller = controller;
      },
    );
  }

  Container buildSmsSendButtonWidget() {
    return Container(
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20.0),
        color: SECONDARY_COLOR,
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            _controller.reverse(from: _controller.value == 0.0 ? 1.0 : _controller.value);
            widget.onSendSmsAgain();
            setState(() {
              isFinished = false;
              _countDownTimer = buildCounterWidget();
            });
          },
          child:
              Text(widget.resendSmsButtonText!, textAlign: TextAlign.center, style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  dynamic _showError(AlertType type, String errorText) async {
    if (!widget.isCupertinoAlert) {
      return await AlertBoxText(context: context, title: '', desc: errorText, type: type).show();
    } else {
      return await CupertinoAlert.showAlertDialog(context, CupertinoRequest(description: errorText, okButtonText: widget.alertBoxOkText!));
    }
  }

  Widget buildCircleAvatar() {
    if (widget.userImage != null && widget.userImage != '') {
      final Uint8List img = base64Decode(widget.userImage!);

      final List<int> list = List<int>.from(img);
      image_utils.decodeJpg(list);

      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey,
        child: CircleAvatar(
          backgroundImage: MemoryImage(image_utils.encodeJpg(image_utils.decodeJpg(list)) as Uint8List),
          radius: 59,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
