import 'dart:io';

import 'package:ELBIdonate/models/donationDrive_model.dart';
import 'package:ELBIdonate/providers/organization_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DonationDriveView extends StatefulWidget {
  final DonationDrive dDrive; // Receive Donation instance

  const DonationDriveView(this.dDrive, {super.key});

  @override
  _DonationDriveViewState createState() => _DonationDriveViewState();
}

class _DonationDriveViewState extends State<DonationDriveView> {
  String imageUrl = '';
  XFile? imgFile;

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this donation drive?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                context
                    .read<OrgProvider>()
                    .deleteDonationDrive(widget.dDrive.id);
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.dDrive.name}",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline_rounded),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
              print(widget.dDrive.id);
            },
          )
        ], // Display donation details in the app bar
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("Description: ${widget.dDrive.description}", style: TextStyle(fontSize: 15) ),
              SizedBox(height: 20),
              Text("Donations: ${widget.dDrive.donations?.length ?? 0}"),
              SizedBox(height: 20),

              widget.dDrive.proof != null
                  ? Center(
                      child: Column(
                      children: [
                        Text("Proof: "),
                        Image.network(
                          '${widget.dDrive.proof}',
                          width: 250,
                          height: 350,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ))
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.dDrive.donations!.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.camera);
                print('${file?.path}');

                if (file == null) return;

                setState(() {
                  imgFile = file;
                });

                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages =
                    referenceRoot.child('donationDriveProof');

                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                try {
                  await referenceImageToUpload.putFile(File(imgFile!.path));
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  if (imageUrl != '') {
                    context
                        .read<OrgProvider>()
                        .updateProofDonationDrive(widget.dDrive.id, imageUrl);
                  }
                  Navigator.of(context).pop();
                } catch (error) {
                  print('Img not uploaded!');
                }
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              child: Icon(Icons.camera_alt_outlined),
              tooltip: 'Add/Edit Proof of Donation',
            )
          : null,
    );
  }
}
