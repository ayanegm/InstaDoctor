import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/models/user_model.dart';
import 'package:service_app/widgets/available_doctor_container.dart';
import 'package:service_app/widgets/doctor_widgets/doctor_profile_card_widget.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key, required this.speciality});
  final String? speciality;
  @override
  Widget build(BuildContext context) {

double screenWidth=MediaQuery.of(context).size.width;
int crossAxisCount;
double aspectRatio;
if(screenWidth<600){
  crossAxisCount=1;
  aspectRatio = 2;
}
else if(screenWidth<1100){
  crossAxisCount=2;
  aspectRatio = 1.3;
}
else {
  crossAxisCount=3;
  aspectRatio = 1.6;

}
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: backgroundColor,title: Text('$speciality Department',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').where('isDoctor',isEqualTo: true).where('doctorModel.Speciality', isEqualTo: speciality).snapshots(),
           builder: (context, snapshot) {
             if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
             }
             if(!snapshot.hasData|| snapshot.data!.docs.isEmpty){
              return _buildEmptyState(context);
             }
             return GridView.builder(
              padding: const EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: aspectRatio

          ),
              itemBuilder: (context, index) {
                var data=snapshot.data!.docs[index].data() as Map<String,dynamic>;
                UserModel doctorModel=UserModel.fromMap(data);
                return AvailableDoctorContainer(doctor:doctorModel);
              },
              itemCount: snapshot.data!.docs.length,
             );
           },
           ),
      ) ,
    );
  }
}

Widget _buildEmptyState(context){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No doctors available in this speciality yet."),
      ],
    ),
  );
}