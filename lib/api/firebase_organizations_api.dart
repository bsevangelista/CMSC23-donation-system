import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrganizationAPI{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getOpenOrganizations() {
    // return db.collection("organizations").snapshots();
    return db.collection("organizations").where("status",isEqualTo: "OPEN").snapshots();
  }
}