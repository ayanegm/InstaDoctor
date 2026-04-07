import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/widgets/doctor_widgets/doctor_profile_card_widget.dart';

class DoctorProfilePage extends StatefulWidget {
 DoctorProfilePage({super.key,required this.doctor});
UserModel doctor;
  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  int _selectedTabIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
    color: Colors.white, // Use your specific blue color
  ),
        backgroundColor: appColor,
        title: Text('Doctor Profile',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children:[
              Container(color: appColor,height: 120,width: double.infinity,),
              DoctorProfileCardWidget(doctor:widget.doctor ,)
            ] ),
            DefaultTabController(length: 2, child: Column(
              children: [
                TabBar(
                  onTap: (value) {
                    setState(() {
                      _selectedTabIndex=value;
                    });
                  },
                  tabs: [
                    Tab(text: 'About',),
                    Tab(text: 'Review',)
                  ],
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4.0, color: Color(0xFF577df2)),
                    insets: EdgeInsets.symmetric(horizontal: 150.0), // Control width manually
                  ),
                indicatorColor: Color(0xFF577df2),
                labelColor:Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                ),
               Padding(padding: EdgeInsetsGeometry.all(20),
               child: _selectedTabIndex==0?_buildAboutContent():Center(child: Text('Reviews Section Here'),),)
          
              ],
              
            ))
          ],
        ),
      ),
    );
  }
}

Widget _buildAboutContent(){
  return Column(
    crossAxisAlignment:CrossAxisAlignment.start,
    children: [
      Text(
        'Dr. John Peter is a cardiologist having 25 years of experience. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        style: TextStyle(color: Colors.grey[700], height: 1.5),
      ),
      SizedBox(height: 30,),
      Text('Qualification',style: TextStyle(fontSize: 19,fontWeight:FontWeight.bold ),),
      SizedBox(height: 10,),
      Text(
        'Dr. John Peter is a cardiologist having 25 years of experience. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        style: TextStyle(color: Colors.grey[700], height: 1.5),
      ),
      SizedBox(height: 30,),
      Text('Working Time',style: TextStyle(fontSize: 19,fontWeight:FontWeight.bold ),),
      SizedBox(height: 10,),
      Text(
        'Dr. John Peter is a cardiologist having 25 years of experience. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        style: TextStyle(color: Colors.grey[700], height: 1.5),
      ),
 SizedBox(height: 30,),
      Text('Address',style: TextStyle(fontSize: 19,fontWeight:FontWeight.bold ),),
      SizedBox(height: 10,),
      Text(
        'Dr. John Peter is a cardiologist having 25 years of experience. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        style: TextStyle(color: Colors.grey[700], height: 1.5),
      ),
    ],
  );
}