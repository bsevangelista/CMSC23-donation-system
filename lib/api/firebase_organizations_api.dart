import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOpenOrganizationAPI{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getOpenOrganizations() {
    // return db.collection("organizations").snapshots();
    return db.collection("organizations").where("status",isEqualTo: "OPEN").snapshots();

    //pang check lang if tama donor view pag wala pang organization open for donation
    // return db.collection("organizations").where("status",isEqualTo: "asdcszd").snapshots();
  }
}

class FirebaseAllOrganizationAPI{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllOrganizations() {
    return db.collection("organizations").snapshots();
  }
}





// class FirebaseDonationOrganizationAPI{
//   static final FirebaseFirestore db = FirebaseFirestore.instance;

//   Stream<QuerySnapshot> getDonationOrganization() {
//     return db.collection("organizations").where("status",isEqualTo: "OPEN").snapshots();
//   }
// }