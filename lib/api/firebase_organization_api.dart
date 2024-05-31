import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonations(String organizationId) {
    return db
        .collection("donations")
        .where("organization", isEqualTo: organizationId)
        .where("status", whereNotIn: ["Complete", "Cancelled"]).snapshots();
  }

  Stream<QuerySnapshot> getAllDonationDrives(String organizationId) {
    return db
        .collection("donationDrives")
        .where("organization", isEqualTo: organizationId)
        .snapshots();
  }

  Future<void> updateDonationStatus(String donationId, String newStatus) {
    return db
        .collection("donations")
        .doc(donationId)
        .update({"status": newStatus});
  }

  Future<void> updateDonationDriveDonations(String selectedDrive, String donationID) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection("donationDrives")
          .where("name", isEqualTo: selectedDrive)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        DocumentReference documentRef = documentSnapshot.reference;

        await documentRef.update({
          "donations": FieldValue.arrayUnion([donationID])
        });
      } else {
        print('No donation drive found with the specified name.');
      }
    } catch (e) {
      print('Error updating donation drive: $e');
    }
  }

  Future<void> updateOrganizationStatus(String organizationId, String newStatus) {
    return db
        .collection("organizations")
        .doc(organizationId)
        .update({"status": newStatus});
  }

  Future<void> updateProofDonationDrive(String donationDriveId, String imageUrl) async {
  try {
    // Directly update the document with `arrayUnion`
    await db.collection("donationDrives")
        .doc(donationDriveId)
        .update({
          "proof": FieldValue.arrayUnion([imageUrl])
        });
  } catch (e) {
    print('Error updating proof images: $e');
  }
}

  Future<String> addDonationDrive(Map<String, dynamic> dDrive) async {
    try {
      await db.collection("donationDrives").add(dDrive);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<void> deleteDonationDrive(String donationDriveId) async {
    try {
      await db.collection("donationDrives").doc(donationDriveId).delete();
    } catch (e) {
      print('Error deleting donation drive: $e');
      throw e;
    }
  }

  Future<bool> isDonationDriveNameExists(String name) async {
    try {
      var querySnapshot = await db
          .collection("donationDrives")
          .where("name", isEqualTo: name)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking donation drive name existence: $e');
      return false;
    }
  }

  Future<DocumentSnapshot> getUserOrg(String organizationId) {
    return db.collection('organizations').doc(organizationId).get();
  }
}
