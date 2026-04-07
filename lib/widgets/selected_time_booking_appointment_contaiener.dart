
import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';

class SelectedTimeBookingAppointmentContaiener extends StatelessWidget {
   SelectedTimeBookingAppointmentContaiener({super.key,required this.isMorning,required this.time,this.isSelected=false});
final String time;
final bool isSelected;
final bool isMorning;
  @override
  Widget build(BuildContext context) {
    return Container(
  
      decoration: BoxDecoration(
        color: appColor,
        border: Border.all(color: const Color.fromARGB(255, 171, 171, 171),width: 1.4),

        borderRadius: BorderRadius.circular(4)
      ),
      child: Center(
       child:  Text("$time ${isMorning ? 'AM' : 'PM'}",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.white
        ),)
      ),
    );
  }
}