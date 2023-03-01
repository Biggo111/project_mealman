import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/Home_Page/gridview_item.dart';
import 'package:project_mealman/app/Home_Page/myappbar.dart';
import 'package:project_mealman/app/Home_Page/myappbar3.dart';
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
        appBar: MyAppBar3(
          screenSize: screenSize,
        ),
        body: Column(
          children: [
            const SlideView(),
            Expanded(
              //flex: 1,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    childAspectRatio: 9 / 8
                  ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    //margin: EdgeInsets.only(top: 12, bottom: 10),
                    padding: const EdgeInsets.only(top: 18, bottom: 14),
                    child: GridviewItem(index: index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
