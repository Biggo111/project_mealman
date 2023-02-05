import 'package:flutter/material.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/homesellertab.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/itemstab.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/orderstab.dart';

import '../../Home_Page/myappbar.dart';
import '../../core/app_colors.dart';

class RestaurentHomeScreen extends StatefulWidget {
  const RestaurentHomeScreen({super.key});

  @override
  State<RestaurentHomeScreen> createState() => _RestaurentHomeScreenState();
}

class _RestaurentHomeScreenState extends State<RestaurentHomeScreen>
    with TickerProviderStateMixin {
  var resName = "Sarah's Cafe";
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    final restaurentScreenSize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          screenSize: restaurentScreenSize,
          resName: resName,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  //border: Border.all(),
                  color: Colors.white,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors.mainColor,
                  ),
                  controller: tabController,
                  //isScrollable: true,
                  //labelPadding: const EdgeInsets.symmetric(horizontal: 35),
                  unselectedLabelColor: AppColors.mainColor,
                  tabs: const [
                    Tab(
                      child: Text(
                        'SellerHome',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Jua',
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Orders',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Jua',
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Items',
                        style: TextStyle(
                          fontSize: 20,
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
                controller: tabController,
                children: const [
                  // ListView.builder(itemBuilder: (_, index) {
                  //   return Container(
                  //     //height: 300,
                  //     //width: 200,
                  //     child: HomeSellerTab(),
                  //   );
                  // }),
                  HomeSellerTab(),
                  OrdersTab(),
                  ItemsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
