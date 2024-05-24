import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DonationDrive {
  String? id;
  String name;
  String description;
  List<String>? donations;
  String? organization;

  DonationDrive({
    this.id,
    required this.name,
    required this.description,
    this.donations,
    this.organization,
  });

  // Factory constructor to instantiate object from json format
  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      donations: List<String>.from(json['donations']),
      organization: json['organization'],
    );
  }

  static List<DonationDrive> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<DonationDrive>((dynamic d) => DonationDrive.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(DonationDrive drive) {
    return {
      'name': drive.name,
      'description': drive.description,
      'donations': drive.donations,
      'organization': drive.organization,
    };
  }
}