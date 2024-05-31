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

  User? user = FirebaseAuth.instance.currentUser;

  // remove parameter if auth is implemented
  OrgProvider() {
    fetchDonations();
    fetchDonationDrives();
    fetchOrg();
  }
  // getter
  Stream<QuerySnapshot> get donations => _donationsStream;
  Stream<QuerySnapshot> get donationDrives => _donationDriveStream;
  Future<DocumentSnapshot> get organizationFuture => _organizationFuture;

  void fetchOrg(){
    String? organizationId = user?.uid;
    _organizationFuture = firebaseService.getUserOrg(organizationId!);
    notifyListeners();
  }

  // remove parameter if auth is implemented
  void fetchDonations() {
    String? organizationId = user?.uid;
    _donationsStream = firebaseService.getAllDonations(organizationId!);
    notifyListeners();
  }

  void fetchDonationDrives() {
    String? organizationId = user?.uid;
    _donationDriveStream = firebaseService.getAllDonationDrives(organizationId!);
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
        logo: imageUrl,
        );

    String message =
        await firebaseService.addDonationDrive(dDrive.toJson(dDrive));
    print(message);
    notifyListeners();
  }

  void updateDonationDriveDonations(String? selectedDrive, Donation donation) {
    if (selectedDrive != null && selectedDrive.isNotEmpty) {
      firebaseService.updateDonationDriveDonations(selectedDrive, donation.id!);
    } else {
      print('DonationDrive or Donation is null');
    }
  }
  
  void updateProofDonationDrive(String? donationDriveId, String imageUrl){
    if (donationDriveId!.isNotEmpty && imageUrl.isNotEmpty) {
      firebaseService.updateProofDonationDrive(donationDriveId, imageUrl);
    } else {
      print('Error updating proof;');
    }
  }

  void deleteDonationDrive(String? donationDriveId) {
    if (donationDriveId != null && donationDriveId.isNotEmpty) {
      firebaseService.deleteDonationDrive(donationDriveId);
    } else {
      print('Faile to Delete Donation Drive');
    }
  }

  Future<bool> isDonationDriveNameExists(String name) async {
    if (name.isNotEmpty) {
      bool exists = await firebaseService.isDonationDriveNameExists(name);
      return exists;
    } else {
      return false;
    }
  }
}
