
import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/screens/doctor/doctor_appointment_page.dart';
import 'package:service_app/screens/doctor/doctor_home_page.dart';
import 'package:service_app/screens/doctor/doctor_personal_page.dart';
import 'package:service_app/screens/fake.dart';

class DoctorBottomNavigatorBar extends StatelessWidget {
   DoctorBottomNavigatorBar({super.key, required this.selectedIndex, required this.onTap,});
  final int selectedIndex;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    
    return  Container(
      height: 70,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        _buildNavItem(Icons.home_outlined, 'Home', 0,
        () => onTap(0)),
        _buildNavItem(Icons.grid_view_rounded, 'Appointment', 1,
       () => onTap(1)),
        
        
        _buildNavItem(Icons.edit_calendar, 'Add slot', 2,
        () => onTap(2)),
        
        // _buildNavItem(Icons.more_horiz, 'More', 3,
        // (){
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //   return FakePage();
        // },)
        // );
        // })
        
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
    child: SizedBox(
      width: 70,
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
    ),
  );
}
  }