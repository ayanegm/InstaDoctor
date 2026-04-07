import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_app/const/constant.dart';

class HorizontalDateSelector extends StatefulWidget {
  const HorizontalDateSelector({super.key, required this.onDataSelected});
final Function(DateTime) onDataSelected;
  @override
  State<HorizontalDateSelector> createState() => _HorizontalDateSelectorState();
}

class _HorizontalDateSelectorState extends State<HorizontalDateSelector> {
List<DateTime>days=[];
void initState(){
  super.initState();
days=List.generate(7, (index){
  return DateTime.now().add(Duration(days: index));
});
}


DateTime selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
        DateTime date=days[index];
        bool isSelected=date.day==selectedDate.day&&date.month ==selectedDate.month;
        return GestureDetector(
          onTap: () {
           selectedDate=date;
            widget.onDataSelected(date);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: isSelected?Border(bottom:BorderSide(color: appColor,width: isSelected ? 3.0 : 0.0,) ):null
            ),
            width: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text(
                DateFormat('EEE').format(date),
                style: TextStyle(
                  color: isSelected?appColor:greycolor,
                  fontWeight: FontWeight.w600 
                ),
                
              ),
              SizedBox(height: 5,),
              Text(
              DateFormat('d MMM').format(date),
              style: TextStyle(
                    color: isSelected ? Colors.blue : greycolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
              ),
              
            ],)
            ),
        );
      },
      itemCount: days.length,),
      
    );
  }
}
