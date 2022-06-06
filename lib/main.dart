import 'package:flutter/material.dart';
import 'package:mozaik_localization/mozaik_localization.dart';
import 'package:mozaik_project_template/ui/screens/login/login_screen.dart';
import 'common/app_config_util.dart';
import 'managers/user_session_manager.dart';

void main() {
  appConfigUtil.initialzeAppConfigInfo();
  UserSession.createSession();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: MozLocalizations.getLocales(),
      localizationsDelegates: MozLocalizations.getLocalizationDelegetes(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return const LoginScreen();
  }
}
