import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/restaurent_home_screen.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/seehistory.dart';

import '../../Utils/diamensions.dart';
import '../../core/app_colors.dart';

class OrderHistory2 extends StatefulWidget {
  const OrderHistory2({super.key});

  @override
  State<OrderHistory2> createState() => _OrderHistory2State();
}

class _OrderHistory2State extends State<OrderHistory2> {
  final searchController = TextEditingController();
  String searchedItem="";

  Future<List<Map<String, dynamic>>> fetchOrderHistory() async {
    List<Map<String, dynamic>> orders = [];

    String restaurantName;
    
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Authenticated_User_Info")
        .doc(user!.uid)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      // Logger().i(snapshot.data());

      restaurantName = data['name'];
    }
    else{
      restaurantName = "Cafeteria";
    }

    //Logger().i(restaurantName);

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection("$restaurantName Orders")
            .get();
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> docData = doc.data();
      //Logger().i(" The doc Data ${doc.data()}");
      //Logger().i(" The doc Data ${docData}");
      orders.add(docData);
    });
    Logger().i(orders.length);
    return orders;
  }


  Future<List<Map<String, dynamic>>> fetchConfrimedOrdersByDate(
      searchedDate) async {
    List<Map<String, dynamic>> confrimedOrderList = [];
    String searchForDate = searchedDate;
    User? user = FirebaseAuth.instance.currentUser;
    String restaurantName = "";

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Authenticated_User_Info")
        .doc(user!.uid)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      // Logger().i(snapshot.data());

      restaurantName = data['name'];
    }
    //Logger().i("$restaurantName");

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection("$restaurantName Orders")
            .where('date', isEqualTo: searchForDate)
            .get();
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> docData = doc.data();
      //Logger().i(" The doc Data ${doc.data()}");
      confrimedOrderList.add(docData);
    });
    Logger().i(confrimedOrderList.length);
    return confrimedOrderList;
  }

  @override
  Widget build(BuildContext context) {
    final HeightofConfirmOrdertab = MediaQuery.of(context).size.height;
    final WidthofConfirmOrdertab = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: ()async{
          Get.to(()=>const RestaurentHomeScreen());
          return false;
        },
        child: Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage(
          //             "assets/restaurent_thumbnails/see_order_page.png"),
          //         fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: HexColor("EDDFDF"),
            body: Padding(
              padding: EdgeInsets.only(
                  left: Diamensions.paddingOnly10,
                  right: Diamensions.paddingOnly10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    //searchBar(HeightofConfirmOrdertab, WidthofConfirmOrdertab),
                    Container(
                      height: HeightofConfirmOrdertab - 770,
                      width: WidthofConfirmOrdertab - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          //focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusColor: Colors.transparent,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.mainColor,
                          ),
                          hintText: "Format: day:month:year",
                          hintStyle: TextStyle(
                            color: Colors.black38,
                            fontFamily: 'Ubuntu',
                            fontSize: 20,
                          ),
                        ),
                        validator: (value) {
                          // Check if the input is a valid date format
                          if (value!.isEmpty) {
                            return 'Please enter a date';
                          }
                          const datePattern = r'^\d{2}:\d{2}:\d{4}$';
                          final dateRegex = RegExp(datePattern);
                          if (!dateRegex.hasMatch(value)) {
                            return 'Please enter a valid date in YYYY-MM-DD format';
                          }
                          return null;
                        },
                        controller: searchController,
                        // onChanged: (String value) {
                        //   searchedItem = value;
                        // },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 550,
                      child: searchController.text.isNotEmpty? FutureBuilder(
                          future: fetchConfrimedOrdersByDate(
                              searchController.text.trim()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              //Logger().i('Error fetching data: ${snapshot.error}');
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                child: Text("No order available!"),
                              );
                            }
                            final data = snapshot.data;
                            Logger().i(data);
                            return ListView.builder(
                                itemCount: data!.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    padding:
                                        EdgeInsets.all(Diamensions.paddingAll20),
                                    margin:
                                        EdgeInsets.all(Diamensions.paddingAll10),
                                    height: Diamensions.containerHeight160,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Diamensions.borderRadius30),
                                        color: Colors.white,
                                        //border: Border.all(),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 5),
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-5, 0),
                                          ),
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data[index]['userName'],
                                              style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: Diamensions.fontSize20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              // "${data[index]['timeNow']} ${data[index]['date']}"
                                              "${data[index]['timeNow']} ${data[index]['date']}",
                                              style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: Diamensions.fontSize20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                            height: Diamensions.sizedBoxHeight45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                //Logger().i(data[index]['allItems']);
                                Get.to(()=> SeeHistory(
                                  showuserName: data[index]['userName'],
                                  showuserEmail: data[index]['userMail'],
                                  showtotalPrice: data[index]['itemPrice'],
                                  showpaymentMethod: data[index]['paymentMethod'],
                                  showuserLocation: data[index]['location'],
                                  showuserPhone: data[index]['userPhone'],
                                  showorderTime: data[index]['timeNow'],
                                  showorderDate: data[index]['date'],
                                  showitems: data[index]['allItems'],
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Diamensions.borderRadius40),
                                ),
                              ),
                              child: Text(
                                "See Details",
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: Diamensions.fontSize20,
                                ),
                              ),
                            ),
                          ),
                                      ],
                                    ),
                                  );
                                });
                          })
                          : FutureBuilder(
                          future: fetchOrderHistory(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              //Logger().i('Error fetching data: ${snapshot.error}');
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                child: Text("No order available!"),
                              );
                            }
                            final data = snapshot.data;
      
                            return ListView.builder(
                                itemCount: data!.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    padding:
                                        EdgeInsets.all(Diamensions.paddingAll20),
                                    margin:
                                        EdgeInsets.all(Diamensions.paddingAll10),
                                    height: Diamensions.containerHeight160,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Diamensions.borderRadius30),
                                        color: Colors.white,
                                        //border: Border.all(),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 5),
                                          ),
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-5, 0),
                                          ),
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data[index]['userName'],
                                              style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: Diamensions.fontSize20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              // "${data[index]['timeNow']} ${data[index]['date']}"
                                              "${data[index]['timeNow']} ${data[index]['date']}",
                                              style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: Diamensions.fontSize20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                            height: Diamensions.sizedBoxHeight45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                //Logger().i(data[index]['allItems']);
                                Get.to(()=> SeeHistory(
                                  showuserName: data[index]['userName'],
                                  showuserEmail: data[index]['userMail'],
                                  showtotalPrice: data[index]['itemPrice'],
                                  showpaymentMethod: data[index]['paymentMethod'],
                                  showuserLocation: data[index]['location'],
                                  showuserPhone: data[index]['userPhone'],
                                  showorderTime: data[index]['timeNow'],
                                  showorderDate: data[index]['date'],
                                  showitems: data[index]['allItems'],
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Diamensions.borderRadius40),
                                ),
                              ),
                              child: Text(
                                "See Details",
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: Diamensions.fontSize20,
                                ),
                              ),
                            ),
                          ),
                                      ],
                                    ),
                                  );
                                });
                          })
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Container searchBar(myHeight, myWidth) {
  //   return Container(
  //         height: myHeight - 770,
  //         width: myWidth - 30,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(40),
  //           color: Colors.white,
  //         ),
  //         child: TextField(
  //           decoration: const InputDecoration(
  //             //focusedBorder: InputBorder.none,
  //             border: InputBorder.none,
  //             focusColor: Colors.transparent,
  //             prefixIcon: Icon(
  //               Icons.search,
  //               color: AppColors.mainColor,
  //             ),
  //             hintText: "Search",
  //             hintStyle: TextStyle(
  //               color: Colors.black38,
  //               fontFamily: 'Ubuntu',
  //               fontSize: 20,
  //             ),
  //           ),
  //           controller: searchController,
  //           onChanged: (String value) {},
  //         ),
  //       );
  // }
}
