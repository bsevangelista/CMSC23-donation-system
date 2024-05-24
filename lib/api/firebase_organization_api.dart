import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonations(String organizationId) {
    return db.collection("donations")
        .where("organization", isEqualTo: organizationId)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllDonationDrives(String organizationId) {
    return db.collection("donationDrives")
        .where("organization", isEqualTo: organizationId)
        .snapshots();
  }

  Future<void> updateDonationStatus(String donationId, String newStatus) {
    return db.collection("donations")
        .doc(donationId)
        .update({"status": newStatus});
  }

  Future<String> addDonationDrive(Map<String, dynamic> dDrive) async {
    try {
      await db.collection("donationDrives").add(dDrive);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
