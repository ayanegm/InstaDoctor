import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/doctor/complete_doctor_profile_page.dart';
import 'package:service_app/screens/home_page.dart';
import 'package:service_app/widgets/button_doctor_user.dart';

class ChoosingDoctorUser extends StatelessWidget {
  const ChoosingDoctorUser({super.key});

  @override
  Widget build(BuildContext context) {
   User? user =FirebaseAuth.instance.currentUser;
  UserModel userModel=UserModel(uid:user!.uid , name:user.displayName! , email:user.email! );           
    return Scaffold(
      backgroundColor: appColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 40),
        child: Column(children: [

           Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonDoctorUser(text: 'Doctor', onpressed: () {
                  userModel.isDoctor=true;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CompleteDoctorProfilePage(userModel:userModel ,);
                  },));
                },
                ),
                SizedBox(width: 50,),
            
                ButtonDoctorUser(text: 'User', onpressed: ()async {
                  await FirebaseFirestore.instance.collection('users').doc(userModel.uid).set(userModel.toMap());
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  },));
                },
                ),
              ],
            ),
          
        ],),
      ),
    );
  }
}