
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_app/const/constant.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key,this.readOnly=false,this.onTap,this.isPassword = false,required this.field_title,this.isText=true,this.maxLines,required this.controller,required this.validator});
String field_title;
TextEditingController controller;
String? Function(String?)?validator;
  final VoidCallback? onTap;
final bool readOnly;
bool isText;
int? maxLines;
final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      validator:validator,
      obscureText: isPassword,
      inputFormatters: isText 
          ? null 
          : [FilteringTextInputFormatter.digitsOnly],
          keyboardType: isText ? TextInputType.text : TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                
                fillColor: Colors.transparent,
                focusColor: Colors.white,
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
                hintText: field_title,
                hintStyle: const TextStyle(color: greycolor,fontSize: 15,fontWeight: FontWeight.w500),
              ),
            );
  }
}