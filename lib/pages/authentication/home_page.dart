import 'package:app/pages/admin/admin_dashboard.dart';
import 'package:app/pages/authentication/signin_page.dart';
import 'package:app/pages/donor/donor_homepage.dart';
import 'package:app/pages/organization/org_HomePage.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userRole;
  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<UserAuthProvider>().userStream;

    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error encountered! ${snapshot.error}"),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapshot.hasData) {
            return const SignInPage();
          }

          userRole = context.watch<UserAuthProvider>().userRole;
          if (userRole == 'user') {
            return DonorHomepage();
          } else if (userRole == 'org') {
            return OrgHomePage();
          } else if (userRole == 'admin') {
            return AdminDashboard();
          }
          // if user is logged in, display the scaffold containing the streambuilder for the todos
          return const SignInPage();
        });
  }
}