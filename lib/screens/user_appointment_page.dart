import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_app/models/appointment_model.dart';
import 'package:service_app/widgets/bottom_navigator_bar.dart';
import 'package:service_app/widgets/user_appointment_slot.dart';

class UserAppointmentPage extends StatefulWidget {
  const UserAppointmentPage({super.key});

  @override
  State<UserAppointmentPage> createState() => _UserAppointmentPageState();
}

class _UserAppointmentPageState extends State<UserAppointmentPage> {
  late String userId;
  late DocumentReference userDoc;
  @override
  void initState(){
    super.initState();
    userId=FirebaseAuth.instance.currentUser!.uid;
    userDoc=FirebaseFirestore.instance.collection('users').doc(userId);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe8eef8),
      bottomNavigationBar: CustomBottomNavigatorBar(selectedIndex: 1),
      appBar: AppBar(backgroundColor: Color(0xFFe8eef8),title: Center(child: Text('My Appointments',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              builder: (context, snapshot) {
                if(snapshot.hasError) return Text('Error happens in streaming');
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(!snapshot.hasData){
                  return Center(child: Text('No user data found'),);
                }
                var userData=snapshot.data!.data() as Map<String,dynamic>;
                List<dynamic>appointmentRaw=userData['appointmentList'] ??[];
                List<AppointmentModel>appointments=appointmentRaw.map((item)=>AppointmentModel.fromMap(item as Map<String, dynamic>)).toList();

                return Expanded(
                  child: ListView.separated(
                    
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                  return UserAppointmentSlot(appointment: appointments[index],);
                                },itemCount:appointments.length ,),
                );
              },
              stream:userDoc.snapshots() ,
              
            )
            
          ],
        ),
      ),
    );
  }
}