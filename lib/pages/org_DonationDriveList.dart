// ignore_for_file: prefer_const_constructors

import 'package:app/models/donationDrive_model.dart';
import 'package:app/pages/org_AddDonationDrive.dart';
import 'package:app/pages/org_DonationDriveView.dart';
import 'package:app/providers/organization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDriveList extends StatefulWidget {
  const DonationDriveList({super.key});

  @override
  State<DonationDriveList> createState() => _DonationDriveState();
}

class _DonationDriveState extends State<DonationDriveList> {
  Widget listDonationDrives(BuildContext context) {
    Stream<QuerySnapshot> donationDriveStream =
        context.watch<OrgProvider>().donationDrives;

    return StreamBuilder(
      stream: donationDriveStream,
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

        List<DocumentSnapshot> donationDrives = snapshot.data!.docs;

        if (donationDrives.isEmpty) {
          return Center(
            child: Text(
              'No donation drives yet.',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: donationDrives.length,
          itemBuilder: (BuildContext context, int index) {
            DonationDrive dDrive = DonationDrive.fromJson(
                snapshot.data?.docs[index].data() as Map<String, dynamic>);
            dDrive.id = snapshot.data?.docs[index].id;

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
                                dDrive.name, //fix later
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
                                    builder: (context) =>
                                        DonationDriveView(dDrive),
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
              child: listDonationDrives(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDonationDrive(),
            ),
          );
        },
        backgroundColor: Colors.black, 
        foregroundColor: Colors.white, 
        child: Icon(Icons.add),
        tooltip: 'Add donation drive',
      ),
    );
  }
}
