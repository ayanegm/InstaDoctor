import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';

class TimeBookingAppointmentContainer extends StatelessWidget {
   TimeBookingAppointmentContainer({super.key,required this.status,required this.isMorning,required this.time,this.isSelected=false});
final String time;
final bool isSelected;
final bool isMorning;
final String status;
  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    BoxBorder border;
bool isUnavailable = status == 'booked' || status == 'completed' || status == 'cancelled';
    if (isUnavailable) {
      backgroundColor = Colors.grey.shade200;
      textColor = Colors.grey;
      border = Border.all(color: Colors.grey.shade300, width: 1.4);
    } else if (isSelected) {
      backgroundColor = appColor; // اللون الأساسي للتطبيق عند الاختيار
      textColor = Colors.white;
      border = Border.all(color: appColor, width: 1.4);
    } else {
      backgroundColor = Colors.white;
      textColor = appColor;
      border = Border.all(color: const Color.fromARGB(255, 171, 171, 171), width: 1.4);
    }
    return Container(
  
       decoration: BoxDecoration(
        color: backgroundColor,
        border: border,
        borderRadius: BorderRadius.circular(4),
      
      ),
      child: Center(
       child:  Text("$time ${isMorning ? 'AM' : 'PM'}",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
color: isUnavailable ? Colors.grey : appColor,
decoration: isUnavailable ? TextDecoration.lineThrough : null,
        ),)
      ),
    );
  }
}