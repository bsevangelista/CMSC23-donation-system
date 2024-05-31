import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Donor {
  String? id;
  // String address;
  List<String> address;
  String contactNum;
  String email;
  String name;
  String username;

  Donor({
    this.id,
    required this.address,
    required this.contactNum,
    required this.email,
    required this.name,
    required this.username
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['id'],
      address: List<String>.from(json['address']),
      contactNum: json['contactNum'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
    );
  }

  factory Donor.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Donor(
      id: snapshot.id,
      address: List<String>.from(data['address']),
      contactNum: data['contactNum'],
      email: data['email'], 
      name: data['name'],
      username: data['username'],
    );
  }

  static List<Donor> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donor>((dynamic d) => Donor.fromJson(d)).toList();
  }  

  Map<String, dynamic> toJson(Donor donor) {
    return {
      'address': donor.address,
      'contactNum': donor.contactNum,
      'email': donor.email,
      'name': donor.name,
      'username': donor.username,
    };
  }
}

