import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/services/appointment_service.dart';
import 'package:service_app/services/weekly_schedule_service.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/screens/book_appointment_page.dart';
import 'package:service_app/screens/calender_screen.dart';
import 'package:service_app/screens/doctor/doctor_home_page.dart';
import 'package:service_app/widgets/custom_register_button.dart';
import 'package:service_app/widgets/custom_text_field.dart';
import 'package:service_app/widgets/time_booking_appointment_container.dart';
import 'package:service_app/widgets/timer/selected_period_button.dart';
import 'package:service_app/widgets/timer/timer_picker.dart';

class HorizontalDoctorAppointmentSelector extends StatefulWidget {
  const HorizontalDoctorAppointmentSelector({super.key});

  @override
  State<HorizontalDoctorAppointmentSelector> createState() => _HorizontalDoctorAppointmentSelectorState();
}

class _HorizontalDoctorAppointmentSelectorState extends State<HorizontalDoctorAppointmentSelector> {
   
   
  late Map<String,List<Map<String,dynamic>>>schedule;
 String selectedDay=DateFormat('EEE').format(DateTime.now());
  TextEditingController durationController=TextEditingController();
GlobalKey<FormState>formState=GlobalKey<FormState>();
Duration selectedDuration =Duration(hours: 0);
String finalPeriod = "AM";
final String uid = FirebaseAuth.instance.currentUser!.uid;
WeeklyScheduleService _weeklyScheduleService=WeeklyScheduleService();
AppointmentService _appointmentService=AppointmentService();
void _showDeleteDialog(BuildContext context,String timeSlot,String dayName){
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text('Delete Appointment'),
      content: Text('Are you sure you want to delete the ${timeSlot} slot?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        TextButton(onPressed: ()async {
          Navigator.of(context).pop();
          await _weeklyScheduleService.deleteWeeklySlot(doctorId: uid, DayName: dayName,SlotTime: timeSlot);
        }, child: Text('Delete'))
      ],
    );
  },);

}
  @override
  Widget build(BuildContext context) {
    
         return Padding(
           padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 30),
           child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                   SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'].map((day) {
                bool isSelected = selectedDay == day;
                return GestureDetector(
                  onTap: () => setState(() => selectedDay = day),
                  child: Container(
                    width: 60,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? appColor : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: appColor),
                    ),
                    child: Center(
                      child: Text(day, style: TextStyle(color: isSelected ? Colors.white : Colors.blue)),
                    ),
                  ),
                );
              }).toList(),
            ),
                   ),
                   SizedBox(height: 30,),
           
                  StreamBuilder<DocumentSnapshot>(
                 stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                  builder: (context, snapshot) {
                   if(snapshot.connectionState==ConnectionState.waiting){
            return  Center(child: CircularProgressIndicator(),);
                   }
                   if(!snapshot.hasData || snapshot.data?.data()==null){
            return Center(child: Text('Error loading data'),);
                   }
                   UserModel userModel=UserModel.fromMap(snapshot.data?.data() as Map<String,dynamic>);
                   schedule=userModel.doctorModel!.weeklySchedule;
                   if(schedule[selectedDay]!.isEmpty){
            return Center(child: Text('There is no tasks yet'),);
                   }
                  
             return GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: schedule[selectedDay]!.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 5,
    crossAxisSpacing: 10,
    mainAxisSpacing: 12,
    childAspectRatio: 2.3,
  ),
  itemBuilder: (context, index) {
    var slot = schedule[selectedDay]![index]; // استخراج الـ slot لتسهيل الوصول
    String currentStatus = slot['status'] ?? 'available';
    return GestureDetector(
      onLongPress: () {
        _showDeleteDialog(context, slot['time'], selectedDay);
      },
      child: TimeBookingAppointmentContainer(
        status: currentStatus, // القالب الأسبوعي دائماً متاح للتعديل
        time: slot['time'],
        isMorning: slot['isMorning'],
      ),
    );
  },
);
                  }),
                   SizedBox(height: 50,),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(field_title:'Duration' ,controller: durationController,validator: (value) {
                    if(value==''){
                      return 'this field cannot be empty';
                    }
                  },onTap: ()async {
                      final Duration? picked =await TimerPickerHelper.showDurationPicker(context, Duration(hours: 0));
                      if(picked!=null){
                        setState(() {
                      durationController.text = 
                          "${picked.inHours.toString().padLeft(2, '0')}:${(picked.inMinutes % 60).toString().padLeft(2, '0')}:${(picked.inSeconds % 60).toString().padLeft(2, '0')}";
                  });
                      }
                  },),
                ),
                 SizedBox(width: 10,),
                  Center(
                    child: selectedPeriodButton(onChanged: (newValue) {
                        finalPeriod = newValue;
                    },), 
                  )
              ],
            ),
            SizedBox(height: 40,),
            CustomRegisterButton(onTap: ()async {
              if(durationController.text.isNotEmpty){
                String timeStr = "${durationController.text}";
                bool isMorning=finalPeriod=='AM';
                bool alreadyExists=schedule[selectedDay]!.any((slot)=>slot['time']==timeStr);
                if(alreadyExists){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('this slot is already existing'))
                  );
                }
                else{
                schedule[selectedDay]!.add({
                  'time':timeStr,
                  'isMorning':isMorning
                });
                await FirebaseFirestore.instance.collection('users').doc(uid).update({
                  'doctorModel.weeklySchedule':schedule
                });
                durationController.clear();
                }
              }
            },
            buttonName: 'Add',
            width: 120,),
            SizedBox(height: 30,),
            CustomRegisterButton(onTap: ()async {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(child: CircularProgressIndicator()),
                );
                try{
                await _appointmentService.syncWeeklyToDaily(doctorId:uid,weeklySchedule:schedule );
                if (!mounted) return;
      Navigator.pop(context);
Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DoctorHomePage();
              },));
                }
                catch (e) {
      if (mounted) Navigator.pop(context); 
      print("Error: $e");
    }
              
            },
            buttonName: 'Save',
            width: 120,),
            SizedBox(height: 30,),
           
              ],),
         );
    
  }
}