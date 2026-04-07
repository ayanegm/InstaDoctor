import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime today=DateTime.now();
  DateTime selectedDay=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calnder'),),
      body: ListView(
        children: [
          TableCalendar(
            rowHeight: 43,headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),
            focusedDay: today,
             firstDay: DateTime(2025,6,20),
             lastDay: DateTime(2030,3,14),
             calendarStyle: CalendarStyle(
             selectedDecoration: BoxDecoration(
                color: appColor,
                shape:BoxShape.circle
              ),
              todayDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 170, 187, 237),
                shape: BoxShape.circle,
              ),
             ),
            selectedDayPredicate: (day)=>isSameDay(day,today),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                today=selectedDay;
                selectedDay=selectedDay;
              });
            },
          )
        ],
      ),
    );
  }
}