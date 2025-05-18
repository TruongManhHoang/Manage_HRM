import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final String id;
  final String userId;
  final String? userName;
  final DateTime date;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String? workLocation;
  final String? notes;
  final bool isLate;
  final bool isAbsent;
  final DateTime createdAt;
  final DateTime updatedAt;

  AttendanceModel({
    required this.id,
    required this.userId,
    this.userName,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
    this.workLocation,
    this.notes,
    this.isLate = false,
    this.isAbsent = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      date: (json['date'] as Timestamp).toDate(),
      checkInTime: json['checkInTime'] != null
          ? (json['checkInTime'] as Timestamp).toDate()
          : null,
      checkOutTime: json['checkOutTime'] != null
          ? (json['checkOutTime'] as Timestamp).toDate()
          : null,
      workLocation: json['workLocation'],
      notes: json['notes'],
      isLate: json['isLate'] ?? false,
      isAbsent: json['isAbsent'] ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'date': Timestamp.fromDate(date),
      'checkInTime':
          checkInTime != null ? Timestamp.fromDate(checkInTime!) : null,
      'checkOutTime':
          checkOutTime != null ? Timestamp.fromDate(checkOutTime!) : null,
      'workLocation': workLocation,
      'notes': notes,
      'isLate': isLate,
      'isAbsent': isAbsent,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  AttendanceModel copyWith({
    String? id,
    String? userId,
    String? userName,
    DateTime? date,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    String? workLocation,
    String? notes,
    bool? isLate,
    bool? isAbsent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      date: date ?? this.date,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      workLocation: workLocation ?? this.workLocation,
      notes: notes ?? this.notes,
      isLate: isLate ?? this.isLate,
      isAbsent: isAbsent ?? this.isAbsent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
