import 'package:service_app/models/appointment_model.dart';
import 'package:service_app/models/doctor_model.dart';
class UserModel{

  final String name;
  final String email;
  final String uid;
   DoctorModel? doctorModel;
   bool isDoctor;
   List<AppointmentModel> appointmentList;
  UserModel({this.appointmentList=const [],this.isDoctor=false,this.doctorModel,required this.uid, required this.name, required this.email});
  
  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(appointmentList: (map['appointmentList'] != null)
        ? List<AppointmentModel>.from(
            (map['appointmentList'] as List).map(
              (x) => AppointmentModel.fromMap(x as Map<String, dynamic>),
            ),
          )
        : [],isDoctor: map['isDoctor'],name: map['name'],email: map['email'],  uid: map['uid'],doctorModel: DoctorModel.fromMap(map['doctorModel'])
        );

  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'uid':uid,
      'doctorModel':doctorModel?.toMap(),
      'isDoctor':isDoctor,
      'appointmentList':appointmentList.map((x)=>x.toMap()).toList()
    };
  }
}