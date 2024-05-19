import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  User? getUser() {
    return auth.currentUser;
  }

  Stream<User?> userSignedIn() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String username, String password) async {
    try {
      // Retrieve email from username
      var email = await _getEmailFromUsername(username);
      if (email == null) {
        return "No user found for that username.";
      }

      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Sign in successful, no error message
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    }
  }

Future<void> signUp({
  required String username,
  required String name,
  required String address,
  required String contactNum,
  required String password,
  required String email, // Add email parameter
}) async {
  try {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email, // Use the provided email directly
      password: password,
    );

    // Store additional user information in Firestore
    await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
      'username': username,
      'name': name,
      'address': address,
      'contactNum': contactNum,
      // Add more fields as needed
    });
  } on FirebaseAuthException catch (e) {
    // Handle exceptions
    print(_handleAuthException(e));
  } catch (e) {
    // Handle other errors
    print(e);
  }
}


  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<String?> _getEmailFromUsername(String username) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('usernames').doc(username).get();
      if (snapshot.exists) {
        return snapshot['email'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    } else {
      return 'Authentication failed: ${e.message}';
    }
  }
}
