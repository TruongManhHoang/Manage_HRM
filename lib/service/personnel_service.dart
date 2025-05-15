import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/model/personnel_management.dart';

class PersonnelService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // This class is responsible for managing personnel data and operations.
  // It will contain methods to add, update, delete, and retrieve personnel information.

  //  method to add a new personnel
  void addPersonnel(PersonnelManagement personnel, BuildContext context) async {
    final String id = firebaseFirestore.collection("personnel").doc().id;
    PersonnelManagement newPersonnel = PersonnelManagement(
      id: id,
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
      await firebaseFirestore
          .collection("personnel")
          .doc(id)
          .set(newPersonnel.toMap());
    } catch (e) {
      print("🔥 Error adding personnel: $e");
    }
  }

  //  method to update existing personnel
  void updatePersonnel(String id, PersonnelManagement personnel) async {
    try {
      await firebaseFirestore
          .collection('personnel')
          .doc(id)
          .update(personnel.toMap());
      print('Update successfully!');
    } catch (e) {
      print('Fail to update!: $e');
    }
  }

  //  method to delete personnel
  void deletePersonnel(String id) async {
    try {
      await firebaseFirestore.collection('personnel').doc(id).delete();
      print('Delete successfully!');
    } catch (e) {
      print('Fail to delete: $e');
    }
  }

  //  method to retrieve all personnel
  Future<List<PersonnelManagement>> getAllPersonnel() async {
    try {
      QuerySnapshot querySnapshot =
          await firebaseFirestore.collection('personnel').get();
      print('Get personnel successfully!');
      return querySnapshot.docs
          .map((doc) => PersonnelManagement.fromMap(
              doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Fail to read: $e');
      return [];
    }
  }
}
