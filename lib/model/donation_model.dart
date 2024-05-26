import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  String? id;
  List<String> category;
  String deliveryMode;
  double weight;
  String weightType;
  // photo
  // qr
  DateTime dateTime;
  List<String>? address;
  String? contactNum;
  String status;
  String organization;
  String user;

  Donation({
    this.id,
    required this.category,
    required this.deliveryMode,
    required this.weight,
    required this.weightType,
    // photo
    // qr
    required this.dateTime,
    this.address,
    this.contactNum,
    required this.status,
    required this.organization,
    required this.user,
  });

  // Factory constructor to instantiate object from json format
  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      category: List<String>.from(json['category']),
      deliveryMode: json['deliveryMode'],
      weight: json['weight'],
      weightType: json['weightType'],
      // photo
      // qr
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      address: List<String>.from(json['address']),
      contactNum: json['contactNum'],
      status: json['status'],
      organization: json['organization'],
      user: json['user'],
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation dono) {
    return {
      'category': dono.category,
      'deliveryMode': dono.deliveryMode,
      'weight': dono.weight,
      'weightType': dono.weightType,
      // photo
      // qr
      'dateTime': dono.dateTime.toIso8601String(),
      'address': dono.address,
      'contactNum': dono.contactNum,
      'status': dono.status,
      'organization': dono.organization,
      'user': dono.user,
    };
  }
}