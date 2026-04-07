import 'package:service_app/models/appointment_model.dart';

sealed class SlotsState {}

final class SlotsInitial extends SlotsState {}
class slotsLoadingState extends SlotsState{
  
}
class slotsFailureState extends SlotsState{
   String errorMessage='falled to load the data';

  slotsFailureState({required this.errorMessage});
}
class slotsSuccessState extends SlotsState{
  final List<AppointmentModel>appointments;

  slotsSuccessState({required this.appointments});
  
}

