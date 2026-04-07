import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/home_page.dart';
import 'package:service_app/screens/signin_page.dart';
import 'package:service_app/widgets/custom_register_button.dart';
import 'package:service_app/widgets/custom_text_field.dart';
import 'package:service_app/widgets/snackbar.dart';

class SignupPage extends StatelessWidget {
   SignupPage({super.key});
final TextEditingController usernameController=TextEditingController();
final TextEditingController emailController=TextEditingController();
final TextEditingController passwordController=TextEditingController();
GlobalKey<FormState>formState=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xFFe8eef8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0,vertical: 13),
        child: Form(
          key: formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Sign Up',style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,),),
            SizedBox(height: 9,),
            Row(
              children: [
                Text('Already have an account?   '),
                Text('Sign In!',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,),),
              ],
            ),
          SizedBox(height: 30,),
          CustomTextField(field_title: 'Username*', controller: usernameController, validator: (val) {
            if(val==''){
                  return 'Can\'t to be empty';
            }
          },),
          SizedBox(height: 15,),
          CustomTextField(field_title: 'Email*', controller: emailController, validator: (val) {
            if(val==''){
                  return 'Can\'t to be empty';
            }
          },),
          SizedBox(height: 15,),
          CustomTextField(field_title: 'Password*', controller: passwordController, validator: (val) {
            if(val==''){
                  return 'Can\'t to be empty';
            }
          },),
          SizedBox(height: 30,),
          
          CustomRegisterButton(width: double.infinity,buttonName: 'Sign Up',onTap: ()async {
            if(formState.currentState!.validate()){
              try{
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
                  await credential.user!.updateDisplayName(usernameController.text);
                  print("User Created: ${credential.user!.uid}");            

                 await FirebaseAuth.instance.currentUser!.sendEmailVerification();

            CustomSnackBar.show(context,'Please verify your email then sign in.');
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SigninPage();
              },));
              }
              on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                CustomSnackBar.show(context,'The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
               CustomSnackBar.show(context,'The account already exists for that email.');
              }
              else{
                CustomSnackBar.show(context,'Wrong email or password');
              }
            } catch (e) {
              CustomSnackBar.show(context,e.toString());
            }
            }
            else{
              CustomSnackBar.show(context,'this not valid');
            }
            }
            
          
          )
          ],)
        ),
      ),
    );
  }
}