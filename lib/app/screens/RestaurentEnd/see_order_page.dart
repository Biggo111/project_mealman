import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
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
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage("assets/restaurent_thumbnails/see_order_page.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Confirm Order",
            style: TextStyle(fontSize: 20),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
    );
  }

  Widget _getOrderUsernameAndOrder() {
    Logger().i(widget.userName);
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.userName,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ), //fetch from cart database
          SizedBox(
            height: 10,
          ),
          Text(
            "Ordered Item:",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 230,
            width: double.infinity,
            child: ListView.separated(
              padding: const EdgeInsets.all(2),
              itemCount:
                  widget.items.length, // as per number of orders in database
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("FE7C00"),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //get all data from cart for the following texts
                          Text(
                            "${widget.items[index]['quantity']}X",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            widget.items[index]["itemName"],
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            "${widget.items[index]['itemPrice']}TK",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
            height: 20,
          ),

          Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: HexColor("FE7C00"),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Phone: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          widget.userPhone, //get from database
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Email: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Expanded(
                          child: Text(
                            widget.userEmail, //get from database
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 75,
                          width: 100,
                          child: Text(
                            "Location:",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          height: 75,
                          width: 200,
                          child: Text(
                            widget.userLocation, //get from database
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          widget.paymentMethod,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Order Time: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          widget.orderTime,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.orderDate,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Total: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "${widget.totalPrice}TK",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
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
          width: 300,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              onPressed: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Order Confirmed",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Jua"),
                        ),
                        content: const Text(
                          "Please Get The Order Ready!",
                          style: TextStyle(fontSize: 17, fontFamily: "Ubuntu"),
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
                              Get.to(() => RestaurentHomeScreen());
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
                style: TextStyle(fontSize: 20, color: HexColor("FE7C00")),
              )),
        ),
      ],
    );
  }
}
