import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_app/firebase_options.dart';
import 'package:service_app/logic/cubit/daily_slots_cubit.dart';
import 'package:service_app/main_doctor_navigator.dart';
import 'package:service_app/screens/doctor/doctor_appointment_page.dart';
import 'package:service_app/screens/home_page.dart';
import 'package:service_app/screens/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:service_app/screens/user_appointment_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return BlocProvider(
    // نقوم بإنشاء الـ Cubit مرة واحدة هنا
    create: (context) => DailySlotsCubit()..getDailySlots(null), 
    child: MaterialApp(
      title: 'Service App',
      debugShowCheckedModeBanner: false,
      home:  SigninPage(),
    ),
  );
  }
}