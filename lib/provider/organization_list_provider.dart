import 'package:flutter/material.dart';
// import '/model/organization_model.dart';

import'../api/firebase_organizations_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OpenOrganizationProvider with ChangeNotifier {
  late FirebaseOpenOrganizationAPI firebaseService;
  late Stream<QuerySnapshot> _organizationsStream;

  OpenOrganizationProvider() {
    firebaseService = FirebaseOpenOrganizationAPI();
    fetchOpenOrganizations();
  }


  Stream<QuerySnapshot> get openOrganization => _organizationsStream;

  void fetchOpenOrganizations() {
    _organizationsStream = firebaseService.getOpenOrganizations();
    notifyListeners();
  }
}



class AllOrganizationProvider with ChangeNotifier {
  late FirebaseAllOrganizationAPI firebaseService;
  late Stream<QuerySnapshot> _organizationsStream;

  AllOrganizationProvider() {
    firebaseService = FirebaseAllOrganizationAPI();
    fetchAllOrganizations();
  }


  Stream<QuerySnapshot> get organization => _organizationsStream;

  void fetchAllOrganizations() {
    _organizationsStream = firebaseService.getAllOrganizations();
    notifyListeners();
  }
}




// class DonationOrganizationProvider with ChangeNotifier {
//   late FirebaseDonationOrganizationAPI firebaseService;
//   late Stream<QuerySnapshot> _organizationsStream;

//   DonationOrganizationProvider() {
//     firebaseService = FirebaseOpenOrganizationAPI();
//     fetchOpenOrganizations();
//   }


//   Stream<QuerySnapshot> get openOrganization => _organizationsStream;

//   void fetchOpenOrganizations() {
//     _organizationsStream = firebaseService.getDonationOrganizations();
//     notifyListeners();
//   }
// }