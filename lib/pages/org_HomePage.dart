// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/pages/org_DonationDriveList.dart';
import 'package:app/pages/org_DonationList.dart';
import 'package:flutter/material.dart';

class OrgHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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