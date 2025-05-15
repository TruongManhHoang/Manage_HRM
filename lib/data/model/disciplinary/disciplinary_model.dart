import 'package:cloud_firestore/cloud_firestore.dart';

class DisciplinaryModel {
  final String id; // ID tự sinh từ Firestore
  final String employeeId; // ID của nhân viên bị kỷ luật
  final String employeeName; // Tên nhân viên bị kỷ luật
  final String disciplinaryType;
  final Timestamp
      disciplinaryDate; // Firebase sử dụng Timestamp thay vì DateTime
  final String reason;
  final String severity;
  final String approvedBy;
  final String status;
  final String? document; // Optional, có thể lưu đường dẫn tài liệu

  DisciplinaryModel({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.disciplinaryType,
    required this.disciplinaryDate,
    required this.reason,
    required this.severity,
    required this.approvedBy,
    required this.status,
    this.document,
  });

  // Chuyển đổi từ Firebase Firestore Document sang object
  factory DisciplinaryModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return DisciplinaryModel(
      id: doc.id, // Firebase sẽ tự động gán ID tài liệu
      employeeId: data['employeeId'],
      employeeName: data['employeeName'],
      disciplinaryType: data['disciplinaryType'],
      disciplinaryDate: data['disciplinaryDate'],
      reason: data['reason'],
      severity: data['severity'],
      approvedBy: data['approvedBy'],
      status: data['status'],
      document: data['document'],
    );
  }

  // Chuyển đổi từ object sang dữ liệu để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'disciplinaryType': disciplinaryType,
      'disciplinaryDate': disciplinaryDate,
      'reason': reason,
      'severity': severity,
      'approvedBy': approvedBy,
      'status': status,
      'document': document,
    };
  }

  // Hàm copyWith giúp tạo bản sao mới của đối tượng với các thay đổi
  DisciplinaryModel copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    String? disciplinaryType,
    Timestamp? disciplinaryDate,
    String? reason,
    String? severity,
    String? approvedBy,
    String? status,
    String? document,
  }) {
    return DisciplinaryModel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      disciplinaryType: disciplinaryType ?? this.disciplinaryType,
      disciplinaryDate: disciplinaryDate ?? this.disciplinaryDate,
      reason: reason ?? this.reason,
      severity: severity ?? this.severity,
      approvedBy: approvedBy ?? this.approvedBy,
      status: status ?? this.status,
      document: document ?? this.document,
    );
  }
}
