import 'package:app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite, // You can choose any icon from the Icons class
              color: Colors.white,
            ),
            SizedBox(width: 8), // Add some space between the icon and the text
            Text(
              'Elbi Donate',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
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

  Widget get heading => Padding(
    padding: const EdgeInsets.only(bottom: 30),
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
        decoration: InputDecoration(
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
          // Basic email format validation
          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
            return "Please enter a valid email address";
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
        decoration: InputDecoration(
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
          // Minimum password length validation
          if (value.length < 6) {
            return "Password must be at least 6 characters long";
          }
          return null;
        },
      ),
    ),
  );

  Widget get signInErrorMessage => Padding(
    padding: const EdgeInsets.only(bottom: 30),
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
        String? role = await context
          .read<UserAuthProvider>()
          .signIn(email!, password!);

        setState(() {
          showSignInErrorMessage = role == null || role.isEmpty || role == 'unknown';
        });

        if (!showSignInErrorMessage) {
          // Navigate based on role
          if (role == 'admin') {
            Navigator.pushNamed(context, '/admin_dashboard');
          } else if (role == 'user') {
            Navigator.pushNamed(context, '/donorhomepage');
          } else if (role == 'org') {
            Navigator.pushNamed(context, '/org_homepage');
          } else {
            setState(() {
              showSignInErrorMessage = true;
            });
          }
        }
      }
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
    ),
    child: Text(
      "Sign In",
      style: TextStyle(color: Colors.white),
    ),
  );

  Widget get signUpButton => Padding(
    padding: const EdgeInsets.all(30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No account yet?",
          style: TextStyle(color: Colors.grey[500]),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.grey[700]),
          ),
        )
      ],
    ),
  );
}
