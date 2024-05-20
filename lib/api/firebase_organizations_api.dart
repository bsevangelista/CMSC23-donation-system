import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrganizationListAPI{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllOrganizations() {
    return db.collection("organizations").snapshots();
  }
}