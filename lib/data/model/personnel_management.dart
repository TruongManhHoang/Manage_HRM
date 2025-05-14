// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonnelManagement {
  String? id;
  String name;
  String dateOfBirth;
  String gender;
  String? position;
  String department;
  String address;
  String phone;
  String email;
  String experience;
  String date;
  String? status;
  DateTime? timeCreated = DateTime.now();
  PersonnelManagement({
    this.id = "",
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    this.position = "Nhân viên",
    required this.department,
    required this.address,
    required this.phone,
    required this.email,
    required this.experience,
    required this.date,
    this.status = "Đang làm việc",
    this.timeCreated ,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'position': position,
      'department': department,
      'address': address,
      'phone': phone,
      'email': email,
      'experience': experience,
      'date': date,
      'status': status,
      'timeCreated': timeCreated,
    };
  }

  factory PersonnelManagement.fromMap(String id, Map<String, dynamic> map) {
    return PersonnelManagement(
      id: map['id'] as String,
      name: map['name'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      gender: map['gender'] as String,
      position: map['position'] as String,
      department: map['department'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      experience: map['experience'] as String,
      date: map['date'] as String,
      status: map['status'] as String,
      timeCreated: map['timeCreated'] ?? DateTime.now(),
    );
  }
}
