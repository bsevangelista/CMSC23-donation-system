import 'package:app/providers/organization_provider.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // drawer: Drawer(),
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
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          context.read<OrgProvider>().addDonationDrive(name, description);
          Navigator.pop(context);
        }
      },
      child: const Text("Submit"));
}
