import 'package:app/api/firebase_organization_api.dart';
import 'package:app/models/donationDrive_model.dart';
import 'package:app/models/donation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrgProvider with ChangeNotifier {
  FirebaseOrgAPI firebaseService = FirebaseOrgAPI();
  late Stream<QuerySnapshot> _donationsStream;
  late Stream<QuerySnapshot> _donationDriveStream;
  late Future<DocumentSnapshot> _organizationFuture;

  // remove parameter if auth is implemented
  OrgProvider(String organizationId) {
    fetchDonations(organizationId);
    fetchDonationDrives(organizationId);
    fetchOrg(organizationId);
  }
  // getter
  Stream<QuerySnapshot> get donations => _donationsStream;
  Stream<QuerySnapshot> get donationDrives => _donationDriveStream;
  Future<DocumentSnapshot> get organizationFuture => _organizationFuture;

  void fetchOrg(String organizationId){
    _organizationFuture = firebaseService.getUserOrg(organizationId);
    notifyListeners();
  }

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
  
  void updateOrganizationStatus(String organizationId, String newStatus) {
    firebaseService.updateOrganizationStatus(organizationId, newStatus);
    notifyListeners();
  }

  void addDonationDrive(String? name, String? description, String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? orgId = user?.uid;

    DonationDrive dDrive = DonationDrive(
        name: name!,
        description: description!,
        organization: orgId,
        donations: [],
        logo: imageUrl);

    String message =
        await firebaseService.addDonationDrive(dDrive.toJson(dDrive));
    print(message);
    notifyListeners();
  }

  void updateDonationDriveDonations(DonationDrive? donoDrive, Donation donation) {
    if (donoDrive != null && donoDrive.id != null) {
      firebaseService.updateDonationDriveDonations(donoDrive.id!, donation.id!);
    } else {
      print('DonationDrive or Donation is null');
    }
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
