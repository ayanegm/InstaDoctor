import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        
        color: Color(0xFFfafafa),
        border: Border.all(
          
      color:Color.fromARGB(255, 194, 194, 194),
    ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: TextField(
          
          decoration: InputDecoration(
            
            hintText: 'Search Doctor',
            prefixIcon: Icon(
              Icons.search_rounded,
              color: const Color.fromARGB(255, 103, 103, 103),
              size: 30,
            ),
            hintStyle: TextStyle(color: const Color.fromARGB(255, 103, 103, 103),fontWeight: FontWeight.w700),
            border: InputBorder.none,
        
          ),
        ),
      ),
    );
  }
}