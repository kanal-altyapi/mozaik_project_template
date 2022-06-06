import 'package:flutter/material.dart';

class LoginLoadingWidget extends StatelessWidget {
  const LoginLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Image.asset(
        'assets/images/bg-gray.png',
        fit: BoxFit.fill,
      ),
      const Center(child: CircularProgressIndicator())
    ]));
  }
}