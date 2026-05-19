
import 'dart:async'; // نحتاج هذا للـ StreamSubscription
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:service_app/logic/cubit/daily_slots_state.dart';
import 'package:service_app/models/appointment_model.dart';

class DailySlotsCubit extends Cubit<SlotsState> {
  String id = FirebaseAuth.instance.currentUser!.uid;
  StreamSubscription? _slotsSubscription; 

  DailySlotsCubit() : super(SlotsInitial());

  void getDailySlots(String? customDateId) {
    emit(slotsLoadingState());

    _slotsSubscription?.cancel();

    String dateId = customDateId ?? DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      // نستخدم snapshots() بدلاً من get() لفتح اتصال حي
      _slotsSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('daily_slots')
          .doc(dateId)
          .snapshots()
          .listen((docSnapshot) {
        
        if (docSnapshot.exists && docSnapshot.data() != null) {
          List<dynamic> slotRaw = docSnapshot.data()!['slots'] ?? [];
          List<AppointmentModel> todayAppointments = slotRaw.map((item) {
            return AppointmentModel.fromMap(item as Map<String, dynamic>);
          }).toList();
          
          // سيقوم الـ Cubit بإرسال الحالة الجديدة تلقائياً فور حدوث أي تغيير في Firebase
          emit(slotsSuccessState(appointments: todayAppointments));
        } else {
          emit(slotsSuccessState(appointments: []));
        }
      }, onError: (e) {
        emit(slotsFailureState(errorMessage: e.toString()));
      });
    } catch (e) {
      emit(slotsFailureState(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _slotsSubscription?.cancel(); // إغلاق الاشتراك عند تدمير الـ Cubit
    return super.close();
  }
}
