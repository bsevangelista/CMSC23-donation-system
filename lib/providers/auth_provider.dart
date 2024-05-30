import 'package:flutter/material.dart';
import '../api/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthProvider with ChangeNotifier {
  final FirebaseAuthAPI authService = FirebaseAuthAPI();
  late Stream<User?> _uStream;
  String? _userRole;

  UserAuthProvider() {
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
    return await authService.checkUsernameExists(username);
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

  Future<List<Map<String, dynamic>>> getOrganizations() async {
    return await authService.getOrganizations();
  }

  Future<List<Map<String, dynamic>>> getDonations() async {
    return await authService.getDonations();
  }

  Future<List<Map<String, dynamic>>> getDonors() async {
    return await authService.getDonors();
  }

  Future<void> approveOrganization(String orgId) async {
    await authService.approveOrganization(orgId);
    notifyListeners();
  }
}
