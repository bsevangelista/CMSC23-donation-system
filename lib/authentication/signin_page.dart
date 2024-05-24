import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool showSignInErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back arrow
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
                emailField,
                passwordField,
                if (showSignInErrorMessage) signInErrorMessage,
                submitButton,
                signUpButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Center(
          child: Text(
            "Sign In",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            onSaved: (value) => setState(() => email = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              return null;
            },
          ),
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            obscureText: true,
            onSaved: (value) => setState(() => password = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
        ),
      );

  Widget get signInErrorMessage => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Center(
          child: Text(
            "Invalid email or password",
            style: TextStyle(color: Colors.red),
          ),
        ),
      );

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          String? message = await context
              .read<UserAuthProvider>()
              .signIn(email!, password!);

          setState(() {
            showSignInErrorMessage = message != null && message.isNotEmpty;
          });

          if (!showSignInErrorMessage) {
            Navigator.pushNamed(context, '/admin_dashboard');
          }
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
      ),
      child: const Text("Sign In", style: TextStyle(color: Colors.white)),
  );

  Widget get signUpButton => Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No account yet?",
            style: TextStyle(color: Colors.grey[500])),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                },
                child: 
                Text("Sign Up", style: TextStyle(color: Colors.grey[700])))
          ],
        ),
      );
}
