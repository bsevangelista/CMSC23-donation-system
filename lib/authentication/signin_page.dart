import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart'; // Import Provider if needed

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> signIn() async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(), // Use email for sign-in
          password: passwordController.text,
        );

       Navigator.pushNamed(context, '/signup');
        // Handle sign-in success, navigate to next screen, or update UI accordingly
      } catch (e) {
        // Handle sign-in errors
        print('Sign-in error: $e');
        // Show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to sign in. Please try again.'),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            Center(
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
              ),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: signIn, // Call the signIn function
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: Text('Sign In', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                // Navigate to sign-up page
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Don\'t have an account? Sign Up', style: TextStyle(color: Colors.grey[500])),
            ),
          ],
        ),
      ),
    );
  }
}
