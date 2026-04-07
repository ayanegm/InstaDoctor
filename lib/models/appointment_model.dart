import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_app/models/doctor_model.dart';

class AppointmentModel {
  final String id;
  final String? patientId;
  final String doctorName;
  final DateTime time;
   String status;
  final DateTime date;
  final String? description;
   bool isMorning=true;
  AppointmentModel({required this.isMorning,this.description,required this.id, this.patientId, required this.doctorName, required this.time, this.status='available', required this.date});
factory AppointmentModel.fromMap(Map<String ,dynamic>map){
  return AppointmentModel(isMorning: map['isMorning'],id: map['id'], description: map['description'],patientId: map['patientId'], doctorName: map['doctorName'], time: (map['time'] as Timestamp).toDate(), status: map['status'],date: (map['date'] as Timestamp).toDate());
}
Map<String ,dynamic>toMap(){
  return {
    'id':id,
    'patientId':patientId,
    'doctorName':doctorName,
    'status':status,
    'date':Timestamp.fromDate(date),
    'time':Timestamp.fromDate(time),
    'description':description,
    'isMorning':isMorning
  };
}
}