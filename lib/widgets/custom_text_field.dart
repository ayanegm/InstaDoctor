
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_app/const/constant.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    // Initialize with the value passed from the parent
    _obscureText = widget.isPassword;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      controller: widget.controller,
      validator:widget.validator,
      obscureText:_obscureText,
      
      inputFormatters: widget.isText 
          ? null 
          : [FilteringTextInputFormatter.digitsOnly],
          keyboardType: widget.isText ? TextInputType.text : TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                
                fillColor: Colors.transparent,
                focusColor: Colors.white,
                suffixIcon: widget.isPassword 
          ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: greycolor,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
          : null,
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
                hintText: widget.field_title,
                hintStyle: const TextStyle(color: greycolor,fontSize: 15,fontWeight: FontWeight.w500),
              ),
            );
  }
}