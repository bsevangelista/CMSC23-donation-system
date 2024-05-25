import 'package:app/api/firebase_organization_api.dart';
import 'package:app/models/donationDrive_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrgProvider with ChangeNotifier {
  FirebaseOrgAPI firebaseService = FirebaseOrgAPI();
  late Stream<QuerySnapshot> _donationsStream;
  late Stream<QuerySnapshot> _donationDriveStream;

  // remove parameter if auth is implemented
  OrgProvider(String organizationId) {
    fetchDonations(organizationId);
    fetchDonationDrives(organizationId);
  }
  // getter
  Stream<QuerySnapshot> get donations => _donationsStream;
  Stream<QuerySnapshot> get donationDrives => _donationDriveStream;

  // remove parameter if auth is implemented
  void fetchDonations(String organizationId) { 

    // User? user = FirebaseAuth.instance.currentUser;
    // String? orgId = user?.uid;

    _donationsStream = firebaseService.getAllDonations(organizationId);
    notifyListeners();
  }

  void fetchDonationDrives(String organizationId) { 

    // User? user = FirebaseAuth.instance.currentUser;
    // String? orgId = user?.uid;

    _donationDriveStream = firebaseService.getAllDonationDrives(organizationId);
    notifyListeners();
  }

  void updateDonationStatus(String donationId, String newStatus) {
    firebaseService.updateDonationStatus(donationId, newStatus);
  }

  void addDonationDrive(String? name, String? description) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? orgId = user?.uid;

    DonationDrive dDrive = DonationDrive(
        name: name!, description: description!, organization: orgId, donations: []);

    String message =
      await firebaseService.addDonationDrive(dDrive.toJson(dDrive));
    print(message);
    notifyListeners();
  }

  // // uncomment if auth is implemented
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
