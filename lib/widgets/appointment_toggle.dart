import 'package:flutter/material.dart';
import 'package:service_app/const/constant.dart';

class AppointmentToggle extends StatefulWidget {
  const AppointmentToggle({super.key});

  @override
  State<AppointmentToggle> createState() => _AppointmentToggleState();
}
class _AppointmentToggleState extends State<AppointmentToggle> {
  bool isUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric( vertical: 10),
      child: Stack(
        children: [
          // LAYER 1: The solid blue border frame
          Container(
            decoration: BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          
          // LAYER 2: The white/blue buttons inside
          // Padding here acts as the "Border Thickness"
          Padding(
            padding: const EdgeInsets.all(1.5), 
            child: Row(
              children: [
                // --- Upcoming Button ---
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isUpcoming = true),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isUpcoming ? appColor : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(7),
                          bottomLeft: Radius.circular(7),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Upcoming',
                        style: TextStyle(
                          color: isUpcoming ? Colors.white : appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // LAYER 3: The sharp middle divider
                Container(width: 1.5, color: appColor),

                // --- Past Button ---
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isUpcoming = false),
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isUpcoming ? appColor : Colors.white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(7),
                          bottomRight: Radius.circular(7),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Past',
                        style: TextStyle(
                          color: !isUpcoming ? Colors.white : appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}