import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationDrivesAPI{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonationDrives() {
    return db.collection("donationDrives").snapshots();
  }
}