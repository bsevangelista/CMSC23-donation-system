import 'package:flutter/material.dart';
// import 'authentication/signin_page.dart';
// import 'authentication/signup_page.dart';
// import 'donor/donate_page.dart';
import 'donor/donor_homepage.dart';


import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import '/provider/organization_list_provider.dart';

// void main() {
//   runApp(MyApp());
// }
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => OrganizationListProvider())),
      ],
      child: MyApp(),
    ),
  );
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
        // '/': (context) => DonatePage(),
        '/': (context) => DonorHomepage(),
        // '/': (context) => SignInPage(),
        // '/signup': (context) => SignUpPage(),
        // '/donate': (context) => DonatePage(),
      },
    );
  }
}
