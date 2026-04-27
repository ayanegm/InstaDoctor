import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/services/appointment_service.dart';
import 'package:service_app/models/appointment_model.dart';

class NextAppoitmentCard extends StatefulWidget {
   NextAppoitmentCard({super.key,required this.appointmentModel});
AppointmentModel appointmentModel;

  @override
  State<NextAppoitmentCard> createState() => _NextAppoitmentCardState();
}

class _NextAppoitmentCardState extends State<NextAppoitmentCard> {
  @override
  Widget build(BuildContext context) {
String formattedTime = DateFormat('hh:mm').format(widget.appointmentModel.time);
String period = DateFormat(' a').format(widget.appointmentModel.time);
return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(10)
        ),
      child: Column(children: [

        Padding(
          padding:EdgeInsets.symmetric(vertical: 10),
          child:
           Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(color: Colors.white.withOpacity(0.3), indent: 20, endIndent: 10)),
              Text('Next Appointment',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
              Expanded(child: Divider(color: Colors.white.withOpacity(0.3), indent: 10, endIndent: 20)),
            ],)),
        Padding(
          padding:EdgeInsets.symmetric(vertical: 10),
          child:
           Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              FutureBuilder<DocumentSnapshot>(
                future:FirebaseFirestore.instance.collection('users').doc(widget.appointmentModel.patientId).get() ,
                 builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  String name=snapshot.data!.get('name');
                return Text(name,style: TextStyle(color: Colors.white, fontSize:24,fontWeight: FontWeight.bold));

              },),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$formattedTime ${widget.appointmentModel.isMorning? 'AM' : 'PM'}",style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900
                  ),),
                 
                ],
              ),
              SizedBox(height: 5,),
              Text('Review Consultation',style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w900
                  ),),
                  Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15), // تظليل بسيط للجزء السفلي
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Row(children: [
                Expanded(child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: appColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  )
                  ,onPressed: () async{
                   
                  try{
                    await AppointmentService().updateStatus(
                      appointmentTime:widget.appointmentModel.time ,
                       patientId: widget.appointmentModel.patientId.toString(),
                        doctorId: FirebaseAuth.instance.currentUser!.uid,
                         newStatus: 'cancelled'
                    );
                  }
                  catch(e){
                    throw Exception('Failed to update the appointment');
                  }
                    
                }, child: Text('Cancel',))),
                SizedBox(width: 12),
                Expanded(child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: appColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  )
                  ,onPressed: ()async {
                    try{
                  await AppointmentService().updateStatus(appointmentTime: widget.appointmentModel.time, patientId: widget.appointmentModel.patientId.toString(), doctorId: FirebaseAuth.instance.currentUser!.uid, newStatus: 'completed');
                    }
                    catch(e){
                      throw('the erorr is $e');
                    }
                }, child: Text('Done',))),
                SizedBox(width: 12),
                
              ],),
                  ),
            ],)),    
      ],),
      );
     
  }
}