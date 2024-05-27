import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/auth_provider.dart';

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
                context.read<UserAuthProvider>().signOut();
                Navigator.pushNamed(context, '/');
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('organizations').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final organizations = snapshot.data!.docs;

        return ListView.builder(
          itemCount: organizations.length,
          itemBuilder: (context, index) {
            final org = organizations[index];
            return ListTile(
              title: Text(org['name']),
              trailing: (org['approval'] == 'APPROVED')
                  ? Icon(Icons.check, color: Colors.green)
                  : ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('organizations')
                            .doc(org.id)
                            .update({'approval': 'APPROVED'});
                      },
                      child: Text('Approve'),
                    ),
            );
          },
        );
      },
    );
  }
}

class DonationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('donations').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final donations = snapshot.data!.docs;

        return ListView.builder(
          itemCount: donations.length,
          itemBuilder: (context, index) {
            final donation = donations[index];
            return ListTile(
              title: Text('Donation ID: ${donation.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address: ${donation['address'] ?? 'null'}'),
                  Text('Category: ${donation['category'].join(', ')}'),
                  Text('Contact Number: ${donation['contactNum']}'),
                  Text('Date: ${donation['dateTime']}'),
                  Text('Delivery Mode: ${donation['deliveryMode']}'),
                  Text('Organization ID: ${donation['organization']}'),
                  Text('Status: ${donation['status']}'),
                  Text('User ID: ${donation['user']}'),
                  Text('Weight: ${donation['weight']} ${donation['weightType']}'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class DonorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('donors').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final donors = snapshot.data!.docs;

        return ListView.builder(
          itemCount: donors.length,
          itemBuilder: (context, index) {
            final donor = donors[index];
            return ListTile(
              title: Text(donor['name']),
            );
          },
        );
      },
    );
  }
}
