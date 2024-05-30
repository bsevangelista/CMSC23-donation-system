import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Organization {
  String? id;
  String name;
  String description;
  String status;
  String approval;
  String email;

  Organization({
    this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.approval,
    required this.email
  });

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      approval: json['approval'],
      email: json['email'],
    );
  }

  factory Organization.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Organization(
      id: snapshot.id,
      name: data['name'],
      description: data['description'],
      status: data['status'],
      approval: data['approval'],
      email: data['email'],
    );
  }

  static List<Organization> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Organization>((dynamic d) => Organization.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Organization org) {
    return {
      'name': org.name,
      'description': org.description,
      'status': org.status,
      'approval': org.approval,
      'email': org.email,
    };
  }
}