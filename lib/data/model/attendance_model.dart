class Attendance {
  final int id;
  final String employeeId;
  final String employeeName;
  final DateTime date;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String status;

  Attendance({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.date,
    this.checkIn,
    this.checkOut,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'date': date.toIso8601String(),
      'checkIn': checkIn?.toIso8601String(),
      'checkOut': checkOut?.toIso8601String(),
      'status': status,
    };
  }

  // Convert Map to Attendance
  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      employeeId: map['employeeId'],
      employeeName: map['employeeName'],
      date: DateTime.parse(map['date']),
      checkIn: map['checkIn'] != null ? DateTime.parse(map['checkIn']) : null,
      checkOut: map['checkOut'] != null ? DateTime.parse(map['checkOut']) : null,
      status: map['status'],
    );
  }
}
