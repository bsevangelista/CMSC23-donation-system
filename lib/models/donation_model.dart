import 'dart:convert';

class Donation {
  String? id;
  String category;
  String deliveryMode;
  int weight;
  String approval;
  // photo
  DateTime dateTime;
  List<String> address;
  int contactNum;
  String status;
  String organization;
  String user;

  Donation({
    this.id,
    required this.category,
    required this.deliveryMode,
    required this.weight,
    required this.approval,
    required this.dateTime,
    required this.address,
    required this.contactNum,
    required this.status,
    required this.organization,
    required this.user,
  });

  // Factory constructor to instantiate object from json format
  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      category: json['category'],
      deliveryMode: json['deliveryMode'],
      weight: json['weight'],
      approval: json['approval'],
      dateTime: DateTime.parse(json['dateTime']),
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
      'approval': dono.approval,
      'dateTime': dono.dateTime.toIso8601String(),
      'address': dono.address,
      'contactNum': dono.contactNum,
      'status': dono.status,
      'organization': dono.organization,
      'user': dono.user,
    };
  }
}