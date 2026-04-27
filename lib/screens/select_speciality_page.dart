import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/screens/doctor_list_screen.dart';
import 'package:service_app/widgets/speciality_card.dart';

class SelectSpecialityPage extends StatelessWidget {
  const SelectSpecialityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor:backgroundColor ,title: Text('Select Speciality',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,          // 2 columns
            crossAxisSpacing: 40,       // Horizontal space
            mainAxisSpacing: 15,        // Vertical space
            childAspectRatio: 1.9,      // Adjust this to make cards taller or wider
          ),
            
          itemBuilder: (context, index) {
            final item=categories[index];
            return GestureDetector(onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) {
                return DoctorListScreen(speciality:item['name'] ,);
              },));
            },
            child: SpecialityCard(name: item['name']!, imagePath: item['image']!));
          },itemCount:categories.length ,
            ),
      ));
  }
}