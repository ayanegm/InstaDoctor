import 'package:flutter/material.dart';
import 'package:service_app/widgets/custom_button.dart';

class DoctorContainer extends StatelessWidget {
  const DoctorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow:[ BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius:10,
          offset:  Offset(4, 4),

      )],
      ),
      
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
        height: 125,
        width: 125,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          
        ),child: Icon(Icons.person),),
        SizedBox(width: 14,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dr. Jhon Peter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  Icon(
                  Icons.favorite_border,
                  size: 20,
                  color: Color(0xFF577df2),
                ),
                ],
              ),
             Text('Dr.Jhon Peter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Color.fromARGB(255, 75, 75, 75)),),
             Text('25+ Years of experience',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color.fromARGB(255, 75, 75, 75)),),
              SizedBox(height: 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(children: [
                    Container(
                  height: 10,
                  width: 10,child: Image.asset('assets/images/star.png'),),
                  SizedBox(width: 5,),
             Text('4.9 (203 Reviews)',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color.fromARGB(255, 75, 75, 75)),),
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
              
              SizedBox(height: 8,),
            CustomButton(text: 'Book Appointment',onpressed: () {
              
            },)
            ],
          ),
        ),

      ],),
    );
  }
}