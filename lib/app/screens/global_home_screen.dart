import 'package:flutter/material.dart';
import 'package:project_mealman/app/Home_Page/myappbar.dart';
import 'package:project_mealman/app/Home_Page/slide_view.dart';

class GlobalHomeScreen extends StatefulWidget {
  const GlobalHomeScreen({super.key});

  @override
  State<GlobalHomeScreen> createState() => _GlobalHomeScreenState();
}

class _GlobalHomeScreenState extends State<GlobalHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(screenSize: screenSize,),
        body: Column(
          children: [
            SlideView(),
          ],
        ),
      ),
    );
  }
}