import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:service_app/logic/cubit/daily_slots_cubit.dart';
import 'package:service_app/logic/cubit/daily_slots_state.dart';
import 'package:service_app/models/appointment_model.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/doctor/doctor_personal_page.dart';
import 'package:service_app/widgets/appointment_home_widget_dcotor.dart';
import 'package:service_app/widgets/doctor_widgets/doctor_bottom_navigator_bar.dart';
import 'package:service_app/widgets/doctor_widgets/next_appoitment_card.dart';
import 'package:service_app/widgets/doctor_widgets/stats_cards_widget.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  String userId=FirebaseAuth.instance.currentUser!.uid;
//  late Stream<DocumentSnapshot> dailyStream;
  UserModel? userModel;
  
  @override
  void initState(){
    super.initState();
    // String dateId=DateFormat('yyyy-MM-dd').format(DateTime.now());
    // dailyStream=FirebaseFirestore.instance.collection('users').doc(userId).collection('daily_slots').doc(dateId).snapshots();
    getUserData();
  }
  void getUserData() async {
  var doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (doc.exists) {
    setState(() {
      userModel = UserModel.fromMap(doc.data() as Map<String, dynamic>);
    });
  }
}
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: DoctorBottomNavigatorBar(selectedIndex: 0,),
      backgroundColor: Color(0xFFecf2fb),
        body: BlocBuilder<DailySlotsCubit,SlotsState>(builder: (context, state) {
          if(state is slotsLoadingState)return Center(child: CircularProgressIndicator(),);
          else if(state is slotsFailureState){
            return Center(child: Text(state.errorMessage),);
          }
          else if(state is slotsSuccessState){
            final allSlots=state.appointments;
            if(allSlots.isEmpty){
                return _buildEmptyState();
            }
        List<AppointmentModel> bookSlots=allSlots.where((element) => element.status=='booked').toList();
        List<AppointmentModel> completedSlots=allSlots.where((element) => element.status=='completed').toList();
        List<AppointmentModel> cancelledSlots=allSlots.where((element) => element.status=='cancelled').toList();
        bookSlots.sort((a, b) => a.time.compareTo(b.time));
             return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Welcome back, Dr.${userModel!.name}',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                  ],
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: StatsCardsWidget( numberOfTasks: bookSlots.length, title: 'booked')),
                    SizedBox(width:10),
                    Expanded(child: StatsCardsWidget( numberOfTasks: completedSlots.length, title: 'completed')),
                    SizedBox(width:10),
                    Expanded(child: StatsCardsWidget(numberOfTasks:cancelledSlots.length , title: 'cancelled')),
                  ],
                ),
                SizedBox(height: 100,),
                if(bookSlots.isNotEmpty)
                  NextAppoitmentCard(appointmentModel: bookSlots[0],)
                else...[
                  Center(child: Container(child:Image.asset('images/empty.png'),height: 300,width:300,)),
                  Center(child: Text('No upcoming appointments for today'),),
                ], 
                SizedBox(height: 20,),
                if(bookSlots.length>1)...[
                  Text('Today\'s Booked Appointments'),
                SizedBox(height: 10,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:(context, index) {
                    return AppointmentsWidget(appointmentModel: bookSlots[index+1],);
                  } ,
                  itemCount:bookSlots.length>1?bookSlots.length-1:0 ,),
                ]
                
               
              ],
            ),
          ),
        );
        
          }
          return SizedBox();
        },)
    
  );
  }
}

Widget _buildEmptyState({String message = 'There are no appointments yet'}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/empty.png', height: 200),
          const SizedBox(height: 10),
          Text(message),
        ],
      ),
    );
  }
