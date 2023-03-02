import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/Home_Page/gridview_item.dart';
import 'package:project_mealman/app/Home_Page/myappbar.dart';
import 'package:project_mealman/app/Home_Page/myappbar3.dart';
import 'package:project_mealman/app/Home_Page/slide_view.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/UserEnd/Drawers/MyDrawer.dart';

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
        drawer: const MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, size: 40,),
            color: AppColors.mainColor,
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
          ),
          title: const Text("MealMan", style: TextStyle(
            letterSpacing: 4,
            color: AppColors.mainColor,
            fontFamily: "Jua",
            fontSize: 40,
          ),),
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
