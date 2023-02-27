import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/restaurant_page_screen.dart';

import '../../../core/app_colors.dart';

class GetRunningResTaurantDataList extends StatefulWidget {
  const GetRunningResTaurantDataList({super.key});

  @override
  State<GetRunningResTaurantDataList> createState() => _GetRunningResTaurantDataListState();
}

class _GetRunningResTaurantDataListState extends State<GetRunningResTaurantDataList> {

  Future<List<String>> fetchResNameForUser() async {
    List<String> restaurantNames = [];
    try {

      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("Authenticated_User_Info")
              .where('userType', isEqualTo: 'restaurant')
              .get();
      querySnapshot.docs.forEach((doc) {
      restaurantNames.add(doc.get('name'));
      });
    } catch (e) {
      //Logger().i(_resNameForUser);
    }
    return restaurantNames;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: fetchResNameForUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.mainColor,
            ));
          }
          if (!snapshot.hasData) {
            // handle error case
            return const Center(
                child: Text(
              "Failed to fetch restaurant names",
              style: TextStyle(
                  color: AppColors.mainColor, fontWeight: FontWeight.bold),
            ));
          }
          final List<String> resNames = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(2),
            itemCount: resNames.length,
            itemBuilder: (BuildContext context, int index) {
              String resName = resNames[index];
              List<String> imagePaths = [
                "assets/restaurent_thumbnails/cafeteria.png",
                "assets/restaurent_thumbnails/Sarah's.png",
                "assets/restaurent_thumbnails/Shatvai.png"
              ];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Get.to(()=>RestaurantPageScreen(resname: resName),
                    arguments: {
                      'restaurantName': resName,
                    }
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      // image: DecorationImage(
                      //     image:
                      //         AssetImage(imagePaths[index % imagePaths.length],),
                      //     fit: BoxFit.cover), // Bring images from database here

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                imagePaths[index % imagePaths.length]),
                            fit: BoxFit.cover,
                            //alignment: Alignment.center,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Container(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: HexColor("EDDFDF"),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0))),
                                  onPressed: () {},
                                  child: Text(
                                    resName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ) // bring restaurant name from database here

                                  ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        });
  }
}