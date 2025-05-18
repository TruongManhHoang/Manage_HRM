import 'package:admin_hrm/data/model/kpi/kpi_metric/kpi_metric.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KPIModel {
  final String id;
  final String userId;
  final String departmentId;
  final String period;
  final List<KPIMetric> metrics;
  final double totalScore;
  final String? evaluatorId;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  KPIModel({
    required this.id,
    required this.userId,
    required this.departmentId,
    required this.period,
    required this.metrics,
    required this.totalScore,
    this.evaluatorId,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KPIModel.fromJson(Map<String, dynamic> json) {
    return KPIModel(
      id: json['id'],
      userId: json['userId'],
      departmentId: json['departmentId'],
      period: json['period'],
      metrics: (json['metrics'] as List)
          .map((item) => KPIMetric.fromJson(item))
          .toList(),
      totalScore: (json['totalScore'] as num).toDouble(),
      evaluatorId: json['evaluatorId'],
      notes: json['notes'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'departmentId': departmentId,
      'period': period,
      'metrics': metrics.map((e) => e.toJson()).toList(),
      'totalScore': totalScore,
      'evaluatorId': evaluatorId,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
