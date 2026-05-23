
import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/screens/doctor/doctor_appointment_page.dart';
import 'package:service_app/screens/doctor/doctor_home_page.dart';
import 'package:service_app/screens/doctor/doctor_personal_page.dart';
import 'package:service_app/screens/doctor/doctor_weekly_schedule_page.dart';
import 'package:service_app/screens/user_appointment_page.dart';

class DoctorBottomNavigatorBar extends StatelessWidget {
   DoctorBottomNavigatorBar({super.key, required this.selectedIndex,});
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    
    return  Container(
      color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        _buildNavItem(Icons.home_outlined, 'Home', 0,
        (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return DoctorHomePage();
        },)
        );
        }
        ),
        _buildNavItem(Icons.calendar_month_outlined, 'Appointment', 1,
        (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return DoctorAppointmentPage();
        },)
        );
        }),
        _buildNavItem(Icons.add_circle_outline, 'Add', 2,
        (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return DoctorPersonalPage();
        },)
        );
        }),
      
       
        
      ]
      ),
       );
  }
Widget _buildNavItem(IconData icon,String label,int index,VoidCallback onTap){
  bool isSelected =selectedIndex==index;
  Color itemColor=isSelected?appColor:Colors.black;
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      Icon(icon, color: itemColor, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: itemColor,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
    ],),
  );
}
  }