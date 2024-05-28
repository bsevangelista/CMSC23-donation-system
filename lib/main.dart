import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authentication/signin_page.dart';
// import 'authentication/signup_page.dart';
import 'donor/donate_page.dart';
import 'donor/donor_homepage.dart';
import 'donor/donor_profile.dart';
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
  // User? user = FirebaseAuth.instance.currentUser;
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => OpenOrganizationProvider())),

        ChangeNotifierProvider(create: ((context) => AllOrganizationProvider())),
        // ChangeNotifierProvider(create: ((context) => DonationProvider())),
        // ChangeNotifierProvider(create: ((context) => DonationProvider(user!.uid))),
        ChangeNotifierProvider(create: ((context) => DonationProvider("bHFOC8lDAKTiXhFhSuPfLPR2Tm42"))),
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
      initialRoute: '/donorprofile',
      // routes: {
      //   '/third': (context) => DonatePage(),
      //   '/second': (context) => DonationDriveDetails(),
      //   '/': (context) => DonorHomepage(),
      //   // '/': (context) => SignInPage(),
      //   // '/signup': (context) => SignUpPage(),
      //   // '/donate': (context) => DonatePage(),
      // },
      onGenerateRoute: (settings) {
        if (settings.name == "donatepage"){
          final args = settings.arguments as Organization?;
          return MaterialPageRoute(
            builder: (context) => DonatePage(
              organization: args,
            )
          );
        }

        if (settings.name == "/oganizationdetails"){
          final args = settings.arguments as Organization?;
          return MaterialPageRoute(
            builder: (context) => OrganizationDetails(
              organization: args,
            )
          );
        }

        if (settings.name == "/donorhomepage"){
          return MaterialPageRoute(
            builder: (context) => DonorHomepage()
          );
        }

        if (settings.name == "/donorprofile") {
          return MaterialPageRoute(
            builder: (context) => DonorProfile()
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
