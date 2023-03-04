// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project_mealman/app/core/app_colors.dart';
// import 'package:project_mealman/app/screens/UserEnd/Drawers/MyDrawer.dart';
// import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/Item_order_page/cart_page.dart';

// class MyAppBar5 extends StatefulWidget implements PreferredSizeWidget {
//   double screenSize;
//   var resName;
//   MyAppBar5({super.key, required this.screenSize, this.resName});

//   @override
//   State<MyAppBar5> createState() => _MyAppBar5State();
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.9);
//   //Size get preferredSize => const Size(widget.screenSize,kToolbarHeight*1.9);
// }

// class _MyAppBar5State extends State<MyAppBar5> {
//   //final size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
//     bool _isBalencedShow=false;
//     bool _isAnimation=false;
//     bool _isBalance = true;
//   @override
//   Widget build(BuildContext context) {
//     final HeightofAppBar = MediaQuery.of(context).size.height;
//     final WidthofAppBar = MediaQuery.of(context).size.width;
//     return Container(
//       //height: widget.screenSize/4,
//       height: kToolbarHeight * 1.4,
//       color: AppColors.mainColor,
//       child: Column(
//         children: [
//           const SizedBox(height: 10,),
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.menu),
//                 iconSize: 40,
//                 color: Colors.white,
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//               ),
//               Text(
//                 widget.resName ?? "MealMan",
//                 style: TextStyle(
//                   fontFamily: "Jua",
//                   color: Colors.white,
//                   fontSize: 34,
//                   letterSpacing: 8.5,
//                 ),
//               ),
//             InkWell(
//             onTap: changeState(),
//             child: Container(
//               width: 160,
//               height: 28,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(40),
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   AnimatedOpacity(
//                   opacity: _isBalencedShow ? 1 : 0,
//                   duration: Duration(seconds: 2),
//                   child: Text("50coins", style: TextStyle(color: AppColors.mainColor),),
//                   ),
//                   AnimatedOpacity(
//                   // ignore: dead_code
//                   opacity: _isBalance ? 1 : 0,
//                   duration: Duration(seconds: 2),
//                   child: Text("Check Balance", style: TextStyle(color: AppColors.mainColor),),
//                   ),
//                   AnimatedPositioned(
//                     child: Container(
//                       height: 30,
//                       width: 30, 
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(40),
//                     ),                   
//                     child: Text("(C)  ", style: TextStyle(color: AppColors.mainColor),),
//                     ), 
//                     duration: Duration(milliseconds: 1100),
//                     left: _isAnimation==false ? 5 : 135,
//                     curve: Curves.fastOutSlowIn,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
  
//   // changeState() async{
//   //   _isAnimation = true;
//   //   _isBalance = false;
//   //   setState(() {
      
//   //   });
//   //   await Future.delayed(Duration(milliseconds: 800),
//   //   ()=>setState(()=>_isBalencedShow=true)
//   //   );
//   //   await Future.delayed(Duration(milliseconds: 300),
//   //   ()=>setState(()=>_isAnimation=false)
//   //   );
//   //   await Future.delayed(Duration(milliseconds: 800),
//   //   ()=>setState(()=>_isBalance=true) 
//   //   );
//   // }
// }
