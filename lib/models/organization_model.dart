import 'dart:convert';

class Organization {
  String? id;
  String name;
  String description;
  String status;
  String approval;

  Organization({
    required this.name,
    required this.description,
    required this.status,
    required this.approval,
    this.id,
  });

  // Factory constructor to instantiate object from json format
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      approval: json['approval'],
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
    };
  }
}