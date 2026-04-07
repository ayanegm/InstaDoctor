import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_app/models/appointment_model.dart';

class UserAppointmentSlot extends StatefulWidget {
   UserAppointmentSlot({super.key,required this.appointment});

final AppointmentModel appointment;
  @override
  State<UserAppointmentSlot> createState() => _UserAppointmentSlotState();
}

class _UserAppointmentSlotState extends State<UserAppointmentSlot> {
 
  @override
  Widget build(BuildContext context) {
     bool isExpanded=false;
  String formattedDate = DateFormat('EEEE, d MMM').format(widget.appointment.date);
String formattedTime = DateFormat('hh:mm').format(widget.appointment.time);
String period = widget.appointment.isMorning ? "AM" : "PM";
String time=formattedTime+' '+period;
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded=!isExpanded;
        });
        
      },
      child: Container(
        decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)
        ),

        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children:[Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfoColumn('Date',formattedDate),
        
              buildInfoColumn('Time',time),
        
              buildInfoColumn('Docotr', widget.appointment.doctorName),
              
            ],
          ) ,
        if(isExpanded) ...[
                  SizedBox(height: 20,),
                  Container(height: 1,color: const Color.fromARGB(255, 215, 215, 215),),
                  SizedBox(height: 20,),
                UserAppointmentDetailsSlot(place: 'sdfdf',type: 'heart')
        ]
        ]),
      ),
    );
  }
}
Widget buildInfoColumn(String title,String value){
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(title, style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold,),maxLines: 4,),            ],
    ),
  );
}
class UserAppointmentDetailsSlot extends StatelessWidget {
   UserAppointmentDetailsSlot({super.key,required this.type,required this.place});
String type;
String place;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoColumn('Type', type),
      
          buildInfoColumn('Place',place),
      
          Expanded(
            child: GestureDetector(
              onTap: () {
                
              },
              child: SizedBox(
                width: 60,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                  color: Color(0xFFea5051),
                  borderRadius: BorderRadius.circular(3)
                  ),
                  
                child:Center(child: Text('Cancel',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)) ),
              ),
            ),
          )
      ],),
    );
  }
}