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

  Stream<QuerySnapshot> getUserDonations(String user) {
    return db.collection("donations").where("user",isEqualTo: user).snapshots();
  }
  
  //  Stream<QuerySnapshot> getDonationOrganization(String organization) {
  //   return db.collection("organizations").where(snapshot.uid,isEqualTo: organization).snapshots();
  // } 

  Future<DocumentSnapshot> getUserInfo(String user) {
    return db.collection("users").doc(user).get();
  }
}