import 'package:flutter/material.dart';
import 'package:service_app/widgets/appointment_containers.dart';
import 'package:service_app/widgets/appointment_toggle.dart';
import 'package:service_app/widgets/bottom_navigator_bar.dart';

class MyAppointmentsPage extends StatelessWidget {
  const MyAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:13.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppointmentToggle(),
              SizedBox(height: 10,),
              Text('16 October 2020',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: ListView.builder(itemBuilder: (context, index) {
                  return AppointmentContainers();
                },itemCount: 5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}