import 'package:app/api/firebase_organization_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrgListProvider with ChangeNotifier {
  FirebaseOrgAPI firebaseService = FirebaseOrgAPI();
  late Stream<QuerySnapshot> _donationsStream;

  OrgListProvider(String organizationId) {
    fetchDonations(organizationId);
  }
  // getter
  Stream<QuerySnapshot> get donations => _donationsStream;

  void fetchDonations(String organizationId) {
    _donationsStream = firebaseService.getAllDonations(organizationId);
    notifyListeners();
  }
}
