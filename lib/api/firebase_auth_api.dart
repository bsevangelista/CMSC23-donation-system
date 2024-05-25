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

Future<String?> signIn(String email, String password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    
    // Fetch user role
    User? user = auth.currentUser;
    if (user != null) {
      String role = await _fetchUserRole(user.uid);
      return role;
    } else {
      return "User not found";
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-email') {
      return e.message;
    } else if (e.code == 'invalid-credential') {
      return e.message;
    } else {
      return "Failed at ${e.code}: ${e.message}";
    }
  }
}

Future<String> _fetchUserRole(String uid) async {
  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if (userDoc.exists) {
    return 'user';
  }

  DocumentSnapshot orgDoc = await FirebaseFirestore.instance.collection('organizations').doc(uid).get();
  if (orgDoc.exists) {
    return 'org';
  }

  DocumentSnapshot adminDoc = await FirebaseFirestore.instance.collection('admins').doc(uid).get();
  if (adminDoc.exists) {
    return 'admin';
  }

  return 'unknown';
}


Future<void> userSignUp({
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
      'email': email,
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

  Future<void> orgSignUp({
    required String password,
    required String organizationName,
    required String description,
    required String email, // Add email parameter
  }) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, // Use the provided email directly
        password: password,
      );

      // Store additional user information in Firestore
      await FirebaseFirestore.instance.collection('organizations').doc(credential.user!.uid).set({
        'approval': "APPROVED",
        'description' : description,
        'email': email,
        'name': organizationName,
        'status': "OPEN",
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
