import 'package:flutter/material.dart';
import '/model/donation_model.dart';

import'../api/firebase_donation_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationProvider with ChangeNotifier{
  late FirebaseDonationAPI firebaseService;
  late Stream<QuerySnapshot> _donationsStream;

  DonationProvider(String user) {
    firebaseService = FirebaseDonationAPI();
    fetchUserDonations(user);
  }

  Stream<QuerySnapshot> get userDonation => _donationsStream;

  void fetchUserDonations(String user) {
    _donationsStream = firebaseService.getUserDonations(user);
    notifyListeners();
  }

  void addDonation(Donation donation) async{
    String message = await firebaseService.addDonation(donation.toJson(donation));
    print(message);
    notifyListeners();
  }

  // void getDonationOrganization(String organization) async{
  //   String message = await firebaseService.getDonationOrganization(organization);
  //   print(message);
  //   notifyListeners();
  // }
}