import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/doctor_list_screen.dart';
import 'package:service_app/screens/select_speciality_page.dart';
import 'package:service_app/widgets/available_doctor_container.dart';
import 'package:service_app/widgets/bottom_navigator_bar.dart';
import 'package:service_app/widgets/icon_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: CustomBottomNavigatorBar(selectedIndex: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:23.0,vertical: 23),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Hi, Mohsen Jamli',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
            Text('How are you today',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Color.fromARGB(255, 125, 125, 125),)),
            SizedBox(height: 19,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Doctor Speciality',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SelectSpecialityPage();
                  },));
                },
                child: Text('See all',style: TextStyle(fontSize: 14,color: appColor,fontWeight: FontWeight.bold),)),
              
            ],),
            SizedBox(height: 50,),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (context, index) {
                  final item=categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) {
                      return DoctorListScreen(speciality: item['name']);
                    },));
                  },
                  child: IconContainer(text: item['name']!,imagePath: item['image']!));
              },itemCount:categories.length ,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Top Doctors',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Text('See all',style: TextStyle(fontSize: 14,color: appColor,fontWeight: FontWeight.bold),),
            ],),
            SizedBox(
              height: 240,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').where('isDoctor',isEqualTo: true).snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());
                    }
                    var doctorsDocs=snapshot.data!.docs;
                    return ListView.builder(itemBuilder: (context, index) {
                      UserModel doctor=UserModel.fromMap(doctorsDocs[index].data() as Map<String,dynamic>);
                      return AvailableDoctorContainer(doctor: doctor,);
                    },itemCount: doctorsDocs.length,
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                    );
                  }
                ),
              )
        
          ],
        ),
      ),
    );
  }
}