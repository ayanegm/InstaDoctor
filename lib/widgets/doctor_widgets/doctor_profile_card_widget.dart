import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/book_appointment_page.dart';
import 'package:service_app/widgets/custom_button.dart';

class DoctorProfileCardWidget extends StatelessWidget {
   DoctorProfileCardWidget({super.key,required this.doctor});
UserModel doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(height: 20,),
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
                    Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: Color(0xFF577df2),
                  ),
                  ],),
             SizedBox(height: 4,),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(children: [
                    Container(
                  height: 10,
                  width: 10,child: Image.asset('assets/images/star.png'),),
                  SizedBox(width: 5,),
                  SizedBox(height: 30,),
             Text('4.9 (203 Reviews)',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color.fromARGB(255, 88, 88, 88)),),
                ],),
                
             Row(children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: Color(0xFF577df2),
                ),
                SizedBox(width: 4,),
                Text(
                  '3.2 ml',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color.fromARGB(255, 75, 75, 75)
                  ),
                )
              ],),
              ],),
              SizedBox(height: 20,),
              
              
          ],),
          )]),
          SizedBox(height: 17,),
          Row(
                
              children: [
                GestureDetector(
              onTap:() {
                
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
    );
  }
}