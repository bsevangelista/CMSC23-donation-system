import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/firebase_auth_api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> _uStream;
  String? _userRole;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;
  User? get user => authService.getUser();
  String? get userRole => _userRole;

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
    required String email,
  }) async {
    await authService.userSignUp(
      username: username,
      password: password,
      name: name,
      address: address,
      contactNum: contactNum,
      email: email,
    );
    notifyListeners();
  }

  Future<void> orgSignUp({
    required String password,
    required String organizationName,
    required String description,
    required String email,
  }) async {
    await authService.orgSignUp(
      organizationName: organizationName,
      password: password,
      email: email,
      description: description,
    );
    notifyListeners();
  }

  Future<String?> signIn(String email, String password) async {
    String? role = await authService.signIn(email, password);
    if (role != null && role.isNotEmpty && role != 'unknown') {
      _userRole = role;
    }
    notifyListeners();
    return role;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
