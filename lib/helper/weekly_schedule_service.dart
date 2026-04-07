import 'package:cloud_firestore/cloud_firestore.dart';

class WeeklyScheduleService {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> deleteWeeklySlot({required String doctorId,required String SlotTime,required String DayName})async{
  try{
  DocumentReference docRef=_firestore.collection('users').doc(doctorId);
  var doc=await docRef.get();
  if(doc.exists){
    Map<String,dynamic>data=doc.data() as Map<String,dynamic>;
    if(data['doctorModel']!=null){
      Map<String,dynamic>weeklySchedule =data['doctorModel']['weeklySchedule'];
     List<dynamic> dailySlots=List.from(weeklySchedule[DayName]);
     var slotToRemove=dailySlots.firstWhere((s)=>s['time']==SlotTime);

     dailySlots.remove(slotToRemove);
     weeklySchedule[DayName]=dailySlots;
     await docRef.update({
      'doctorModel.weeklySchedule': weeklySchedule
     });
    }
  }
  }
catch(e){
  print('Error deleting weekly slots: $e');
}
}
}