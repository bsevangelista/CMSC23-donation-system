import 'dart:io';

import 'package:app/providers/organization_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddDonationDrive extends StatefulWidget {
  const AddDonationDrive({super.key});

  @override
  State<AddDonationDrive> createState() => _addDonationDriveState();
}

class _addDonationDriveState extends State<AddDonationDrive> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? description;
  String imageUrl = '';
  XFile? imgFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Donation Drive",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading,
                  nameField,
                  descriptionField,
                  uploadButton,
                  SizedBox(height: 20),
                  submitButton
                ],
              ),
            )),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Donation Drive",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );

  Widget get nameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Donation Drive Name',
            hintText: 'Enter donation drive name',
          ),
          onSaved: (value) => setState(() => name = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Name is required';
            }
            return null;
          },
        ),
      );

  Widget get descriptionField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Description',
            hintText: 'Enter donation drive description',
          ),
          maxLines: 5,
          onSaved: (value) => setState(() => description = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Description is required';
            }
            return null;
          },
        ),
      );

  Widget get submitButton => ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate() && imgFile != null) {
            _formKey.currentState!.save();

            if (imgFile != null) {
              String uniqueFileName =
                  DateTime.now().millisecondsSinceEpoch.toString();
              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages =
                  referenceRoot.child('donationDrives');
              Reference referenceImageToUpload =
                  referenceDirImages.child(uniqueFileName);

              try {
                await referenceImageToUpload.putFile(File(imgFile!.path));
                imageUrl = await referenceImageToUpload.getDownloadURL();
              } catch (e) {
                print('Image not uploaded!');
                return;
              }
            }

            if (imageUrl != '') {
              context
                  .read<OrgProvider>()
                  .addDonationDrive(name, description, imageUrl);
            }
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Logo Required!')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        child: const Text("Submit"),
      );

  Widget get uploadButton => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imgFile != null ?
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.file(
                File(imgFile!.path),
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ) :
          Expanded(
            child: Text('Upload Logo'),
          ),
          IconButton(
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();
              XFile? file =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              print('${file?.path}');
              if (file == null) return;
              setState(() {
                imgFile = file;
              });
            },
            icon: Icon(Icons.upload_outlined),
          ),
          
        ],
      );
}
