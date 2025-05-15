import 'package:cloud_firestore/cloud_firestore.dart';

class RewardModel {
  final String id; // ID tự sinh từ Firestore
  final String employeeId; // ID của nhân viên được khen thưởng
  final String employeeName; // Tên nhân viên được khen thưởng
  final String rewardType;
  final Timestamp rewardDate; // Firebase sử dụng Timestamp thay vì DateTime
  final String reason;
  final double rewardValue;
  final String approvedBy;
  final String status;
  final String? document; // Optional, có thể lưu đường dẫn tài liệu

  RewardModel({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.rewardType,
    required this.rewardDate,
    required this.reason,
    required this.rewardValue,
    required this.approvedBy,
    required this.status,
    this.document,
  });

  // Chuyển đổi từ Firebase Firestore Document sang object
  factory RewardModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return RewardModel(
      id: doc.id, // Firebase sẽ tự động gán ID tài liệu
      employeeId: data['employeeId'],
      employeeName: data['employeeName'],
      rewardType: data['rewardType'],
      rewardDate: data['rewardDate'],
      reason: data['reason'],
      rewardValue: data['rewardValue'],
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
      'rewardType': rewardType,
      'rewardDate': rewardDate,
      'reason': reason,
      'rewardValue': rewardValue,
      'approvedBy': approvedBy,
      'status': status,
      'document': document,
    };
  }

  // Hàm copyWith giúp tạo bản sao mới của đối tượng với các thay đổi
  RewardModel copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    String? rewardType,
    Timestamp? rewardDate,
    String? reason,
    double? rewardValue,
    String? approvedBy,
    String? status,
    String? document,
  }) {
    return RewardModel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      rewardType: rewardType ?? this.rewardType,
      rewardDate: rewardDate ?? this.rewardDate,
      reason: reason ?? this.reason,
      rewardValue: rewardValue ?? this.rewardValue,
      approvedBy: approvedBy ?? this.approvedBy,
      status: status ?? this.status,
      document: document ?? this.document,
    );
  }
}
