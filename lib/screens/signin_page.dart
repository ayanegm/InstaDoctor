import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/main_doctor_navigator.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/choosing_doctor_user.dart';
import 'package:service_app/screens/doctor/doctor_home_page.dart';
import 'package:service_app/screens/doctor/doctor_personal_page.dart';
import 'package:service_app/screens/home_page.dart';
import 'package:service_app/screens/signup_page.dart';
import 'package:service_app/widgets/custom_register_button.dart';
import 'package:service_app/widgets/custom_text_field.dart';
import 'package:service_app/widgets/snackbar.dart';

class SigninPage extends StatefulWidget {
   SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
final TextEditingController emailController=TextEditingController();

final TextEditingController passwordController=TextEditingController();

GlobalKey<FormState>formState=GlobalKey<FormState>();

bool isLoading=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe8eef8),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0,vertical: 53),
            child: Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  'Sign In',
                style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,),),
                SizedBox(height: 9,),
                Row(
                  children: [
                    Text('Don\'t have an account?   '),
                    GestureDetector(child: Text('Sign up!',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,),),
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SignupPage();
                    },));
                  },),
                  ],
                ),
              SizedBox(height: 30,),
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
              },isPassword: true,),
              SizedBox(height: 30,),
              Text('Forget you password',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,),),
              SizedBox(height: 30,),
              CustomRegisterButton(width: double.infinity,buttonName: 'Sign In',onTap: () async{
                if(formState.currentState!.validate()){
                           try {
                            setState(() {
                              isLoading=true;
                            });
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text
                        );
                        await credential.user!.reload();
                        if(credential.user!.emailVerified){
                        var user=  await FirebaseFirestore.instance
                                .collection('users')
                                .doc(credential.user!.uid)
                                .get();
                                setState(() => isLoading = false);
                                if(user.exists&& user.data() != null){
                                  Map<String,dynamic>userData=user.data() as Map<String,dynamic>;
                                  if(userData['isDoctor']==true){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DoctorMainNavigator()));
                                  }
                                  else{
                                     Navigator.push(context,MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  },));
                                  }
                                }
                                else{
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                    return ChoosingDoctorUser();
                                    },));
                                }
                          
                        }
                        else{
                          FirebaseAuth.instance.currentUser!.sendEmailVerification();
                          CustomSnackBar.show(context,'Please check you  email fr verification');
                        }
          
                      } 
                      
                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          CustomSnackBar.show(context,'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          CustomSnackBar.show(context,'Wrong password provided for that user.');
                        }
                        else{
                          CustomSnackBar.show(context,'error in email or password');
                          setState(() {
                          isLoading = false; 
                        });
                        }
                      }
                      catch(e){
                        CustomSnackBar.show(context,'Error: ${e.toString()}');
                          setState(() {
                          isLoading = false; 
                        });
                      }
                      }
                      else{
                        CustomSnackBar.show(context,'Not valid');
                      }
                
              },),
              
              ],),
            ),
          ),
        ),
      ),
    );
  }
}