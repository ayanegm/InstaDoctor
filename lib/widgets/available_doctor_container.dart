import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/doctor/doctor_profile_page.dart';

class AvailableDoctorContainer extends StatelessWidget {
   AvailableDoctorContainer({super.key,required this.doctor});

UserModel doctor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DoctorProfilePage(doctor: doctor,);
        },));
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: [
            
            Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 10,),
              Text(doctor.name,style: TextStyle(color: greycolor,fontWeight: FontWeight.bold,fontSize: 15)),
              SizedBox(height: 1,),
              Text(doctor.doctorModel!.Speciality,style: TextStyle(color: lightgreycolor),),
              SizedBox(height: 8,),
              Row(
                children: [
                  Container(
                        height: 10,
                        width: 10,child: Image.asset('assets/images/star.png'),),
                        SizedBox(width: 4,),
                        Container(
                        height: 10,
                        width: 10,child: Image.asset('assets/images/star.png'),),
                        SizedBox(width: 4,),
                        Container(
                        height: 10,
                        width: 10,child: Image.asset('assets/images/star.png'),),
                        SizedBox(width: 4,),
                        Container(
                        height: 10,
                        width: 10,child: Image.asset('assets/images/star.png'),),
                        SizedBox(width: 4,),
                ],
              ),
              
              SizedBox(height: 20,),
              Text('Experience',style: TextStyle(color: lightgreycolor),),
              Text('5 Years',style: TextStyle(color: greycolor,fontWeight: FontWeight.bold,fontSize: 15)),
              SizedBox(height: 17,),
              Text('Patients',style: TextStyle(color: lightgreycolor),),
              Text('1.0k',style:  TextStyle(color: greycolor,fontWeight: FontWeight.bold,fontSize: 15),),
            ],),
            Container(
              width: 75,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey
              ),
              child: Center(child: Icon(Icons.person)),
            ),
          ],
        ),
        width: 260,
      ),
    );
  }
}