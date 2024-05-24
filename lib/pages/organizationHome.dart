// ignore_for_file: prefer_const_constructors

import 'package:app/models/donation_model.dart';
import 'package:app/pages/donationView.dart';
import 'package:app/providers/organization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationHomePage extends StatefulWidget {
  const OrganizationHomePage({super.key});

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePage();
}

class _OrganizationHomePage extends State<OrganizationHomePage> {
  Widget listDonations(BuildContext context) {
    Stream<QuerySnapshot> donationsStream =
        context.watch<OrgProvider>().donations;

    return StreamBuilder(
      stream: donationsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        List<DocumentSnapshot> donations = snapshot.data!.docs;

        if (donations.isEmpty) {
          return Center(
            child: Text(
              'No donations yet.',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: donations.length,
          itemBuilder: (BuildContext context, int index) {

            Donation dono = Donation.fromJson(
              snapshot.data?.docs[index].data() as Map<String, dynamic>);
            dono.id = snapshot.data?.docs[index].id;

            return Card(
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dono.category.join(', '), //fix later
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DonationView(dono), 
                                  ),
                                );
                              },
                              child: Text(
                                "View",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          "Donation List",
          style: TextStyle(color: Colors.white),
        ),
        
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: listDonations(context),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, "/second");
      //   },
      //   child: Icon(Icons.person),
      // ),
    );
  }
}