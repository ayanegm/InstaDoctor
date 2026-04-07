import 'package:flutter/material.dart';
import 'package:service_app/widgets/custom_search_bar.dart';
import 'package:service_app/widgets/doctor_widgets/doctor_container.dart';

class DoctorSelectionPage extends StatelessWidget {
  const DoctorSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          CustomSearchBar(),
          SizedBox(height: 23,),
           Expanded(
             child: ListView.builder(itemBuilder: (context, index) {
               return DoctorContainer();
              },itemCount: 10,
              shrinkWrap: true,),
           ),
          
        ],),
      ),
    );
  }
}