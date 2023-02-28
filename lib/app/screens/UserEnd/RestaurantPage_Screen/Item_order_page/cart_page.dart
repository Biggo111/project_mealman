import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/restaurant_page_screen.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPart/restaurant_list.dart';

import '../../../../Modules/UserEndModels/order_model.dart';
//import 'package:image_uploader/widgets/drawer.dart';

class CartPage extends StatefulWidget {
  String itemName;
  String imageURL;
  String itemPrice;
  String restaurantName;
  CartPage({
    super.key,
    required this.itemName,
    required this.imageURL,
    required this.itemPrice,
    required this.restaurantName,
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
      'imageURL': widget.imageURL
    });
    for (var i = 0; i < totalItems.length; i++) {
      totalPrice += int.parse(totalItems[i]['itemPrice']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(RestaurantPageScreen(resname: widget.restaurantName,));
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
              style: TextStyle(color: HexColor("FE7C00")),
            ),
            elevation: 0,
          ),
          body: Container(
            color: HexColor("EDDFDF"),
            height: 700,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Orders",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _getOrderListForCart(),
                      SizedBox(
                        height: 20,
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
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(2),
        itemCount: totalItems.length, // as per number of orders in database
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, //HexColor("FE7C00"),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              height: 105,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          image: DecorationImage(
                              image:
                                  NetworkImage(totalItems[index]['imageURL']))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 90,
                      width: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              totalItems[index]['itemName'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ), //fetch from localdatabase from orderpage
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${totalItems[index]['itemPrice']}Tk",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor("FE7C00")),
                                ), //fetch from localdatabase from orderpage
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: HexColor("FE7C00"),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                    onPressed: () {
                                      setState(() {
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
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Confirm Order",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              cursorColor: AppColors.mainColor,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Enter location",
                labelStyle: TextStyle(color: AppColors.mainColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor), 
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${totalPrice}Tk",
                    style: TextStyle(
                        fontSize: 20,
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
                          style: TextStyle(fontSize: 15),
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: HexColor("FE7C00"),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        onPressed: () async {
                          if(locationController.text.trim().isEmpty){
                            return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Give your location",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Jua"),
                                  ),
                                  content: const Text(
                                    "Order cannot be place without sharing your location location!",
                                    style: TextStyle(
                                        fontSize: 17, fontFamily: "Ubuntu"),
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
                          final order = OrderModel(
                            userPhone: userPhoneNo,
                            userMail: userEmail,
                            itemName: widget.itemName,
                            totalPrice: totalPrice,
                            imageURL: widget.imageURL,
                            location: locationController.text.trim(),
                            paymentMethod: dropdownvalue,
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
                                  title: const Text(
                                    "Order Placed",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Jua"),
                                  ),
                                  content: const Text(
                                    "Thank You for placing an order!",
                                    style: TextStyle(
                                        fontSize: 17, fontFamily: "Ubuntu"),
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
                        child: const Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white, fontSize: 25),
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
