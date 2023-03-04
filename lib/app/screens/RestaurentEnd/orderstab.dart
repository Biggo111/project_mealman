import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/Utils/diamensions.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/see_order_page.dart';
import 'package:intl/intl.dart';
import '../../core/app_colors.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key,});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  Future<List<Map<String, dynamic>>> fetchOrder() async {
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

  String timeNow = DateFormat('h:mm a').format(DateTime.now());
  String date = DateFormat('dd:MM:yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final HeightofOrdertab = MediaQuery.of(context).size.height;
    final WidthofOrdertab = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          left: Diamensions.paddingOnly10, right: Diamensions.paddingOnly10),
      child: FutureBuilder(
          future: fetchOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              Logger().i('Error fetching data: ${snapshot.error}');
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
                    padding: EdgeInsets.all(Diamensions.paddingAll20),
                    margin: EdgeInsets.all(Diamensions.paddingAll10),
                    height: Diamensions.containerHeight160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Diamensions.borderRadius30),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data[index]['userName'] ?? "No Name",
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: Diamensions.fontSize20,
                                fontWeight: FontWeight.bold,
                              ),
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
                              Get.to(()=>SeeOrderPage(
                                userName: data[index]['userName'],
                                userEmail: data[index]['userMail'],
                                userPhone: data[index]['userPhone'],
                                paymentMethod: data[index]['paymentMethod'],
                                userLocation: data[index]['location'],
                                totalPrice: data[index]['itemPrice'],
                                items: data[index]['allItems'], 
                                orderTime: data[index]['timeNow'],
                                orderDate: data[index]['date'],
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
                              "See Order",
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
          }),
    );
  }
}
