import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:service_app/models/appointment_model.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  DateTime _combineDateAndTime(DateTime date, String timeStr) {
    try {
    DateTime timeParsed;
if (timeStr.contains('AM') || timeStr.contains('PM')) {
      timeParsed = DateFormat("hh:mm a").parse(timeStr);
    }    else {
      timeParsed = DateFormat("HH:mm:ss").parse(timeStr);
    }
    return DateTime(
      date.year,
      date.month,
      date.day,
      timeParsed.hour,
      timeParsed.minute,
    );
  }
  catch(e){
print("Format Error on timeStr: '$timeStr' -> $e");
return DateTime(date.year, date.month, date.day, 12, 0);
  }
  }
  Future<void>syncWeeklyToDaily({required String doctorId,required Map<String,dynamic>weeklySchedule})async{
    try{

    WriteBatch batch = _firestore.batch();
    if (doctorId.isEmpty) {
      print("Error: doctorId is empty!");
      return;
    }

    for(int i=0;i<7;i++){
      DateTime targetDate=DateTime.now().add(Duration(days: i));
      String dateId=DateFormat('yyyy-MM-dd').format(targetDate);
      String dayName = DateFormat('EEE').format(targetDate);
      DocumentReference dayRef=_firestore.collection('users').doc(doctorId).collection('daily_slots').doc(dateId);
      var doc=await dayRef.get();
      List<dynamic>templateSlots=weeklySchedule[dayName]??[];
      if(!doc.exists){
        
        // templateSlots.sort((a, b) => DateFormat("hh:mm a").parse(a['time']).compareTo(DateFormat("hh:mm a").parse(b['time'])));
       await dayRef.set( {
    'date': dateId,
    'dayName': dayName,
    'slots': templateSlots.map((slotData) {
      return AppointmentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // لا يوجد ID حجز فعلي بعد
        doctorName: "", // يمكنك تركه فارغاً هنا لتوفير المساحة
        time: _combineDateAndTime(targetDate, slotData['time']), // أخذ النص مباشرة "01:00 AM"
        date: targetDate, // التاريخ الفعلي لليوم
        status: 'available',
        patientId: null,
         isMorning:slotData['isMorning']??true ,
      ).toMap();
    }).toList()
  });
      }
      else{
        List<dynamic> existingSlots = List.from(doc.get('slots') ?? []);
        await dayRef.update({'slots': existingSlots});
        print("Updated existing slots for $dateId");
        List<DateTime> existingTimes = existingSlots.map((e) => (e['time'] as Timestamp).toDate()).toList();
          for (var x in templateSlots) {
          DateTime newSlotTime = _combineDateAndTime(targetDate, x['time']);
          if (!existingTimes.any((t) => t.isAtSameMomentAs(newSlotTime))) {
            existingSlots.add(AppointmentModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              doctorName: "",
              time: newSlotTime,
              date: targetDate,
              status: 'available',
              patientId: null,
              isMorning: x['isMorning']??true
            ).toMap());
          }
        }
existingSlots.sort((a, b) {
          DateTime timeA = (a['time'] is Timestamp) ? (a['time'] as Timestamp).toDate() : (a['time'] as DateTime);
          DateTime timeB = (b['time'] is Timestamp) ? (b['time'] as Timestamp).toDate() : (b['time'] as DateTime);
          return timeA.compareTo(timeB);
        });
        batch.update(dayRef, {'slots':existingSlots});
      }
    }
    await batch.commit();
    }
    catch(e){
      print('the error is  $e');
    }
  }
  Future<void> deleteSlot({required String doctorId,required String dateId,required DateTime slotTime})async{
    try{
      DocumentReference dayRef=_firestore.collection('users').doc(doctorId).collection('daily_slots').doc(dateId);
    var doc=await dayRef.get();
    if(doc.exists){
      List<dynamic>slots=doc.get('slots');
      var slotToRemove=slots.firstWhere((s)=>(s['time'] as Timestamp).toDate().isAtSameMomentAs(slotTime),
       orElse: () => null
       );
      if(slotToRemove !=null){
        await dayRef.update({
        'slots':FieldValue.arrayRemove([slotToRemove])
      });
      print('dleeted successfluyy');
      }
      else{
        print('slotis not found');
      }
    }

  }

     catch(e){
      print('Error dleeting slot: $e ');
    }
  }
  Future<void>AddSlot({required String dateId,required String timeSlot,required String doctorId})async{
    try{
      DocumentReference docRef=_firestore.collection('users').doc(doctorId).collection('daily_slots').doc(dateId);
      await docRef.set({
        'slots':FieldValue.arrayUnion([{
          'time':timeSlot,
          'status':'available',
          'patientId':null
        }])
      },SetOptions(merge: true));
      print('Slot added successfully to ${dateId}');
    }
    catch(e){
      print('error adding slot: $e');
    }
  }
  Future<void>updateStatus({required DateTime appointmentTime,required String patientId,required String doctorId,required String newStatus})async{
    String dateId=DateFormat('yyyy-MM-dd').format(appointmentTime);

    DocumentReference doctorDoc=_firestore.collection('users').doc(doctorId).collection('daily_slots').doc(dateId);
    DocumentReference patientDoc=_firestore.collection('users').doc(patientId);
    WriteBatch batch=_firestore.batch();
    try{
      DocumentSnapshot dbSnapshot=await doctorDoc.get();
      if(dbSnapshot.exists){
        List slots=List.from(dbSnapshot.get('slots')??[]);
        for (var s in slots){
          if(s['time']==Timestamp.fromDate(appointmentTime)){
            s['status']=newStatus;
            break;
          }
          
        }
        batch.update(doctorDoc, {'slots':slots});
      }
      DocumentSnapshot pSnapshot=await patientDoc.get();
      if(pSnapshot.exists){
        List appointmentList=List.from(pSnapshot.get('appointmentList')??[]);
        for(var app in appointmentList){
          if(app['time']==Timestamp.fromDate(appointmentTime)&& app['doctorId']==doctorId){
            app['status']=newStatus;
            break;
          }
        }
        batch.update(patientDoc, {'appointmentList':appointmentList});
      }
      
      await batch.commit();
    }
    catch(e){
throw Exception("Failed to update appointment: $e");
    }

  }
}