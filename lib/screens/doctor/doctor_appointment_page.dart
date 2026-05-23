import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:service_app/logic/cubit/daily_slots_cubit.dart';
import 'package:service_app/logic/cubit/daily_slots_state.dart';
import 'package:service_app/models/appointment_model.dart';
import 'package:service_app/widgets/appointment_home_widget_dcotor.dart';
import 'package:service_app/widgets/doctor_widgets/doctor_bottom_navigator_bar.dart';

class DoctorAppointmentPage extends StatefulWidget {
  const DoctorAppointmentPage({super.key});

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  
    int _selectedTabIndex=0;
    DateTime today=DateTime.now();
    var doctorId=FirebaseAuth.instance.currentUser!.uid;
@override
void initState() {
  super.initState();
  _loadAppointmentsForSelectedDate();
}

void _loadAppointmentsForSelectedDate() {
  String formattedDate = DateFormat('yyyy-MM-dd').format(today);
  context.read<DailySlotsCubit>().getDailySlots(formattedDate);
}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DoctorBottomNavigatorBar(selectedIndex: 1,),
      backgroundColor: Color(0xFFe8eef8),
      body:SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(children: [
                    TabBar(
                      onTap: (value) {
                        setState(() {
                          _selectedTabIndex=value;
                        });
                      },
                      tabs: [
                        Tab(text: 'Upcoming',),
                        Tab(text: 'Completed',),
                        Tab(text: 'Cancelled',)
                      ],
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: Color(0xFF577df2)),
                        insets: EdgeInsets.symmetric(horizontal: 120.0), // Control width manually
                      ),
                    indicatorColor: Color(0xFF577df2),
                    labelColor:Colors.black,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                    Expanded(child:
                    BlocBuilder<DailySlotsCubit,SlotsState>(builder: (context, state) {
                      if(state is slotsLoadingState){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      else if(state is slotsFailureState){
                        return Center(child: Text(state.errorMessage),);
                      }
                      else if(state is slotsSuccessState){
                        List<AppointmentModel>allAppointments=state.appointments;
                        List<AppointmentModel>filteredList=[];
                        if(_selectedTabIndex==0){
                          filteredList=allAppointments.where((e)=>e.status=='booked').toList();
                         }
                         else if(_selectedTabIndex==1){
                          filteredList=allAppointments.where((e)=>e.status=='completed').toList();
                         }
                         else{
                          filteredList=allAppointments.where((e)=>e.status=='cancelled').toList();
                         }
                         if (filteredList.isEmpty) {
                        return const Center(child: Text("No appointments found"));
                      }
                       return ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return AppointmentsWidget(appointmentModel: filteredList[index]);
                        
                        },
                      );
                      }
                      
                      return SizedBox();
                    },)
                
                      ),
                  ],
                  
                )
          )
      )
      
    );
  }
}
