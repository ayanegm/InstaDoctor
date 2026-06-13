import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/book_appointment_page.dart';
import 'package:service_app/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileCardWidget extends StatelessWidget {
   DoctorProfileCardWidget({super.key,required this.doctor});
UserModel doctor;
  calling(String phoneNumber)async{
final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
   if(await canLaunchUrl(phoneUri)){
    await launchUrl(phoneUri);
   }else{
    throw 'couldn\'t launch $phoneUri';
   }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 800),
        child: Container(
          height: 173,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow:[ BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius:10,
              offset:  Offset(4, 4),
        
          )],
          ),
          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 19,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              SizedBox(height: 19,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                
              ),child: Icon(Icons.person),),
              SizedBox(width: 19,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        Text(doctor.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      
                      ],),
                 SizedBox(height: 3,),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                 Row(children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Color(0xFF577df2),
                    ),
                    SizedBox(width: 4,),
                    Text(
                      doctor.doctorModel!.location, // القيمة الديناميكية من Firestore
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromARGB(255, 75, 75, 75)
                        ),
                      ),
                    
                  ],),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
                      child: Text("Available Now", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],),
                  SizedBox(height: 5,),
                  Text(
                    doctor.doctorModel?.Speciality ?? 'General',
                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  
              ],),
              )]),
              SizedBox(height: 17,),
              Row(
                    
                  children: [
                    GestureDetector(
                  onTap:() {
                    calling(doctor.doctorModel!.phoneNumber.toString());
                  } ,
                  child: Container(
                    width:41,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color(0xFF577df2),
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Center(child:Icon(Icons.phone,color: Colors.white,size: 20,)),
          
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                  onTap:() {
                    Clipboard.setData(ClipboardData(text: doctor.email));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email copied to clipboard!')),
                      );
                  } ,
                  child: Container(
                    width:41,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color(0xFF577df2),
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Center(child:Icon(Icons.email,color: Colors.white,size: 20,)),
          
                ),
              ),
              SizedBox(width: 20,),
                    Expanded(
                      child: CustomButton(text: 'Book Appointment', onpressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return BookAppointmentPage(doctor: doctor,);
                        },));
                      },),
                    ),
                    
                  ],
                  ),
            ],),
          ),
        ),
      ),
    );
  }
}