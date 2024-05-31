// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:ELBIdonate/models/donationDrive_model.dart';
import 'package:ELBIdonate/models/donation_model.dart';
import 'package:ELBIdonate/providers/organization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DonationView extends StatefulWidget {
  final Donation donation; // Receive Donation instance

  const DonationView(this.donation, {super.key});

  @override
  _DonationViewState createState() => _DonationViewState();
}

class _DonationViewState extends State<DonationView> {
  late String update = '';
  bool isStatusChanged = false; // Track if the status has changed
  String? selectedDrive;

  void _statusChange(String newStatus) {
    setState(() {
      if (widget.donation.status == newStatus) {
        isStatusChanged = false;
      } else {
        isStatusChanged = true;
      }
    });
  }

  void _saveChanges() {
    final orgListProvider = Provider.of<OrgProvider>(context, listen: false);

    if (widget.donation.status == 'Confirmed' && selectedDrive == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a donation drive.'),
        ),
      );
      return;
    }

    if (selectedDrive != null && selectedDrive!.isNotEmpty) {
      orgListProvider.updateDonationDriveDonations(
          selectedDrive, widget.donation);
      orgListProvider.updateDonationStatus(widget.donation.id!, 'Complete');
    }
    update != ''
        ? orgListProvider.updateDonationStatus(widget.donation.id!, update)
        : null;
    setState(() {
      isStatusChanged = false;
    });
    Navigator.pop(context);
  }

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

        // Extracting names of the donation drives
        List<String> driveNames =
            donationDrives.map((DocumentSnapshot document) {
          DonationDrive dDrive =
              DonationDrive.fromJson(document.data() as Map<String, dynamic>);
          return dDrive.name;
        }).toList();

        return Center(
          child: DropdownButton<String>(
            value: selectedDrive,
            hint: Text('Select a Donation Drive'),
            items: driveNames.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedDrive = newValue;
                isStatusChanged = true;
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donation Details',
          style: TextStyle(color: Colors.white),
        ), // Display donation details in the app bar
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display donation details
              Text("Category: ${widget.donation.category.join(', ')}"),
              Text("Delivery Mode: ${widget.donation.deliveryMode}"),
              Text("Weight: ${widget.donation.weight} kg"),
              Text("Date: ${DateFormat().format(widget.donation.dateTime)}"),
              if (widget.donation.address!.isNotEmpty)
                Text("Address: ${widget.donation.address?.join(', ')}"),
              if (widget.donation.contactNum != null)
                Text("Contact Number: ${widget.donation.contactNum}"),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: [
                  "Pending",
                  "Scheduled for Pick-up",
                  "Confirmed",
                  "Complete",
                  "Canceled"
                ].contains(widget.donation.status)
                    ? widget.donation.status
                    : "Pending",
                items: [
                  "Pending",
                  "Scheduled for Pick-up",
                  "Confirmed",
                  "Complete",
                  "Canceled"
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _statusChange(newValue);
                    update = newValue;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Update Status",
                ),
              ),
              SizedBox(height: 20),
              widget.donation.status == 'Confirmed'
                  ? listDonationDrives(context)
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: isStatusChanged
          ? FloatingActionButton(
              onPressed: _saveChanges,
              child: Icon(Icons.save),
              tooltip: 'Save Changes',
            )
          : null,
    );
  }
}
