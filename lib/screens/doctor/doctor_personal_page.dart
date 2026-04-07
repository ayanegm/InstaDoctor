import 'package:flutter/material.dart';
import 'package:service_app/widgets/doctor_widgets/doctor_bottom_navigator_bar.dart';
import 'package:service_app/widgets/doctor_widgets/horizontal_doctor_appointment_selector.dart';

class DoctorPersonalPage extends StatelessWidget {
  const DoctorPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFecf2fb),
      // bottomNavigationBar: DoctorBottomNavigatorBar(selectedIndex: 2,),
      body:Column(
    mainAxisSize: MainAxisSize.min,
            children: [
          HorizontalDoctorAppointmentSelector(),
          SizedBox(height: 30,),
          
           ]),
    );
  }
}


