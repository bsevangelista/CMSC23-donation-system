import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAdminAPI {
  // Fetch list of image URLs from Firebase Storage
  Future<List<String?>> getImageUrls() async {
    try {
      final ListResult result = await FirebaseStorage.instance.ref().listAll();
      return result.items.map((item) => item.fullPath).toList();
    } catch (e) {
      print('Error fetching images: $e');
      return [];
    }
  }

    Future<List<Map<String, dynamic>>> getOrganizations() async {
    final snapshot = await FirebaseFirestore.instance.collection('organizations').get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  Future<List<Map<String, dynamic>>> getDonations() async {
    final snapshot = await FirebaseFirestore.instance.collection('donations').get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  Future<List<Map<String, dynamic>>> getDonors() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  Future<void> approveOrganization(String orgId) async {
    await FirebaseFirestore.instance.collection('organizations').doc(orgId).update({'approval': 'APPROVED'});
  }
}
