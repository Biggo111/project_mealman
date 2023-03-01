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

class SeeHistory extends StatefulWidget {
  String showuserName;
  String showuserEmail;
  String showuserPhone;
  String showpaymentMethod;
  String showuserLocation;
  int showtotalPrice;
  List showitems;
  String showorderTime;
  String showorderDate;
  SeeHistory({
    super.key,
    required this.showuserName,
    required this.showuserEmail,
    required this.showuserPhone,
    required this.showpaymentMethod,
    required this.showuserLocation,
    required this.showtotalPrice,
    required this.showitems,
    required this.showorderTime,
    required this.showorderDate,
  });

  @override
  State<SeeHistory> createState() => _SeeHistoryState();
}

class _SeeHistoryState extends State<SeeHistory> {

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
            "Order History",
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
    //Logger().i(widget.userName);
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.showuserName,
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
                  widget.showitems.length, // as per number of orders in database
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
                            "${widget.showitems[index]['quantity']}X",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            widget.showitems[index]["itemName"],
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            "${widget.showitems[index]['itemPrice']}TK",
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
                          widget.showuserPhone, //get from database
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
                            widget.showuserEmail, //get from database
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
                            widget.showuserLocation, //get from database
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
                          widget.showpaymentMethod,
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
                          widget.showorderTime,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.showorderDate,
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
                          "${widget.showtotalPrice}TK",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
