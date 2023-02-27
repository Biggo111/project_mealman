import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/beverage_type_tab.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/fastfood_type_tab.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/rice_type_tab.dart';

import '../../../Home_Page/myappbar.dart';
import '../../../Utils/diamensions.dart';
import '../../../core/app_colors.dart';

class RestaurantPageScreen extends StatefulWidget {
  String resname;
  RestaurantPageScreen({super.key, required this.resname});

  @override
  State<RestaurantPageScreen> createState() => _RestaurantPageScreenState();
}

class _RestaurantPageScreenState extends State<RestaurantPageScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController thisTabController = TabController(length: 3, vsync: this);
    final restaurentScreenSize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          screenSize: restaurentScreenSize,
          resName: "",
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Diamensions.paddingAll8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Diamensions.borderRadius40),
                  //border: Border.all(),
                  color: Colors.white,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(Diamensions.borderRadius40),
                    color: AppColors.mainColor,
                  ),
                  unselectedLabelColor: AppColors.mainColor,
                  controller: thisTabController,
                  tabs: const [
                    Tab(
                      child: Text(
                        'Rice',  
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Jua',
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Fast Food',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Jua',
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Beverage',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Jua',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: thisTabController,
                children: [
                  RiceTypeTab(restaurantName: widget.resname),
                  FastFoodTypeTab(restaurantName: widget.resname),
                  BeverageTypeTab(restaurantName: widget.resname,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
