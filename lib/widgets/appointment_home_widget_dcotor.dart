import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/models/appointment_model.dart';

class AppointmentsWidget extends StatelessWidget {
   AppointmentsWidget({super.key,required this.appointmentModel});
AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    String formattedTime=DateFormat('hh:mm').format(appointmentModel.time);
    String period = appointmentModel.isMorning ? "AM" : "PM";
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        // leading: const CircleAvatar(child: Icon(Icons.person)), // صورة الطبيب
        title: FutureBuilder(future:
         FirebaseFirestore.instance.collection('users').doc(appointmentModel.patientId).get(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasData&& snapshot.data!.exists){
              var  userData=snapshot.data!.data() as Map<String,dynamic>;
              return Text(
                userData['name']??'unKnown',
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            }
            return const Text("Patient not found");
          },),
        subtitle: Text("${DateFormat('EEEE, d MMM').format(appointmentModel.date)}",style: TextStyle(fontWeight: FontWeight.bold),),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$formattedTime $period", 
                 style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
            Text(appointmentModel.status,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 13) 
                 ),
          ],
        ),
      ),
    ) ;
  }
}
