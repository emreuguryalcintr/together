import 'package:flutter/material.dart';
import 'package:together/constants.dart';
import 'package:together/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Constants.colorAccent
      ),
      home: LoginScreen(),
    );
  }
}
