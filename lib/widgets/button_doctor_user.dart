import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';

class ButtonDoctorUser extends StatelessWidget {
  const ButtonDoctorUser({super.key, required this.text, required this.onpressed});
final String text;
final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onpressed ,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Center(child: Text(text,style: TextStyle(color: appColor,fontSize: 13,fontWeight: FontWeight.bold),)),
        
      ),
    );
  }
}