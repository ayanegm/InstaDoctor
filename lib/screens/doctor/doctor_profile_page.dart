import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/widgets/doctor_widgets/doctor_profile_card_widget.dart';

class DoctorProfilePage extends StatefulWidget {
 DoctorProfilePage({super.key,required this.doctor});
UserModel doctor;
  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}
class _DoctorProfilePageState extends State<DoctorProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        title: const Text('Doctor Profile', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(color: appColor, height: 120, width: double.infinity),
              DoctorProfileCardWidget(doctor: widget.doctor),
            ]),
            // استبدلنا الـ TabBar بهذا الـ Container الذي يحتوي على بيانات الـ About
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildAboutContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // وصف الطبيب
        Text(
          widget.doctor.doctorModel?.bio ?? 'No description available',
          style: TextStyle(color: Colors.grey[700], height: 1.5),
        ),
        const SizedBox(height: 30),
        
        // المؤهلات
        const Text('Qualification', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          widget.doctor.doctorModel?.Speciality ?? 'Not specified',
          style: TextStyle(color: Colors.grey[700], height: 1.5),
        ),
        const SizedBox(height: 30),
        
        // أوقات العمل
        const Text('Working Time', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          widget.doctor.doctorModel?.bio ?? 'Not specified',
          style: TextStyle(color: Colors.grey[700], height: 1.5),
        ),
        const SizedBox(height: 30),
        
        // العنوان
        const Text('Address', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          widget.doctor.doctorModel?.location ?? 'Not specified',
          style: TextStyle(color: Colors.grey[700], height: 1.5),
        ),
      ],
    );
  }
}