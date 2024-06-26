// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:ELBIdonate/providers/auth_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class OrgSignUp extends StatefulWidget {
  const OrgSignUp({Key? key}) : super(key: key);

  @override
  _OrgSignUpState createState() => _OrgSignUpState();
}

class _OrgSignUpState extends State<OrgSignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showSignUpErrorMessage = false;
  String errorMessage = '';
  String imageUrl = '';
  XFile? imgFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.volunteer_activism,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Elbi Donate',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                heading,
                organizationNameField,
                emailField,
                descriptionField,
                passwordField,
                uploadFileWidget,
                if (showSignUpErrorMessage) signUpErrorMessage,
                submitButton,
                signInButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Center(
          child: Text(
            "Sign Up",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      );

  Widget get organizationNameField => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            controller: organizationNameController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Organization Name',
              prefixIcon: Icon(Icons.person),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Organization Name is required';
              }
              return null;
            },
          ),
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid email address';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
        ),
      );

  Widget get descriptionField => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Description',
              prefixIcon: Icon(Icons.description),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Description is required';
              }
              return null;
            },
          ),
        ),
      );

  Widget get uploadFileWidget => Padding(
        padding: const EdgeInsets.only(bottom: 40, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Proof/s of Legitimacy',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: [
                imgFile != null ? Text(imgFile!.path) : Container(),
                SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    print('${file?.path}');
                    if (file == null) return;
                    setState(() {
                      imgFile = file;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.upload_outlined, color: Colors.grey[200]),
                        SizedBox(width: 10),
                        Text(
                          "Upload Logo",
                          style: TextStyle(color: Colors.grey[200]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ),
      );

  Widget get signUpErrorMessage => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );

  Widget get submitButton => ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate() && imgFile != null) {
            _formKey.currentState!.save();

            try {
              if (imgFile != null) {
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages =
                    referenceRoot.child('organizationLogo');
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

              await context.read<UserAuthProvider>().orgSignUp(
                    organizationName: organizationNameController.text.trim(),
                    description: descriptionController.text.trim(),
                    password: passwordController.text.trim(),
                    email: emailController.text.trim(),
                    logo: imageUrl,
                  );

              // Navigate to next screen after successful sign-up
              Navigator.pushNamed(context, '/');
            } catch (e) {
              // Handle sign-up errors
              setState(() {
                showSignUpErrorMessage = true;
                errorMessage = e.toString();
              });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Logo Required!')),
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
        child:
            const Text("Create Account", style: TextStyle(color: Colors.white)),
      );

  Widget get signInButton => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?",
                style: TextStyle(color: Colors.grey[500])),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child:
                    Text("Sign In", style: TextStyle(color: Colors.grey[700])))
          ],
        ),
      );
}
