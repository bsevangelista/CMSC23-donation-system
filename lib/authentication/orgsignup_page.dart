import 'package:flutter/material.dart';

class OrgSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Organization Name',
                  prefixIcon: Icon(Icons.business),
                ),
              ),
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
                child: Text('Upload Files', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Implement sign-up functionality here
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              ),
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
    );
  }
}
