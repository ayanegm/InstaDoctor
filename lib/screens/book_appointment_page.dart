import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/services/appointment_service.dart';
import 'package:service_app/models/appointment_model.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/services/user_appointment_services.dart';
import 'package:service_app/widgets/custom_register_button.dart';
import 'package:service_app/widgets/selected_time_booking_appointment_contaiener.dart';
import 'package:service_app/widgets/time_booking_appointment_container.dart';
import 'package:service_app/widgets/doctor_widgets/doctor_profile_card_widget.dart';
import 'package:service_app/widgets/horizontal_date_selector.dart';
import 'package:service_app/widgets/user_appointment_slot.dart';

class BookAppointmentPage extends StatefulWidget {
  BookAppointmentPage({super.key, required this.doctor});
  final UserModel doctor;

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  final AppointmentService _appointmentService = AppointmentService();
  final UserAppointmentService _userAppointmentService=UserAppointmentService();
  DateTime selectedDate = DateTime.now();
  bool isLoading = true;
  UserModel? user;
  Map<String, dynamic>? selectedSlot;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    getAppointments();
  }

  void getAppointments() async {
    var userId = widget.doctor.uid;
    if (userId == null) return;

    var doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      user = UserModel.fromMap(doc.data()!);
      await _appointmentService.syncWeeklyToDaily(
          doctorId: userId, weeklySchedule: user!.doctorModel!.weeklySchedule);
    }

    setState(() {
      isLoading = false;
    });
  }

  void _showDeleteDialog(BuildContext context, Map<String, dynamic> slot, String dateId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Appointment'),
          content: Text('Are you sure you want to delete this slot?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _appointmentService.deleteSlot(
                    doctorId: widget.doctor.uid,
                    dateId: dateId,
                    slotTime: (slot['time'] as Timestamp).toDate());
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            )
          ],
        );
      },
    );
  }
Future<void> bookAppoinment() async {
  if (selectedSlot == null) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please select a time slot first!')));
    return;
  }
  
  if (selectedSlot!['status'] == 'booked') {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This slot is no longer available.')));
    return;
  }

  setState(() => isLoading = true);

  try {
    var patientId = FirebaseAuth.instance.currentUser!.uid;
    String dateId = DateFormat('yyyy-MM-dd').format(selectedDate);
    
    AppointmentModel newAppointment = AppointmentModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        doctorName: widget.doctor.name,
        time: (selectedSlot!['time'] as Timestamp).toDate(),
        date: selectedDate,
        status: 'booked',
        isMorning: selectedSlot!['isMorning'] ?? true,
        patientId: patientId);

    // --- MISSING PART 1: Call the Service ---
    await _userAppointmentService.bookAppointment(
      patientId: patientId,
      doctorId: widget.doctor.uid!,
      dateId: dateId,
      appointment: newAppointment,
      selectedSlot: selectedSlot!,
    );

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment booked successfully!')));
    
    // Optional: Reset selection after booking
    setState(() => selectedSlot = null);

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking failed: $e')));
  } finally {
    setState(() => isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    String dateId = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Book Appointment',
          style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView( // أضفنا هذا لضمان عدم حدوث Overflow عند كثرة العناصر
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorProfileCardWidget(doctor: widget.doctor),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: HorizontalDateSelector(
                  onDataSelected: (date) {
                    setState(() {
                      selectedDate = date;
                      selectedSlot = null; // إعادة تعيين الاختيار عند تغيير التاريخ
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Available Slots',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              StreamBuilder<DocumentSnapshot>(

              stream: _userAppointmentService.getDailySlotsStream(widget.doctor.uid!, dateId),
  builder: (context, snapshot) {
    if (snapshot.hasError) return const Text('Something went wrong');
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (!snapshot.hasData || !snapshot.data!.exists) {
      return const Center(child: Text('No slots available for this day'));
    }

    var data = snapshot.data!.data() as Map<String, dynamic>;
    // The rest of your UI logic (slots.where, GridView.builder) remains the same
    List<dynamic> slots = data['slots'] ?? [];
            
List<dynamic> morningSlots = slots.where((s) => s['isMorning'] == true).toList();
    List<dynamic> eveningSlots = slots.where((s) => s['isMorning'] == false).toList();
                  if (slots.isEmpty) return const Center(child: Text('No slots available'));

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: slots.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.8,
                    ),
                    itemBuilder: (context, index) {
  var slot = slots[index];
  
String currentStatus = slot['status'] ?? 'available';
  
  bool isSelected = selectedSlot != null && 
      selectedSlot!['time'] == slot['time'];

  String formattedTime = DateFormat('hh:mm').format((slot['time'] as Timestamp).toDate());

 return GestureDetector(
    // لا يسمح بالمسح أو الضغط إلا إذا كانت الحالة 'available'
    onLongPress: currentStatus == 'available' 
        ? () => _showDeleteDialog(context, slot, dateId) 
        : null,
    onTap: currentStatus == 'available' 
        ? () {
            setState(() {
              selectedSlot = slot;
            });
          } 
        : null,
    
    child: isSelected 
        ? SelectedTimeBookingAppointmentContaiener(
            time: formattedTime, 
            isSelected: true, 
            isMorning: slot['isMorning'],
          )
        : TimeBookingAppointmentContainer(
            time: formattedTime, 
            isSelected: false, 
            isMorning: slot['isMorning'],
            status: currentStatus, // نمرر الـ status النصي هنا
          ),
  );
},
                  );
                },
              ),
              const SizedBox(height: 50),
              Center(
                child: CustomRegisterButton(
                  width: 300,
                  buttonName: 'CONFIRM BOOKING',
                  onTap: bookAppoinment,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}