import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.text, required this.imagePath});
final String text;
final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 40),
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: Color(0xFFF2EAFD), // Light purple background
              shape: BoxShape.circle,
            ),
            child: Center(child: Image.asset(imagePath,height: 33,width: 33,),)
          ),
          SizedBox(height: 8,),
           Text(
            text, 
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 75, 75, 75), // Darker purple text
            ),
          ),
        ],
      ),
      
      
    );
  }
}