import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String? patientId;
  final String doctorName;
  final DateTime time;
  String status;
  final DateTime date;
  final String? description;
  bool isMorning;

  AppointmentModel({
    required this.isMorning,
    this.description,
    required this.id,
    this.patientId,
    required this.doctorName,
    required this.time,
    this.status = 'available',
    required this.date,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      isMorning: map['isMorning'] ?? true,
      id: map['id'] ?? '',
      description: map['description'],
      patientId: map['patientId'],
      doctorName: map['doctorName'] ?? '',
      time: map['time'] != null 
          ? (map['time'] as Timestamp).toDate() 
          : (map['date'] != null ? (map['date'] as Timestamp).toDate() : DateTime.now()),
      status: map['status'] ?? 'available', 
      date: map['date'] != null ? (map['date'] as Timestamp).toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorName': doctorName,
      'status': status,
      'date': Timestamp.fromDate(date),
      'time': Timestamp.fromDate(time),
      'description': description,
      'isMorning': isMorning,
    };
  }
}