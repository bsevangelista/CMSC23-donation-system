
// ignore_for_file: prefer_const_constructors



import 'package:app/firebase_options.dart';
import 'package:app/models/organization_model.dart';
import 'package:app/pages/admin/admin_dashboard.dart';
import 'package:app/pages/authentication/home_page.dart';
import 'package:app/pages/authentication/orgsignup_page.dart';
import 'package:app/pages/authentication/signin_page.dart';
import 'package:app/pages/authentication/signup_page.dart';
import 'package:app/pages/donor/donate_page.dart';
import 'package:app/pages/donor/donor_homepage.dart';
import 'package:app/pages/donor/donor_profile.dart';
import 'package:app/pages/donor/organization_details.dart';
import 'package:app/pages/organization/org_AddDonationDrive.dart';
import 'package:app/pages/organization/org_DonationDriveList.dart';
import 'package:app/pages/organization/org_HomePage.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/donation_provider.dart';
import 'package:app/providers/organization_list_provider.dart';
import 'package:app/providers/organization_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
    ChangeNotifierProvider(create: ((context) => OpenOrganizationProvider())),
    ChangeNotifierProvider(create: ((context) => AllOrganizationProvider())),
    // ChangeNotifierProvider(create: ((context) => DonationProvider())),
    // ChangeNotifierProvider(create: ((context) => DonationProvider(user!.uid))),
    ChangeNotifierProvider(create: ((context) => DonationProvider("bHFOC8lDAKTiXhFhSuPfLPR2Tm42"))),
    ChangeNotifierProvider(create: ((context) => OrgProvider())), 
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
      title: "CMSC Donation App",
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/signup': (context) => const SignUpPage(),
        '/org_signup': (context) => const OrgSignUp(),
        '/admin_dashboard': (context) => AdminDashboard(),
        '/org_homepage': (context) => OrgHomePage(),
        '/org_addDonationDrive': (context) => AddDonationDrive(),
        '/org_donationDriveHomepage': (context) => DonationDriveList(),
        '/donorhomepage': (context) => DonorHomepage(),
        '/donorprofile': (context) => DonorProfile(),
      },
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
      }
    );
  }
}