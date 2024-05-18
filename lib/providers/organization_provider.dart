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


  // remove function if auth is implemented
  void fetchDonations(String organizationId) {
    _donationsStream = firebaseService.getAllDonations(organizationId);
    notifyListeners();
  }

  void updateDonationStatus(String donationId, String newStatus) {
    firebaseService.updateDonationStatus(donationId, newStatus);

  }

  // uncomment if auth is implemented
  // void fetchDonations() async {
  //   // Get the current user's ID
  //   User? user = FirebaseAuth.instance.currentUser;
  //   String? orgId = user?.uid;

  //   if (orgId != null) {
  //     // Fetch donations for the organization (using user ID as organization ID)
  //     _donationsStream = firebaseService.getAllDonations(orgId);
  //     notifyListeners();
  //   }
  // }
}
