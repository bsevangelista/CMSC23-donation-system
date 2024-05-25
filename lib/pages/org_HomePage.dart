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
          title: Text('Home'),
          bottom: TabBar(
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