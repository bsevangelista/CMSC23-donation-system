// ignore_for_file: prefer_const_constructors


import 'package:app/models/donation_model.dart';
import 'package:app/pages/organization/org_DonationView.dart';
import 'package:app/providers/organization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgDonationList extends StatefulWidget {
  const OrgDonationList({super.key});

  @override
  State<OrgDonationList> createState() => _DonationListState();
}

class _DonationListState extends State<OrgDonationList> {
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              dono.image != null
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Image.network(
                                        '${dono.image}',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(),
                              Expanded(
                                child: Text(
                                  dono.category.join(', '), //fix later
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
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
    );
  }
}