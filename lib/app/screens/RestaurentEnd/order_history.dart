import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../Utils/diamensions.dart';
import '../../core/app_colors.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final searchController = TextEditingController();

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
    return Padding(
      padding: EdgeInsets.only(
          left: Diamensions.paddingOnly10, right: Diamensions.paddingOnly10),
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                  hintText: "Search",
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
                //onChanged: (String value) {},
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 550,
              child: FutureBuilder(
                  future:
                      fetchConfrimedOrdersByDate(searchController.text.trim()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                            padding: EdgeInsets.all(Diamensions.paddingAll20),
                            margin: EdgeInsets.all(Diamensions.paddingAll10),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    ),
                                    Text(
                                      // "${data[index]['timeNow']} ${data[index]['date']}"
                                      "Time and Date here",
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: Diamensions.fontSize20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }),
            ),
          ],
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
