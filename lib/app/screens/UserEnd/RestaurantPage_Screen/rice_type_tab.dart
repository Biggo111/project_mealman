import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/Item_order_page/item_order.dart';
import 'package:transparent_image/transparent_image.dart';
 
class RiceTypeTab extends StatefulWidget {
  String restaurantName;
  RiceTypeTab({super.key, required this.restaurantName});
 
  @override
  State<RiceTypeTab> createState() => _RiceTypeTabState();
}
 
class _RiceTypeTabState extends State<RiceTypeTab> {
  Future<List<Map<String, dynamic>>> fetchMenuForRiceType() async {
    List<Map<String, dynamic>> menuList = [];
 
    String restaurantName = widget.restaurantName;
    //Logger().i("$restaurantName");
 
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection("${restaurantName} Menu")
            .where('category', isEqualTo: 'Rice')
            .get();
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> docData = doc.data();
      //Logger().i(" The doc Data ${doc.data()}");
      menuList.add(docData);
    });
    Logger().i(menuList.length);
    return menuList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchMenuForRiceType(),
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
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 8.0.w, right: 8.0.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ItemOrder(
                          itemName: data[index]['itemName'],
                          itemDescription: data[index]['itemDescription'],
                          itemPrice: data[index]['itemPrice'],
                          imageURL: data[index]['imageURL'],
                          restaurantName: widget.restaurantName),
                      // arguments: {
                      //   'itemName': data[index]['itemName'],
                      //   'itemDescription': data[index]['itemDescription'],
                      //   'itemPrice': data[index]['itemPrice'],
                      //   'imageURL': data[index]['imageURL']
                      // }
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.0.w, left: 8.0.w),
                            child: Container(
                              //color: Colors.red,
                              height: 50.w,
                              width: double.infinity,
                              child: Text(
                                data[index]['itemName'],
                                style: TextStyle(
                                  fontFamily: "Jua",
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Transform.scale(
                              scale: 0.8,
                              child: RatingBar.builder(
                                initialRating: 3,
                                itemSize: 20,
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
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: Text(
                                  data[index]['itemPrice'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Ubuntu",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: Container(
                                 // color: Colors.red,
                                  child: Text(
                                    "TK",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Ubuntu",
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                     EdgeInsets.only(right: 6.0.h, top: 6.w),
                                child: Container(
                                  height: 75.w,
                                  width: 75.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      image: DecorationImage(
                                        image: NetworkImage(data[index]['imageURL']),
                                        fit: BoxFit.cover 
                                      ),
                                    ),
                                ),
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