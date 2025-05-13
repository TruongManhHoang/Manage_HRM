import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/model/personnel_management.dart';

class PersonnelService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // This class is responsible for managing personnel data and operations.
  // It will contain methods to add, update, delete, and retrieve personnel information.

  // Example method to add a new personnel
  void addPersonnel(PersonnelManagement personnel, BuildContext context) async {
    PersonnelManagement newPersonnel = PersonnelManagement(
      id: personnel.id,
      name: personnel.name,
      dateOfBirth: personnel.dateOfBirth,
      gender: personnel.gender,
      position: personnel.position,
      department: personnel.department,
      address: personnel.address,
      phone: personnel.phone,
      email: personnel.email,
      experience: personnel.experience,
      date: personnel.date,
      status: personnel.status,
    );
    try {
      if (newPersonnel.name.isEmpty ||
          newPersonnel.dateOfBirth.isEmpty ||
          newPersonnel.email.isEmpty ||
          newPersonnel.phone.isEmpty ||
          newPersonnel.address.isEmpty ||
          newPersonnel.department.isEmpty ||
          newPersonnel.experience.isEmpty ||
          newPersonnel.date.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.yellow,
            content: Text("Lỗi ! Vui lòng nhập đầy đủ thông tin.",
                style: TextStyle(color: Colors.black))));
        return;
      }
      await firebaseFirestore.collection("personnel").add(newPersonnel.toMap());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Thêm thành viên thành công.",
              style: TextStyle(color: Colors.white))));
      Navigator.pop(context);
    } catch (e) {
      print("🔥 Error adding personnel: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Lỗi ! Thêm thành viên không thành công.",
              style: TextStyle(color: Colors.white))));
      Navigator.pop(context);
    }
  }

  // Example method to update existing personnel
  void updatePersonnel(int id, PersonnelManagement personnel) {
    // Code to update personnel
  }

  // Example method to delete personnel
  void deletePersonnel(int id) {
    // Code to delete personnel
  }

  // Example method to retrieve all personnel
  List<String> getAllPersonnel() {
    // Code to retrieve all personnel
    return [];
  }
}
