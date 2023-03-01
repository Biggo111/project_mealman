import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'Item_order_page/item_order.dart';

class BeverageTypeTab extends StatefulWidget {
  String restaurantName;
  BeverageTypeTab({super.key, required this.restaurantName});

  @override
  State<BeverageTypeTab> createState() => _BeverageTypeTabState();
}

class _BeverageTypeTabState extends State<BeverageTypeTab> {

  Future<List<Map<String, dynamic>>> fetchMenuForBeverageType() async {
    List<Map<String, dynamic>> menuList = [];
    String restaurantName = widget.restaurantName;
    //Logger().i("$restaurantName Menu");

    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("${restaurantName} Menu") 
              .where('category', isEqualTo: 'Beverage')
              .get();
      querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> docData = doc.data();
      //Logger().i(" The doc Data ${doc.data()}");
      menuList.add(docData);
      });

    //Logger().i(menuList.length);
    return menuList;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchMenuForBeverageType(),
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
              child: Text("No menu data available"),
            );
          }
          final data = snapshot.data;
          //Logger().i(snapshot.data);
          return GridView.builder(
            itemCount: data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: GestureDetector(
                  onTap: (){
                    Get.to(()=>ItemOrder(
                      itemName: data[index]['itemName'],
                      itemDescription: data[index]['itemDescription'],
                      itemPrice: data[index]['itemPrice'],
                      imageURL: data[index]['imageURL'],
                      restaurantName : widget.restaurantName
                    ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index]['itemName'],
                            style: const TextStyle(
                              fontFamily: "Jua",
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 0.4,
                                child: RatingBar.builder(
                                  initialRating: 3,
                                  itemSize: 30,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Text(
                            data[index]['itemPrice'],
                            style: const TextStyle(
                              fontFamily: "Ubuntu",
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.network(
                                data[index]['imageURL'],
                                fit: BoxFit.cover,
                                height: 60,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}