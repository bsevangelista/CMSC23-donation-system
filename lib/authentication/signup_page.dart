import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/provider/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  bool showSignUpErrorMessage = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                nameField,
                usernameField,
                emailField,
                passwordField,
                addressField,
                contactNumberField,
                if (showSignUpErrorMessage) signUpErrorMessage,
                submitButton,
                signInButton,
                signInOrgButton,
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

  Widget get nameField => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Name',
              prefixIcon: Icon(Icons.person),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
        ),
      );

  Widget get usernameField => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Username',
              prefixIcon: Icon(Icons.person),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
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
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
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
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ),
      );

  Widget get addressField => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextFormField(
            controller: addressController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Address',
              prefixIcon: Icon(Icons.home),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
        ),
      );

    Widget get contactNumberField => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200],
            ),
            child: TextFormField(
              controller: contactNumberController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Contact Number',
                prefixIcon: Icon(Icons.phone),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your contact number';
                }
                if (!isNumeric(value)) {
                  return 'Please enter a valid contact number';
                }
                return null;
              },
            ),
          ),
        );

    // Helper function to check if a string is numeric
    bool isNumeric(String? value) {
      if (value == null) {
        return false;
      }
      return double.tryParse(value) != null;
    }


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
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          try {
            await context.read<UserAuthProvider>().userSignUp(
              username: usernameController.text,
              name: nameController.text,
              address: addressController.text,
              contactNum: contactNumberController.text,
              password: passwordController.text,
              email: emailController.text,
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
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
      ),
      child: const Text("Create Account", style: TextStyle(color: Colors.white)),
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
                Text("Sign In",
                style: TextStyle(color: Colors.grey[700])))
          ],
        ),
      );

  Widget get signInOrgButton => Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Signing up as an organization?" ,
            style: TextStyle(color: Colors.grey[500])),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/org_signup');
                },
                child: 
                Text("Sign Up", style: TextStyle(color: Colors.grey[700])))
          ],
        ),
      );
}
