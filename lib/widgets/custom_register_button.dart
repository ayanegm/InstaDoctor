import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';

class CustomRegisterButton extends StatelessWidget {
  const CustomRegisterButton({super.key, required this.width,required this.buttonName, required this.onTap});
final String buttonName;
final VoidCallback onTap;
final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 47,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFF285fd4),
          borderRadius: BorderRadius.circular(2),
        
        ),
        child:
         Center(
      child:
        Text(buttonName,style: TextStyle(color: Colors.white),),),
        ),
    );
  }
}