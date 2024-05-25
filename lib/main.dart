import 'package:flutter/material.dart';
// import 'authentication/signin_page.dart';
// import 'authentication/signup_page.dart';
import 'donor/donate_page.dart';
import 'donor/donor_homepage.dart';
import 'donor/organization_details.dart';
import 'donor/donation_drive_details.dart';


import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import '/provider/organization_list_provider.dart';
import '/provider/donationDrive_list_provider.dart';

import '/model/donationDrive_model.dart';

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
        ChangeNotifierProvider(create: ((context) => DonationDriveProvider())),
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
      // routes: {
      //   '/third': (context) => DonatePage(),
      //   '/second': (context) => DonationDriveDetails(),
      //   '/': (context) => DonorHomepage(),
      //   // '/': (context) => SignInPage(),
      //   // '/signup': (context) => SignUpPage(),
      //   // '/donate': (context) => DonatePage(),
      // },
      onGenerateRoute: (settings) {
        if (settings.name == "/third"){
          return MaterialPageRoute(
            builder: (context) => DonatePage()
          );
        }

        if (settings.name == "/second"){
          final args = settings.arguments as DonationDrive?;
          return MaterialPageRoute(
            builder: (context) => DonationDriveDetails(
              donationDrive: args,
            )
          );
        }

        if (settings.name == "/"){
          return MaterialPageRoute(
            builder: (context) => DonorHomepage()
          );
        }    
      }
    );
  }
}
