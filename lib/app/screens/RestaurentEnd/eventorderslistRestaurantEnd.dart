import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
class EventOrdersRestaurant extends StatefulWidget {
  String username = " ";
  EventOrdersRestaurant(this.username);
  @override
  State<EventOrdersRestaurant> createState() => _EventOrdersRestaurantState();
}
 
class _EventOrdersRestaurantState extends State<EventOrdersRestaurant> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("EDDFDF"),
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          leading: BackButton(),
          title: Text("Event orders"),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Pending Orders ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor),
                ),
              ),
              Container(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("Authenticated_User_Info")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String _resName = snapshot.data!.data()!['name'];
                        String ok = widget.username;
 
                        CollectionReference _reference =
                            FirebaseFirestore.instance.collection("$ok menue");
                        return StreamBuilder<QuerySnapshot>(
                            stream: _reference.snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                QuerySnapshot querySnapshot = snapshot.data;
                                List<QueryDocumentSnapshot> documents =
                                    querySnapshot.docs;
                                List<Map> items = documents
                                    .map((e) => e.data() as Map)
                                    .toList();
                                return SizedBox(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: items.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Map thisItem = items[index];
 
                                        if ('${thisItem['OrderStatus']}' ==
                                            "Placed") {
                                          return Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Container(
                                                alignment: Alignment.topLeft,
                                                decoration: BoxDecoration(
                                                  color: Colors
                                                      .white, //HexColor("FE7C00"),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      offset: Offset(
                                                          0.0, 1.0), //(x,y)
                                                      blurRadius: 6.0,
                                                    ),
                                                  ],
                                                ),
                                                height: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 400,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.mainColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "User : ${thisItem['Username']}",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 400,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.mainColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "PhoneNumber : ${thisItem['PhoneNumber']}",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 400,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.mainColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Order status : ${thisItem['PaymentMethod']}",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 400,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.mainColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Iteams : ${thisItem['Items']}",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 400,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.mainColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Total : ${thisItem['Total']}",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return Container();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}