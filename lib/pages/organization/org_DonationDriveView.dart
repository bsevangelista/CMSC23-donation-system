import 'package:app/models/donationDrive_model.dart';
import 'package:flutter/material.dart';

class DonationDriveView extends StatefulWidget {
  final DonationDrive dDrive; // Receive Donation instance

  const DonationDriveView(this.dDrive, {super.key});

  @override
  _DonationDriveViewState createState() => _DonationDriveViewState();
}

class _DonationDriveViewState extends State<DonationDriveView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.dDrive.name}",
          style: TextStyle(color: Colors.white),
        ), // Display donation details in the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Display donation details
            Text("Name: ${widget.dDrive.name}"),
            Text("Description: ${widget.dDrive.description}"),
            Text("Donations: ${widget.dDrive.donations?.length ?? 0}"),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
