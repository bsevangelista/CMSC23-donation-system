import 'package:flutter/material.dart';
import '../models/donation_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import'../api/firebase_donation_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationProvider with ChangeNotifier{
  late FirebaseDonationAPI firebaseService;
  late Stream<QuerySnapshot> _donationsStream;
  User? user = FirebaseAuth.instance.currentUser;
  late Future<DocumentSnapshot> _userInfoFuture;

  DonationProvider() {
    firebaseService = FirebaseDonationAPI();
    fetchUserDonations(user!.uid);
    fetchUserInfo(user!.uid);
  }

  Stream<QuerySnapshot> get userDonation => _donationsStream;
  Future<DocumentSnapshot> get userInfoFuture => _userInfoFuture;


  void fetchUserDonations(String user) {
    _donationsStream = firebaseService.getUserDonations(user);
    notifyListeners();
  }

  void fetchUserInfo(String user) {
    _userInfoFuture = firebaseService.getUserInfo(user);
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