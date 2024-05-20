import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/firebase_auth_api.dart'; 

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove back arrow
          title: Text('Admin Dashboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                //Provider.of<FirebaseAuthAPI>(context, listen: false).signOut();
                Navigator.pushNamed(context, '/');
                // Implement sign-out logic here
                // For example, you can call a sign-out function from your authentication provider
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Organizations'),
              Tab(text: 'Donations'),
              Tab(text: 'Donors'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrganizationsView(),
            DonationsView(),
            DonorsView(),
          ],
        ),
      ),
    );
  }
}

class OrganizationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for organizations
    final List<Map<String, dynamic>> organizations = [
      {'name': 'Org 1', 'isApproved': false},
      {'name': 'Org 2', 'isApproved': true},
      {'name': 'Org 3', 'isApproved': false},
    ];

    return ListView.builder(
      itemCount: organizations.length,
      itemBuilder: (context, index) {
        final org = organizations[index];
        return ListTile(
          title: Text(org['name'] as String),
          trailing: (org['isApproved'] as bool)
              ? Icon(Icons.check, color: Colors.green)
              : ElevatedButton(
                  onPressed: () {
                    // Dummy approve action
                    organizations[index]['isApproved'] = true;
                  },
                  child: Text('Approve'),
                ),
        );
      },
    );
  }
}

class DonationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for donations
    final List<Map<String, dynamic>> donations = [
      {'id': '1', 'amount': 100.0},
      {'id': '2', 'amount': 200.0},
      {'id': '3', 'amount': 300.0},
    ];

    return ListView.builder(
      itemCount: donations.length,
      itemBuilder: (context, index) {
        final donation = donations[index];
        return ListTile(
          title: Text('Donation ID: ${donation['id']}'),
          subtitle: Text('Amount: \$${donation['amount']}'),
        );
      },
    );
  }
}

class DonorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for donors
    final List<Map<String, dynamic>> donors = [
      {'name': 'Donor 1'},
      {'name': 'Donor 2'},
      {'name': 'Donor 3'},
    ];

    return ListView.builder(
      itemCount: donors.length,
      itemBuilder: (context, index) {
        final donor = donors[index];
        return ListTile(
          title: Text(donor['name'] as String),
        );
      },
    );
  }
}
