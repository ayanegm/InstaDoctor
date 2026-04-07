import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:service_app/widgets/container_widget_decoration.dart';

class AppointmentContainers extends StatelessWidget {
  const AppointmentContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidgetDecoration(
      paddingValueHorizontal: 16,
      paddingValueVertical: 15,
      childWidget:
    Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          
        ),child: Icon(Icons.person),),
        SizedBox(width: 13,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
            SizedBox(height: 15,),
            Text('Dr. Marta Lopez',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            Row(children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Color(0xFF577df2),
              ),
              SizedBox(width: 5,),
              Text('Memorial Drice MA',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color.fromARGB(255, 125, 125, 125),))
            ],)
          ],),
        ),
        
      Container(height: 70,width: 1.5, color: Color.fromARGB(255, 125, 125, 125),),
      SizedBox(width:30 ,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        SizedBox(height: 19,),
        Text('6:00',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 17),),
        SizedBox(height: 1.5,),
        Text('PM',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color.fromARGB(255, 125, 125, 125),),)
      ],),
      SizedBox(width: 10,)
    ]));
  }
}