import 'package:flutter/material.dart';
// import '/model/organization_model.dart';

import'../api/firebase_organizations_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationListProvider with ChangeNotifier {
  late FirebaseOrganizationListAPI firebaseService;
  late Stream<QuerySnapshot> _organizationsStream;

  OrganizationListProvider() {
    firebaseService = FirebaseOrganizationListAPI();
    fetchOrganizations();
  }


  Stream<QuerySnapshot> get organization => _organizationsStream;

  void fetchOrganizations() {
    _organizationsStream = firebaseService.getAllOrganizations();
    notifyListeners();
  }
}