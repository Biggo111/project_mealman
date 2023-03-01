import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/UserEnd/Drawers/MyDrawer.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/Item_order_page/cart_page.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  double screenSize;
  var resName;
  MyAppBar({super.key, required this.screenSize, this.resName});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.9);
  //Size get preferredSize => const Size(widget.screenSize,kToolbarHeight*1.9);
}

class _MyAppBarState extends State<MyAppBar> {
  //final size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  @override
  Widget build(BuildContext context) {
    final HeightofAppBar = MediaQuery.of(context).size.height;
    final WidthofAppBar = MediaQuery.of(context).size.width;
    return Container(
      //height: widget.screenSize/4,
      height: kToolbarHeight * 1.9,
      color: AppColors.mainColor,
      child: Column(
        children: [
          //const SizedBox(height: 1,),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 40,
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Text(
                widget.resName ?? "MealMan",
                style: TextStyle(
                  fontFamily: "Jua",
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: widget.screenSize / 2.5),
              //   // child: IconButton(
              //   //   icon: const Icon(Icons.shopping_cart),
              //   //   color: Colors.white,
              //   //   onPressed: () {
              //   //     //Get.to(()=>CartPage.empty());
              //   //   },
              //   // ),
              // ),
              // SizedBox(width: 60,),
              // SizedBox(
              //   height: 45,
              //   width: 150,
              //   child: FloatingActionButton(
              //     onPressed: () {
              //       //Get.to(() => );
              //     },
              //     elevation: 0,
              //     backgroundColor: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(40),
              //     ),
              //     child: const Text(
              //       "MealCoin: ",
              //       style: TextStyle(
              //         color: AppColors.mainColor,
              //         fontFamily: 'Ubuntu',
              //         fontSize: 18,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          Container(
            height: HeightofAppBar - 780,
            width: WidthofAppBar - 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            // child: TextField(
            //   decoration: const InputDecoration(
            //     //focusedBorder: InputBorder.none,
            //     border: InputBorder.none,
            //     focusColor: Colors.transparent,
            //     prefixIcon: Icon(
            //       Icons.search,
            //       color: AppColors.mainColor,
            //     ),
            //     hintText: "Search",
            //     hintStyle: TextStyle(
            //       color: Colors.black38,
            //       fontFamily: 'Ubuntu',
            //       fontSize: 20,
            //     ),
            //   ),
            //   //controller: loginEmailController,
            //   onChanged: (String value) {},
            // ),
          ),
        ],
      ),
    );
  }
}
