import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationAPI{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonation(Map<String, dynamic> donation) async {
    try {
      await db.collection("donations").add(donation);
      return "Donated successfully";
    } on FirebaseException catch(e) {
      return "Error at ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonations() {
return db.collection("donations").snapshots();
  }
}