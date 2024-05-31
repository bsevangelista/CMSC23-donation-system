// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:app/pages/organization/org_AboutPage.dart';
import 'package:app/pages/organization/org_DonationDriveList.dart';
import 'package:app/pages/organization/org_DonationList.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? orgId = user?.uid;

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove the back button
          title: Text('Organization View', style: TextStyle(color: Colors.white),),
          bottom: TabBar(
            indicatorColor: Colors.blue, // Change the indicator color
            labelColor: Colors.white, // Change the selected label color
            unselectedLabelColor: Colors.grey, // Change the unselected label color
            tabs: [
              Tab(text: 'Donations'),
              Tab(text: 'Donation Drive'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrgAboutPage(orgId!)),
                );
                print(orgId);
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              onPressed: () {
                context.read<UserAuthProvider>().signOut();
                Navigator.pop(context);
                Navigator.pushNamed(context, "/");
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            OrgDonationList(),
            DonationDriveList(),
          ],
        ),
      ),
    );
  }
}