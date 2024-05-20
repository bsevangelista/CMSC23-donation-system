import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrgSignUp extends StatefulWidget {
  const OrgSignUp({super.key});

  @override
  _OrgSignUpState createState() => _OrgSignUpState();
}

class _OrgSignUpState extends State<OrgSignUp> {
  final _formKey = GlobalKey<FormState>();
  String? organizationName;
  String? email;
  String? description;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20.0),
                organizationNameField,
                SizedBox(height: 20.0),
                emailField,
                SizedBox(height: 20.0),
                descriptionField,
                SizedBox(height: 20.0),
                passwordField,
                SizedBox(height: 20.0),
                Text(
                  'Upload Proof(s) of Legitimacy',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement file upload functionality here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload), // Upload symbol
                      SizedBox(width: 8.0),
                      Text('Upload Files', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                submitButton,
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    // Navigate back to sign-in page
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text('Already have an account? Sign In', style: TextStyle(color: Colors.grey[500])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get organizationNameField => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Organization Name',
            prefixIcon: Icon(Icons.person),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          ),
          onSaved: (value) => organizationName = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Organization Name is required';
            }
            return null;
          },
        ),
      );

  Widget get emailField => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          ),
          onSaved: (value) => email = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid email address';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      );

  Widget get descriptionField => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Description',
            prefixIcon: Icon(Icons.description),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          ),
          onSaved: (value) => description = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Description is required';
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          ),
          obscureText: true,
          onSaved: (value) => password = value,
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
      );

  Widget get submitButton => ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            try {
              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email!.trim(),
                password: password!,
              );

              // Save additional user information to Firestore
              await FirebaseFirestore.instance.collection('organizations').doc(userCredential.user!.uid).set({
                'approval': 'PENDING',
                'name': organizationName,
                'email': email,
                'description': description,
                'status': 'OPEN',
              });

              // Navigate to the next screen after successful sign-up
              Navigator.pushNamed(context, '/admin_dashboard');
            } catch (e) {
              // Handle sign-up errors
              print('Sign-up error: $e');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Failed to sign up. Please try again.'),
              ));
            }
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
        child: Text('Sign Up', style: TextStyle(color: Colors.white)),
      );
}
