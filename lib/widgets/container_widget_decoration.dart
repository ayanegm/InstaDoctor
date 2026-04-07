import 'package:flutter/material.dart';

class ContainerWidgetDecoration extends StatelessWidget {
  const ContainerWidgetDecoration({super.key, required this.childWidget, required this.paddingValueHorizontal, required this.paddingValueVertical});
final Widget childWidget;
final double paddingValueHorizontal;
final double paddingValueVertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow:[ BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius:10,
          offset:  Offset(4, 4),

      )],
      ),
            padding: EdgeInsets.symmetric(horizontal: paddingValueHorizontal,vertical: paddingValueVertical),

      child:childWidget ,
    );
  }
}