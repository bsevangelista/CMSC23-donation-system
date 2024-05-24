import 'package:app/models/donation_model.dart';
import 'package:app/providers/organization_provider.dart';
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
  late String update;
  bool isStatusChanged = false; // Track if the status has changed

  void _statusChange(String newStatus) {
    setState(() {
      if (widget.donation.status == newStatus){
        isStatusChanged = false;
      } else {
        isStatusChanged = true; 
      }
    });
  }

  void _saveChanges() {
    final orgListProvider = Provider.of<OrgListProvider>(context, listen: false);
    orgListProvider.updateDonationStatus(widget.donation.id!, update);
    setState(() {
      isStatusChanged = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Details', style: TextStyle(color: Colors.white),), // Display donation details in the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display donation details
            Text("Category: ${widget.donation.category.join(', ')}"),
            Text("Delivery Mode: ${widget.donation.deliveryMode}"),
            Text("Weight: ${widget.donation.weight} kg"),
            Text("Date: ${DateFormat().format(widget.donation.dateTime)}"),
            if (widget.donation.address.isNotEmpty)
              Text("Address: ${widget.donation.address.join(', ')}"),
            if (widget.donation.contactNum.isNotEmpty)
              Text("Contact Number: ${widget.donation.contactNum}"),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: widget.donation.status,
              items: ["Pending", "Confirmed", "Scheduled for Pick-up", "Complete", "Canceled"]
                  .map((String value) {
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
          ],
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