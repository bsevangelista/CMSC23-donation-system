import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/firebase_auth_api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> _uStream;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;
  User? get user => authService.getUser();

  void fetchAuthentication() {
        _uStream = authService.userSignedIn();
    notifyListeners();
  }

  Future<bool> checkUsernameExists(String username) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle error, e.g., log it or return false
      print('Error checking username: $e');
      return false;
    }
  }

  Future<void> userSignUp({
    required String username,
    required String password,
    required String name,
    required String address,
    required String contactNum,
    required String email, // Add email parameter
  }) async {
    await authService.userSignUp(
      username: username,
      password: password,
      name: name,
      address: address,
      contactNum: contactNum,
      email: email, // Pass email to the sign-up method
    );
    notifyListeners();
  }

    Future<void> orgSignUp({
    required String password,
    required String organizationName,
    required String description,
    required String email, // Add email parameter
  }) async {
    await authService.orgSignUp(
      organizationName: organizationName,
      password: password,
      email: email,
      description: description, // Pass email to the sign-up method
    );
    notifyListeners();
  }


  Future<String?> signIn(String username, String password) async {
    String? message = await authService.signIn(username, password);
    notifyListeners();

    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}