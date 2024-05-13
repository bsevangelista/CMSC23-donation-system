import 'package:flutter/material.dart';
import 'authentication/signin_page.dart';
import 'authentication/signup_page.dart';
import 'donor/donate_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DonatePage(),
        // '/': (context) => SignInPage(),
        // '/signup': (context) => SignUpPage(),
        // '/donate': (context) => DonatePage(),
      },
    );
  }
}
