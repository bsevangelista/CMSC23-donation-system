// SignUpPage.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../api/firebase_auth_api.dart';
//import 'package:provider/provider.dart';
//import '../providers/auth_provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController(); // Add email controller
    final TextEditingController addressController = TextEditingController();
    final TextEditingController contactNumberController = TextEditingController();

    Future<void> signUp() async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        // Save additional user information to Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'email': emailController.text.trim(),
          'name': nameController.text,
          'username': usernameController.text,
          'address': addressController.text,
          'contactNum': contactNumberController.text,
        });

        // Navigate to next screen after successful sign-up
        Navigator.pushNamed(context, '/');
      } catch (e) {
        // Handle sign-up errors
        print('Sign-up error: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to sign up. Please try again.'),
        ));
        return; // Exit the function if an error occurs
      }
    }


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: emailController, // Add email field
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.home),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: contactNumberController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: signUp,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text('Create Account', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  // Navigate to sign-in page
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Already have an account? Sign In', style: TextStyle(color: Colors.grey[500])),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to organization sign-up page
                  Navigator.pushNamed(context, '/org_signup');
                },
                child: Text('Signing up as an organization?', style: TextStyle(color: Colors.grey[500])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
