import 'package:flutter/material.dart';

class SpecialityCard extends StatelessWidget {
  const SpecialityCard({super.key, required this.name, required this.imagePath});
final String name;
final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFffffff),
        boxShadow: [
          BoxShadow(
            // 2. Use a very low opacity black or a light grey
            color: Colors.black.withOpacity(0.04), 
            // 3. High blur makes it soft
            blurRadius: 20, 
            // 4. Spread makes the shadow larger
            spreadRadius: 2, 
            // 5. Offset (0, 10) pushes the shadow downwards
            offset: const Offset(6, 6), 
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 50,width: 50,child: Image.asset(imagePath)),
            SizedBox(height: 15,),
            Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
          ],
        ),
      ),
      
    );
  }
}