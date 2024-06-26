import 'package:ELBIdonate/providers/admin_provider.dart';
import 'package:ELBIdonate/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove back arrow
          title: Text(
            'Admin Dashboard',
            style: TextStyle(color: Colors.white),
          ),
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
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: adminProvider.getOrganizations(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final organizations = snapshot.data!;

            return ListView.builder(
              itemCount: organizations.length,
              itemBuilder: (context, index) {
                final org = organizations[index];
                return ListTile(
                  title: Text(org['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${org['email']}'),
                      // Text('Description: ${org['description']}'),
                    ],
                  ),
                  trailing: (org['approval'] == 'APPROVED')
                      ? Icon(Icons.check, color: Colors.green)
                      : ElevatedButton(
                          onPressed: () {
                            adminProvider.approveOrganization(org['id']);
                          },
                          child: Text('Approve'),
                        ),
                  onTap: () {
                    // Pass org object to _showImage method
                    _showImage(context, org);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void _showImage(BuildContext context, Map<String, dynamic> org) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Proof of Legitimacy"),
          content: Padding(
            padding: EdgeInsets.only(right: 8),
            child: Image.network(
              org['logo'].toString(),
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class DonationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: adminProvider.getDonations(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final donations = snapshot.data!;

            return ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                final donation = donations[index];
                return ListTile(
                  title: Text('Donation ID: ${donation['id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address: ${donation['address']}'),
                      Text('Category: ${donation['category'].join(', ')}'),
                      Text('Contact Number: ${donation['contactNum']}'),
                      Text('Date: ${donation['dateTime']}'),
                      Text('Delivery Mode: ${donation['deliveryMode']}'),
                      Text('Organization ID: ${donation['organization']}'),
                      Text('Status: ${donation['status']}'),
                      Text('User ID: ${donation['user']}'),
                      Text(
                          'Weight: ${donation['weight']} ${donation['weightType']}'),
                    ],
                  ),
                );
              },
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
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: adminProvider.getDonors(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final donors = snapshot.data!;

            return ListView.builder(
              itemCount: donors.length,
              itemBuilder: (context, index) {
                final donor = donors[index];
                return ListTile(
                  title: Text(donor['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address: ${donor['address']}'),
                      Text('Contact Number: ${donor['contactNum']}'),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
