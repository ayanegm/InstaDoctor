import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDropDownField extends StatefulWidget {
  final List<String> specialities;
  final Function(String?)onChanged;
  final String? hintText;
  
  const CustomDropDownField({super.key, required this.specialities, required this.onChanged,required this.hintText});

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  String? selectedValue;
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.transparent,
        focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 101, 101, 101), width: 1,),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 197, 197, 197), width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromARGB(255, 197, 197, 197), width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
      ),
      items: widget.specialities.map((String name) {
        return DropdownMenuItem<String>(
          value: name,
          child: Text(
            name,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue=value;
        });
        widget.onChanged(value);
      },
      validator: (value) => value ==null?'please select a speciality':null,
    );
  }
}