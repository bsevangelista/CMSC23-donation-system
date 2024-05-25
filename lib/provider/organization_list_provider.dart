import 'package:flutter/material.dart';
// import '/model/organization_model.dart';

import'../api/firebase_organizations_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationProvider with ChangeNotifier {
  late FirebaseOrganizationAPI firebaseService;
  late Stream<QuerySnapshot> _organizationsStream;

  OrganizationProvider() {
    firebaseService = FirebaseOrganizationAPI();
    fetchOrganizations();
  }


  Stream<QuerySnapshot> get organization => _organizationsStream;

  void fetchOrganizations() {
    _organizationsStream = firebaseService.getAllOrganizations();
    notifyListeners();
  }
}