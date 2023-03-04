import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/addevent.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/credit_approval.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/order_history.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/order_history2.dart';
import 'package:project_mealman/app/screens/UserEnd/Drawers/MyDrawer.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/Item_order_page/cart_page.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPart/restaurant_list.dart';
 
class MyAppBar4 extends StatefulWidget implements PreferredSizeWidget {
  double screenSize;
  var resName;
  MyAppBar4({super.key, required this.screenSize, this.resName});
 
  @override
  State<MyAppBar4> createState() => _MyAppBar4State();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.9);
  //Size get preferredSize => const Size(widget.screenSize,kToolbarHeight*1.9);
}
 
class _MyAppBar4State extends State<MyAppBar4> {
  void handleClick(String value) {//method for handling 3 dot button
    switch (value) {
      case 'MealCoin Req':
      Navigator.of(context).push(MaterialPageRoute(builder: (c)=> CreditApproval()));//Mealcoin request page
        break;
      case 'Order History':
       //Navigator.of(context).push(MaterialPageRoute(builder: (c)=> const OrderHistory2()));// Order history page
       Get.to(()=> const OrderHistory2());
        break;
 
    }
  }
 
  //final size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  @override
  Widget build(BuildContext context) {
    final HeightofAppBar = MediaQuery.of(context).size.height;
    final WidthofAppBar = MediaQuery.of(context).size.width;
    return Container(
      //height: widget.screenSize/4,
      //height: kToolbarHeight * 1.9,
      height: 60.w,
     // color: AppColors.mainColor,
     color: HexColor("FF7E00"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const SizedBox(height: 1,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 40.sp,
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
                  fontSize: 30.sp,
                ),
              ),
 
              SizedBox(
                width: 40.w,
              ),
 
              Container(//Here is the 3 dot button for appbar
                //color: Colors.red,
                width: 200.w,
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String>(
 
                      icon: Icon(Icons.more_vert, color: Colors.white,size: 30.sp,),
 
                      onSelected: handleClick,
                      itemBuilder: (BuildContext context) {
                        return {'MealCoin Req', 'Order History'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
              )
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
              //SizedBox(width: 20,),
            ],
          ),
 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SizedBox(
              //   height: 45,
              //   width: 110,
              //   child: FloatingActionButton(
              //     onPressed: () {
              //       //Get.to(() => );
              //       Get.to(() => CreditApproval());
              //     },
              //     elevation: 2,
              //     backgroundColor: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Text(
              //       "MealCoin Requests",
              //       style: TextStyle(
              //         color: AppColors.mainColor,
              //         fontFamily: 'Ubuntu',
              //         fontSize: 15,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 45,
              //   width: 140,
              //   child: FloatingActionButton(
              //     onPressed: () {
              //       //Get.to(() => );
              //       Get.to(() => const OrderHistory2());
              //     },
              //     elevation: 2,
              //     backgroundColor: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Text(
              //       "Orders History",
              //       style: TextStyle(
              //         color: AppColors.mainColor,
              //         fontFamily: 'Ubuntu',
              //         fontSize: 15,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 45.h,
              //   width: 140.w,
              //   child: FloatingActionButton(
              //     onPressed: () {
              //       //Get.to(() => );
              //       Get.to(() => const AddEvent());
              //     },
              //     elevation: 2,
              //     backgroundColor: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.r),
              //     ),
              //     child:  Text(
              //       "Manage Event",
              //       style: TextStyle(
              //         color: AppColors.mainColor,
              //         fontFamily: 'Ubuntu',
              //         fontSize: 15.sp,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          // Container(
          //   height: HeightofAppBar - 780,
          //   width: WidthofAppBar - 30,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(40),
          //     color: Colors.white,
          //   ),
          //   child: TextField(
          //     decoration: const InputDecoration(
          //       //focusedBorder: InputBorder.none,
          //       border: InputBorder.none,
          //       focusColor: Colors.transparent,
          //       prefixIcon: Icon(
          //         Icons.search,
          //         color: AppColors.mainColor,
          //       ),
          //       hintText: "Search",
          //       hintStyle: TextStyle(
          //         color: Colors.black38,
          //         fontFamily: 'Ubuntu',
          //         fontSize: 20,
          //       ),
          //     ),
          //     //controller: loginEmailController,
          //     onChanged: (String value) {},
          //   ),
          // ),
        ],
      ),
    );
  }
}