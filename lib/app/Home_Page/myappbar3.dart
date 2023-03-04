import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/UserEnd/Drawers/MyDrawer.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/Item_order_page/cart_page.dart';

class MyAppBar3 extends StatefulWidget implements PreferredSizeWidget {
  double screenSize;
  var resName;
  MyAppBar3({super.key, required this.screenSize, this.resName});

  @override
  State<MyAppBar3> createState() => _MyAppBar3State();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.9);
  //Size get preferredSize => const Size(widget.screenSize,kToolbarHeight*1.9);
}

class _MyAppBar3State extends State<MyAppBar3> {
  //final size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;

  // Future<String> getBalance() async {
  //   String myName;
  //   String creditAmount="";
  //   List<String>creditUsers=[];
  //   User? user = FirebaseAuth.instance.currentUser;
  //   //Logger().i("Inside the try ${user!.uid}")
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection("Authenticated_User_Info")
  //       .doc(user!.uid)
  //       .get();
  //     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //     // Logger().i(snapshot.data());

  //     myName = data['name'];
  //     //Logger().i(myName);

  //   final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await FirebaseFirestore.instance
  //           .collection("${widget.resName} User Credit list")
  //           .where('Username', isEqualTo: myName)
  //           .get();
  //   querySnapshot.docs.forEach((doc) {
  //     Map<String, dynamic> docData = doc.data();
  //     Logger().i(" The doc Data ${doc.data()}");
  //     creditUsers.add(docData['Credit']);
  //     Logger().i(docData['Credit']);
  //   });
  //   return creditAmount;
  // }

  @override
  Widget build(BuildContext context) {
    final HeightofAppBar = MediaQuery.of(context).size.height;
    final WidthofAppBar = MediaQuery.of(context).size.width;
    return Container(
      //height: widget.screenSize/4,
      height: kToolbarHeight * 1.4,
      color: AppColors.mainColor,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
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
                  fontSize: 34.sp,
                  letterSpacing: 8.5.sp,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              // widget.resName != null
              //     ? FutureBuilder(builder: (context, snapshot) {
              //         return Text(
              //           snapshot.data.toString()==null ? "0 Coins" : snapshot.data.toString(),
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontFamily: "Jua",
              //             fontSize: 20,
              //           ),
              //         );
              //       })
              //     : Text(""),
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
