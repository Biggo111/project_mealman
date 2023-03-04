import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/restaurant_page_screen.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPart/restaurant_list.dart';
import 'package:intl/intl.dart';
import '../../../../Modules/UserEndModels/order_model.dart';
//import 'package:image_uploader/widgets/drawer.dart';

class CartPage extends StatefulWidget {
  String itemName;
  String imageURL;
  String itemPrice;
  String restaurantName;
  int quantity;
  CartPage({
    super.key,
    required this.itemName,
    required this.imageURL,
    required this.itemPrice,
    required this.restaurantName,
    required this.quantity,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

List<Map<String, dynamic>> totalItems = [];

class _CartPageState extends State<CartPage> {
  String dropdownvalue = 'COD';

  TextEditingController locationController = TextEditingController();
  // List of items in our dropdown menu
  var items = [
    'COD',
    'Mealcoin',
    'Bkash',
  ];
  int totalPrice = 0;
  @override
  void initState() {
    super.initState();
    totalItems.add({
      'itemName': widget.itemName,
      'itemPrice': widget.itemPrice,
      'imageURL': widget.imageURL,
      'quantity': widget.quantity,
    });
    for (var i = 0; i < totalItems.length; i++) {
      totalPrice += int.parse(totalItems[i]['itemPrice']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(RestaurantPageScreen(
          resname: widget.restaurantName,
        ));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("EDDFDF"),
            leading: IconButton(
              onPressed: () {
                Get.to(
                    () => RestaurantPageScreen(resname: widget.restaurantName));
              },
              icon: Icon(Icons.arrow_back),
              color: HexColor("FE7C00"),
            ),
            title: Text(
              "Cart",
              style: TextStyle(color: HexColor("FE7C00"), fontFamily: "Jua", fontSize: 30.sp),
            ),
            elevation: 0,
          ),
          body: Container(
            color: HexColor("EDDFDF"),
            height: 700.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Orders",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _getOrderListForCart(),
                      SizedBox(
                        height: 20.h,
                      ),
                      _getOrderConfirmationContainer(),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getOrderListForCart() {
    return Container(
      height: 320.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ListView.separated(
        padding: EdgeInsets.all(2.sp),
        itemCount: totalItems.length, // as per number of orders in database
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(5.0.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, //HexColor("FE7C00"),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              height: 105.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Container(
                      height: 90.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.white,
                          image: DecorationImage(
                              image:
                                  NetworkImage(totalItems[index]['imageURL']))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Container(
                      height: 90.h,
                      width: 240.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              totalItems[index]['itemName'],
                              style: TextStyle(
                                  fontSize: 20.h, fontWeight: FontWeight.bold),
                            ), //fetch from localdatabase from orderpage
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${totalItems[index]['itemPrice']}Tk",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor("FE7C00")),
                                ), //fetch from localdatabase from orderpage
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: HexColor("FE7C00"),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0.r))),
                                    onPressed: () {
                                      setState(() {
                                        totalPrice-=int.parse(totalItems[index]['itemPrice']);
                                        totalItems.removeAt(index);
                                      });
                                    },
                                    child: Text(
                                      "Remove",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget _getOrderConfirmationContainer() {
    return Container(
      height: 280.w,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Confirm Order",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              cursorColor: AppColors.mainColor,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Enter location",
                labelStyle: TextStyle(color: AppColors.mainColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.mainColor)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${totalPrice}Tk",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: HexColor('FE7C00')),
                  ),
                  DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50.h,
                    width: 200.w,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: HexColor("FE7C00"),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0.r))),
                        onPressed: () async {
                          if (locationController.text.trim().isEmpty) {
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Give your location",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Jua"),
                                  ),
                                  content: Text(
                                    "Order cannot be place without sharing your location location!",
                                    style: TextStyle(
                                        fontSize: 17.sp, fontFamily: "Ubuntu"),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                            color: AppColors.mainColor),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          if(dropdownvalue=='Bkash'){
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Service Underdevelopment",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Jua"),
                                  ),
                                  content: Text(
                                    "This paymment method is undeerdevelopment, you will be updated ASAP!",
                                    style: TextStyle(
                                        fontSize: 17.sp, fontFamily: "Ubuntu"),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                            color: AppColors.mainColor),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          User? user = FirebaseAuth.instance.currentUser;
                          String userPhoneNo = await FirebaseFirestore.instance
                              .collection("Authenticated_User_Info")
                              .doc(user!.uid)
                              .get()
                              .then((value) => value.data()!['phone']);
                          String userEmail = await FirebaseFirestore.instance
                              .collection("Authenticated_User_Info")
                              .doc(user.uid)
                              .get()
                              .then((value) => value.data()!['email']);
                          String userName = await FirebaseFirestore.instance
                              .collection("Authenticated_User_Info")
                              .doc(user.uid)
                              .get()
                              .then((value) => value.data()!['name']);
                          String timeNow =
                              DateFormat('h:mm a').format(DateTime.now());
                          String date =
                              DateFormat('dd:MM:yyyy').format(DateTime.now());

                          final order = OrderModel(
                            userName: userName,
                            userPhone: userPhoneNo,
                            userMail: userEmail,
                            allItems: totalItems,
                            totalPrice: totalPrice,
                            //imageURL: widget.imageURL,
                            location: locationController.text.trim(),
                            paymentMethod: dropdownvalue,
                            timeNow: timeNow,
                            date: date
                          );
                          await FirebaseFirestore.instance
                              .collection("${widget.restaurantName} Orders")
                              .doc(user.uid)
                              .set(order.toJson())
                              .whenComplete(() {
                            Logger().i("Order Placed");
                          });

                          setState(() {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Order Placed",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Jua"),
                                  ),
                                  content: Text(
                                    "Thank You for placing an order!",
                                    style: TextStyle(
                                        fontSize: 17.sp, fontFamily: "Ubuntu"),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => const RestaurentList());
                                        totalItems.clear();
                                      },
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                            color: AppColors.mainColor),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white, fontSize: 25.sp),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
