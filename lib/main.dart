// ignore_for_file: prefer_const_constructors

import 'package:app/firebase_options.dart';
import 'package:app/pages/organizationHome.dart';
import 'package:app/providers/organization_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/signin_page.dart';
import 'authentication/signup_page.dart';
import 'authentication/orgsignup_page.dart';
import 'providers/auth_provider.dart';
import 'pages/admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => OrgListProvider("PssGUv1edsDRb67AES9l"))), //remove string if auth is implemented
    ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
  ], child: const RootWidget()));
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      
      title: "Organization Name",
      initialRoute: '/',
      routes: {
        '/': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/org_signup': (context) => const OrgSignUp(),
        '/admin_dashboard': (context) => AdminDashboard(),
        '/org_homepage': (context) => OrganizationHomePage(),
      },
    );
  }
}