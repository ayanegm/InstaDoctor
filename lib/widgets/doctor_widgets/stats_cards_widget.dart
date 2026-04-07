import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';

class StatsCardsWidget extends StatelessWidget {
   StatsCardsWidget({super.key,required this.title,required this.numberOfTasks});
String title;
int numberOfTasks;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:appColor,
      ),
      
      width: 150,
      height: 70,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
          Text(numberOfTasks.toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
        ],
      ) ,

    );
  }
}