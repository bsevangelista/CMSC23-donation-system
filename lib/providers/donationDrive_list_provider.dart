import 'package:flutter/material.dart';

import'../api/firebase_donationDrives_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationDriveProvider with ChangeNotifier {
  late FirebaseDonationDrivesAPI firebaseService;
  late Stream<QuerySnapshot> _donationDrivesStream;

  DonationDriveProvider() {
    firebaseService = FirebaseDonationDrivesAPI();
    fetchDonationDrives();
  }


  Stream<QuerySnapshot> get donationDrive => _donationDrivesStream;

  void fetchDonationDrives() {
    _donationDrivesStream = firebaseService.getAllDonationDrives();
    notifyListeners();
  }
}