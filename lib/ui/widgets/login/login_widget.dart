import 'package:flutter/material.dart';
import '../../../common/common_util.dart';
import 'constants.dart' as constants;
import 'login_widget_util.dart';

// ignore: prefer_generic_function_type_aliases
typedef Future<bool> LoginButtonPress(String userName, String userPassword);

class LoginWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginWidget(
    this.applicationIdentity,
    this.onLoginButtonPressed,
    this.showRememberMe, {
    this.loginButtonText = constants.LOGIN_BUTTON_TEXT,
    this.userNameValidationText = constants.USER_NAME_FIELD_VALIDATION_TEXT,
    this.userNameFieldHintText = constants.USER_NAME_FIELD_HINT_TEXT,
    this.userPasswordValidationText = constants.USER_PASSWORD_VALIDATION_TEXT,
    this.userPasswordHintText = constants.USER_PASSWOD_FIELD_HINT_TEXT,
    this.rememberMeText = constants.REMEMBER_ME_TEXT,
    this.versionText = '',
    this.versionTextFunction,
  });

  final String loginButtonText;
  final String userNameValidationText;
  final String userNameFieldHintText;
  final String userPasswordValidationText;
  final String userPasswordHintText;
  final String rememberMeText;
  final bool showRememberMe;
  final String versionText;
  final String applicationIdentity;
  final LoginButtonPress? onLoginButtonPressed;
  final Function? versionTextFunction;

  @override
  _MozLoginPageState createState() => _MozLoginPageState();
}

class _MozLoginPageState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  bool _hidePassword = true;
  bool _rememberMe = false;
  String captchaCode = '';

  late LoginWidgetUtil loginUtil;
  late TextEditingController _mailController;
  bool ignorePressed = false;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    loginUtil = LoginWidgetUtil(widget.applicationIdentity);
    _mailController = TextEditingController();

    super.initState();
    Future<dynamic>.delayed(Duration.zero, () => _initializeRememberMe());
  }

  Future<void> _initializeRememberMe() async {
    if (!mounted) {
      return;
    }
    if (!widget.showRememberMe) {
      return;
    }

    _rememberMe = await loginUtil.getRememberMe();
    if (_rememberMe) {
      _mailController.text = await loginUtil.getLoginUser();
    }

    if (mounted) {
      setState(() {});
    }
  }

  TextFormField _getUserNameField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? value) {
        if (value!.isEmpty) {
          return widget.userNameValidationText;
        }
        return null;
      },
      controller: _mailController,
      obscureText: false,
      style: style,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          fillColor: Colors.white,
          focusColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: widget.userNameFieldHintText,
          filled: true,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      enableSuggestions: false,
      autocorrect: false,
    );
  }

  TextFormField _getUserPasswordField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.disabled,
      validator: (String? value) {
        if (value!.isEmpty) {
          return widget.userPasswordValidationText;
        }
        return null;
      },
      obscureText: _hidePassword,
      controller: _passwordController,
      style: style,
      decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          fillColor: Colors.white,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: widget.userPasswordHintText,
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
    );
  }

  Material _getLoginButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: constants.SECONDARY_COLOR,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (_rememberMe) {
              loginUtil.setLoginUser(_mailController.text);
            }

            if (widget.onLoginButtonPressed != null) {
              await widget.onLoginButtonPressed!(_mailController.text, _passwordController.text);

              _passwordController.clear();
            }
          }
        },
        child: Text(widget.loginButtonText, textAlign: TextAlign.center, style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _getRememberMeSwitch() {
    return Visibility(
        visible: widget.showRememberMe,
        child: Switch(
          value: _rememberMe,
          onChanged: (bool value) {
            setState(() {
              _rememberMe = value;
              loginUtil.setRememberMe(_rememberMe);
            });
          },
          activeColor: Colors.blue,
        ));
  }

  Widget _getRememberMeText() {
    return Visibility(
        visible: widget.showRememberMe,
        child: Text(
          widget.rememberMeText,
          style: const TextStyle(color: Colors.white),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(children: <Widget>[
          getBackgroundImage(),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 36.0, right: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: AppBar().preferredSize.height / 2,
                          ),
                          getTopLogo(context),
                          const SizedBox(
                            height: 40,
                          ),
                          _getUserNameField(),
                          const SizedBox(
                            height: 15,
                          ),
                          _getUserPasswordField(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[_getRememberMeSwitch(), _getRememberMeText()],
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          _getLoginButton(),
                        ],
                      ),
                    )
                  ],
                )),
          )
        ]),
        bottomNavigationBar: SizedBox(
            height: height * 0.13,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                getBackgroundImage(),
                SafeArea(
                  child: getVersion(
                    widget.versionText,
                    height * 0.1,
                    func: widget.versionTextFunction,
                  ),
                ),
              ],
            )));
  }
}
