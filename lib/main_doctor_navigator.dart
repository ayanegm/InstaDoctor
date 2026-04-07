import 'package:flutter/material.dart';
import 'package:service_app/screens/doctor/doctor_appointment_page.dart';
import 'package:service_app/screens/doctor/doctor_home_page.dart';
import 'package:service_app/screens/doctor/doctor_personal_page.dart';
import 'package:service_app/screens/home_page.dart';
import 'package:service_app/widgets/doctor_widgets/doctor_bottom_navigator_bar.dart';

class DoctorMainNavigator extends StatefulWidget {
  const DoctorMainNavigator({super.key});

  @override
  State<DoctorMainNavigator> createState() => _DoctorMainNavigatorState();
}

class _DoctorMainNavigatorState extends State<DoctorMainNavigator> {
 
 int _currentIndex=0;
 final List<Widget> _pages=const[
  DoctorHomePage(),
  DoctorAppointmentPage(),
  DoctorPersonalPage(),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: DoctorBottomNavigatorBar(
        
        selectedIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
      ),
    );
  }
}