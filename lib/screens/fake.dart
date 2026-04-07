import 'package:flutter/material.dart';
import 'package:service_app/widgets/bottom_navigator_bar.dart';

class FakePage extends StatelessWidget {
  const FakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigatorBar( selectedIndex: 2,),
    );
  }
}