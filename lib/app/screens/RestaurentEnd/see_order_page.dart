import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/order_history2.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/orderstab.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/restaurent_home_screen.dart';
import 'package:intl/intl.dart';
import '../../core/app_colors.dart';
import '../UserEnd/Drawers/MyDrawer.dart';
//import 'package:image_uploader/widgets/drawer.dart';
 
class SeeOrderPage extends StatefulWidget {
  String userName;
  String userEmail;
  String userPhone;
  String paymentMethod;
  String userLocation;
  int totalPrice;
  List items;
  String orderTime;
  String orderDate;
  SeeOrderPage({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.paymentMethod,
    required this.userLocation,
    required this.totalPrice,
    required this.items,
    required this.orderTime,
    required this.orderDate,
  });
 
  @override
  State<SeeOrderPage> createState() => _SeeOrderPageState();
}
 
class _SeeOrderPageState extends State<SeeOrderPage> {
  String timeNow = DateFormat('h:mm a').format(DateTime.now());
  String date = DateFormat('dd:MM:yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: HexColor("EDDFDF"),
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image:
        //             AssetImage("assets/restaurent_thumbnails/see_order_page.png"),
        //         fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            title: Text(
              "Confirm Order",
              style: TextStyle(fontSize: 20,color:Colors.white),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getOrderUsernameAndOrder(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  Widget _getOrderUsernameAndOrder() {
    Logger().i(widget.userName);
    return Container(
        child: Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.userName,
            style: TextStyle(
                fontSize: 25.sp, fontWeight: FontWeight.bold, color: Colors.black),
          ), //fetch from cart database
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Ordered Item:",
            style: TextStyle(fontSize: 25.sp, color: Colors.black),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
               color: Colors.white,
              borderRadius: BorderRadius.circular(20.r)
            ),
 
            height: 270.h,
            width: double.infinity,
            child: ListView.separated(
              padding: EdgeInsets.all(2.sp),
              itemCount:
                  widget.items.length, // as per number of orders in database
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("FE7C00"),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    height: 60.h,
                    child: Padding(
                      padding: EdgeInsets.all(16.0.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //get all data from cart for the following texts
                          Text(
                            "${widget.items[index]['quantity']}X",
                            style: TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                          Text(
                            widget.items[index]["itemName"],
                            style: TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                          Text(
                            "${widget.items[index]['itemPrice']}TK",
                            style: TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
 
          Container(
              height: 300.w,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: HexColor("FE7C00"),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Padding(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Phone: ",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          widget.userPhone, //get from database
                          style: TextStyle(fontSize: 20.sp, color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Email: ",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Expanded(
                          child: Text(
                            widget.userEmail, //get from database
                            style: TextStyle(fontSize: 20.sp, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 75.h,
                          width: 100.w,
                          child: Text(
                            "Location:",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          height: 75.h,
                          width: 200.w,
                          child: Text(
                            widget.userLocation, //get from database
                            style: TextStyle(fontSize: 20.sp, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Payment Method: ",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          widget.paymentMethod,
                          style: TextStyle(fontSize: 20.sp, color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Order Time: ",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          widget.orderTime,
                          style: TextStyle(fontSize: 20.sp, color: Colors.white),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          widget.orderDate,
                          style: TextStyle(fontSize: 20.sp, color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Total: ",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "${widget.totalPrice}TK",
                          style: TextStyle(fontSize: 20.sp, color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    _getOrderConfirmButton(context),
                  ],
                ),
              )),
        ],
      ),
    ));
  }
 
  Widget _getOrderConfirmButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300.w,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0.r)),
              ),
              onPressed: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Order Confirmed",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Jua"),
                        ),
                        content: Text(
                          "Please Get The Order Ready!",
                          style: TextStyle(fontSize: 17.sp, fontFamily: "Ubuntu"),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              // User? user = FirebaseAuth.instance.currentUser;
                              // String _resName;
                              // DocumentSnapshot snapshot =
                              //     await FirebaseFirestore.instance
                              //         .collection("Authenticated_User_Info")
                              //         .doc(user!.uid)
                              //         .get();
                              // if (snapshot.exists) {
                              //   Map<String, dynamic> data =
                              //       snapshot.data() as Map<String, dynamic>;
                              //   // Logger().i(snapshot.data());
 
                              //   _resName = data['name'];
                              // } else {
                              //   _resName = "No data found for the user";
                              // }
                              //         await FirebaseFirestore
                              //         .instance
                              //         .collection("$_resName Orders")
                              //         .doc()
                              //         .delete();
                              Get.to(() => const OrderHistory2());
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(color: AppColors.mainColor),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                });
              },
              child: Text(
                "Confirm Order",
                style: TextStyle(fontSize: 20.sp, color: HexColor("FE7C00")),
              )),
        ),
      ],
    );
  }
}