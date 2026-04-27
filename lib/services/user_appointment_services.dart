import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_app/models/appointment_model.dart';

class UserAppointmentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 1. GET: Stream of appointments for a specific user (Patient)
  Stream<DocumentSnapshot> getUserDocStream(String userId) {
    return _db.collection('users').doc(userId).snapshots();
  }

  // 2. GET: Stream of daily slots for a specific doctor
  Stream<DocumentSnapshot> getDailySlotsStream(String doctorId, String dateId) {
    return _db
        .collection('users')
        .doc(doctorId)
        .collection('daily_slots')
        .doc(dateId)
        .snapshots();
  }

  // 3. ADD: Process a booking
  Future<void> bookAppointment({
    required String patientId,
    required String doctorId,
    required String dateId,
    required AppointmentModel appointment,
    required Map<String, dynamic> selectedSlot,
  }) async {
    // A. Update the Patient's appointment list
    await _db.collection('users').doc(patientId).update({
      'appointmentList': FieldValue.arrayUnion([appointment.toMap()])
    });

    // B. Update the Doctor's daily slots status
    DocumentReference dayRef = _db
        .collection('users')
        .doc(doctorId)
        .collection('daily_slots')
        .doc(dateId);

    var dayDoc = await dayRef.get();
    if (dayDoc.exists) {
      List<dynamic> slots = List.from(dayDoc.get('slots'));
      for (var i = 0; i < slots.length; i++) {
        // Compare the timestamps to find the right slot
        if (slots[i]['time'] == selectedSlot['time']) {
          slots[i]['status'] = 'booked';
          slots[i]['patientId'] = patientId;
          break;
        }
      }
      await dayRef.update({'slots': slots});
    }
  }

  // 4. DELETE: Remove a slot (The function you had in your dialog)
  Future<void> deleteSlot({
    required String? doctorId,
    required String dateId,
    required DateTime slotTime,
  }) async {
    if (doctorId == null) return;
    
    DocumentReference dayRef = _db
        .collection('users')
        .doc(doctorId)
        .collection('daily_slots')
        .doc(dateId);

    var dayDoc = await dayRef.get();
    if (dayDoc.exists) {
      List<dynamic> slots = List.from(dayDoc.get('slots'));
      slots.removeWhere((slot) {
        DateTime time = (slot['time'] as Timestamp).toDate();
        return time.isAtSameMomentAs(slotTime);
      });
      await dayRef.update({'slots': slots});
    }
  }
}