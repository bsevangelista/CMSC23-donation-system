import 'package:flutter/material.dart';
import 'authentication/signin_page.dart';
// import 'authentication/signup_page.dart';
import 'donor/donate_page.dart';
import 'donor/donor_homepage.dart';
import 'donor/organization_details.dart';



import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import '/provider/organization_list_provider.dart';
import '/provider/donation_provider.dart';
import '/model/organization_model.dart';

import 'package:app/provider/auth_provider.dart';

// import '/provider/donationDrive_list_provider.dart';
// import 'donor/donation_drive_details.dart';
// import '/model/donationDrive_model.dart';

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
        ChangeNotifierProvider(create: ((context) => OrganizationProvider())),
        ChangeNotifierProvider(create: ((context) => DonationProvider())),
        ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
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
          final args = settings.arguments as Organization?;
          return MaterialPageRoute(
            builder: (context) => DonatePage(
              organization: args,
            )
          );
        }

        if (settings.name == "/second"){
          final args = settings.arguments as Organization?;
          return MaterialPageRoute(
            builder: (context) => OrganizationDetails(
              organization: args,
            )
          );
        }

        if (settings.name == "/"){
          return MaterialPageRoute(
            builder: (context) => DonorHomepage()
          );
        }

        if (settings.name == "/signin") {
          return MaterialPageRoute(
            builder: (context) => SignInPage()
          );
        }    
      }
    );
  }
}
