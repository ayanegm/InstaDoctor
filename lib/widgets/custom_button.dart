import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onpressed});
final String text;
final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onpressed ,
      child: Container(
        
        height: 36,
        decoration: BoxDecoration(
          color: Color(0xFF577df2),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),)),
        
      ),
    );
  }
}