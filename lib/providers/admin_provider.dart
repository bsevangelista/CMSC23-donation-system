import 'package:flutter/material.dart';
import '../api/firebase_admin_api.dart';

class AdminProvider extends ChangeNotifier {
  final FirebaseAdminAPI _firebaseAPI = FirebaseAdminAPI();

  List<String> _imageUrls = [];
  List<String> get imageUrls => _imageUrls;

  Future<void> fetchImages() async {
    try {
      final List<String?> urls = await _firebaseAPI.getImageUrls();
      final List<String> validUrls = urls.where((url) => url != null).cast<String>().toList();
      _imageUrls = validUrls;
      notifyListeners();
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getOrganizations() async {
    return await _firebaseAPI.getOrganizations();
  }

  Future<List<Map<String, dynamic>>> getDonations() async {
    return await _firebaseAPI.getDonations();
  }

  Future<List<Map<String, dynamic>>> getDonors() async {
    return await _firebaseAPI.getDonors();
  }

  Future<void> approveOrganization(String orgId) async {
    await _firebaseAPI.approveOrganization(orgId);
    notifyListeners();
  }
}
