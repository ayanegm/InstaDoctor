import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/models/doctor_model.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/doctor/doctor_personal_page.dart';
import 'package:service_app/widgets/custom_register_button.dart';
import 'package:service_app/widgets/custom_text_field.dart';
import 'package:service_app/widgets/text_field_drop_list.dart';

class CompleteDoctorProfilePage extends StatefulWidget {
   CompleteDoctorProfilePage({super.key,required this.userModel});
UserModel userModel;
  @override
  State<CompleteDoctorProfilePage> createState() => _CompleteDoctorProfilePageState();
}

class _CompleteDoctorProfilePageState extends State<CompleteDoctorProfilePage> {
    final List<String>specialities=categories.map((Category)=>Category['name']!).toList();
    String? selectedSpecialty;
    String?selectedMedicalTitle;
 TextEditingController bio=TextEditingController();
 TextEditingController location=TextEditingController();
 TextEditingController experienceYears=TextEditingController();
 TextEditingController phoneNumber=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor:Color(0xFFe8eef8),),
      backgroundColor: Color(0xFFe8eef8),
      body: Column(children: [
        CustomDropDownField(hintText: 'Choose medical field',specialities: specialities,onChanged: (value) {
          setState(() {
            selectedSpecialty=value;
          });
        },),
        SizedBox(height: 15,),
        CustomDropDownField(hintText: 'Proffessional title',specialities: medicalTitle,onChanged: (value) {
          setState(() {
            selectedMedicalTitle=value;
          });
        },),
                SizedBox(height: 15,),

CustomTextField(field_title: 'Location', maxLines: 3,controller: location, validator: (val) {
            if(val==''){
                  return 'Can\'t to be empty';
            }
          },), 
         SizedBox(height: 15,),
          CustomTextField(field_title: 'About (Bio)', maxLines: 3,controller: bio, validator: (val) {
            if(val==''){
                  return 'Can\'t to be empty';
            }
          },),
          SizedBox(height: 15,),
          CustomTextField(field_title: 'Years of Experience',isText: false,controller: experienceYears, validator: (val) {
            if(val==''){
                  return 'Can\'t to be empty';
            }
          },),
          SizedBox(height: 15,),
          CustomTextField(field_title: 'phone Number',isText: false,controller: phoneNumber, validator: (val) {
            if(val==''){
                  return 'Can\'t to be empty';
            }
          },),
          CustomRegisterButton(buttonName: 'Save',onTap: () async{
            DoctorModel doctorModel=DoctorModel(Speciality:selectedSpecialty! , location: location.toString(),yearsExperience: int.tryParse(experienceYears.text)??0, bio: bio.text.toString(),phoneNumber: phoneNumber.text);
            widget.userModel.doctorModel=doctorModel;
            await FirebaseFirestore.instance.collection('users').doc(widget.userModel.uid).set(widget.userModel.toMap());
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DoctorPersonalPage();
            },));
          },width: 100,),


      ],),
    );
  }
}