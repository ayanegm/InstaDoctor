import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      appBar: AppBar(automaticallyImplyLeading: false,backgroundColor: Color(0xFFe8eef8),title: Center(child: Text('My Appointments',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
        child: StreamBuilder<DocumentSnapshot>(
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
            appointments.sort((a, b) => a.date.compareTo(b.date));
            DateTime today=DateTime.now();
            DateTime startOfToday=DateTime(today.year,today.month,today.day);
            
            appointments = appointments.where((ap) => !ap.date.isBefore(startOfToday)).toList();
        
                  if (appointments.isEmpty) {
        return const Center(child: Text('No upcoming appointments'));
                  }
        
          
            return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          
          // Formatting dates for comparison
          String appointmentDateStr = DateFormat('EEEE, d MMM').format(appointment.date);
          String todayStr = DateFormat('EEEE, d MMM').format(today);
        
          // Determine if we should show a Date Header
          bool showHeader = false;
          if (index == 0) {
            showHeader = true; // Always show header for first item
          } else {
            String prevDateStr = DateFormat('EEEE, d MMM').format(appointments[index - 1].date);
            if (appointmentDateStr != prevDateStr) {
              showHeader = true; // Show header if date changes
            }
          }
        
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showHeader) ...[
                const SizedBox(height: 20),
                Text(
                  appointmentDateStr == todayStr ? "Today" : appointmentDateStr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 10),
              ],
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: UserAppointmentSlot(appointment: appointment),
              ),
            ],
          );
        },
                  );
          },
          stream:userDoc.snapshots() ,
          
        ),
      ),
    );
  }
}