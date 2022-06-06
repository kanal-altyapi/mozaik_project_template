import 'package:flutter/material.dart';

class XOperationScreen extends StatefulWidget {
  XOperationScreen({Key? key}) : super(key: key);

  @override
  State<XOperationScreen> createState() => _XOperationScreenState();
}

class _XOperationScreenState extends State<XOperationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Appbar"),
        actions: <Widget>[
          Icon(Icons.account_circle),
          Icon(Icons.home),
          Icon(Icons.mail),
          Icon(Icons.phone),
        ],
      ),
      body: Container(
        child: Text('Body'),
      ), //AppBar
    ); //Scaffold();
  }
}
