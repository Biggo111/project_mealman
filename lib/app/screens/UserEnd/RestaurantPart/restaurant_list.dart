import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPart/getRunningRestaurantDataList.dart';

import '../../../core/app_colors.dart';
//import 'adminViewRestaurant.dart';

class RestaurentList extends StatefulWidget {
  const RestaurentList({super.key});

  @override
  State<RestaurentList> createState() => _RestaurentListState();
}

class _RestaurentListState extends State<RestaurentList> {
  List slidingImageList = [
    {"id": 1, "image_path": 'assets/userend_images/arrangeYourOwnMeal.png'},
    {"id": 2, "image_path": 'assets/userend_images/grabQuickReadyFood.png'},
    {"id": 3, "image_path": 'assets/userend_images/mealcoinSlidingImage.jpeg'}
  ];

  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  //final _firestore = FirebaseFirestore.instance;
  //String _resNameForUser = "";

  //The method to retrive the restaurent name from database-

  // Future<List<String>> fetchResNameForUser() async {
  //   List<String> restaurantNames = [];
  //   try {

  //     final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await FirebaseFirestore.instance
  //             .collection("Authenticated_User_Info")
  //             .where('userType', isEqualTo: 'restaurant')
  //             .get();
  //     querySnapshot.docs.forEach((doc) {
  //     restaurantNames.add(doc.get('name'));
  //     });
  //   } catch (e) {
  //     //Logger().i(_resNameForUser);
  //   }
  //   return restaurantNames;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("EDDFDF"),
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: HexColor("FE7C00"),
          //foregroundColor: Colors.orange,

          title: Title(
            child: Text("Restaurants"),
            color: Colors.white,
          ),

          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
          ],

          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Restaurant",
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _getSlidingImage(),
              _getRestaurantList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSlidingImage() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              print(currentIndex);
            },
            child: CarouselSlider(
              items: slidingImageList
                  .map(
                    (item) => Image.asset(
                      item['image_path'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 2,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _commonUserEndAppBar() {
    return AppBar(
      backgroundColor: HexColor("FE7C00"),
      //foregroundColor: Colors.orange,

      title: Title(
        child: Text("MealMan"),
        color: Colors.white,
      ),

      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))],

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search Restaurant",
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.white),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getRestaurantList() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 380,
                  width: double.infinity,
                  color: Colors.white,
                  //child: _getRunningRestaurantDataList(),
                  child: const GetRunningResTaurantDataList(),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  // Widget _getRunningRestaurantDataList() {
  //   return FutureBuilder<List<String>>(
  //       future: fetchResNameForUser(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(
  //               child: CircularProgressIndicator(
  //             color: AppColors.mainColor,
  //           ));
  //         }
  //         if (!snapshot.hasData) {
  //           // handle error case
  //           return const Center(
  //               child: Text(
  //             "Failed to fetch restaurant names",
  //             style: TextStyle(
  //                 color: AppColors.mainColor, fontWeight: FontWeight.bold),
  //           ));
  //         }
  //         final List<String> resNames = snapshot.data!;
  //         return ListView.separated(
  //           padding: const EdgeInsets.all(2),
  //           itemCount: resNames.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             String resName = resNames[index];
  //             List<String> imagePaths = [
  //               "assets/restaurent_thumbnails/cafeteria.png",
  //               "assets/restaurent_thumbnails/Sarah's.png",
  //               "assets/restaurent_thumbnails/Shatvai.png"
  //             ];
  //             return Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: GestureDetector(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     //color: Colors.white,
  //                     borderRadius: BorderRadius.circular(15),
  //                     // image: DecorationImage(
  //                     //     image:
  //                     //         AssetImage(imagePaths[index % imagePaths.length],),
  //                     //     fit: BoxFit.cover), // Bring images from database here

  //                     boxShadow: const [
  //                       BoxShadow(
  //                         color: Colors.grey,
  //                         offset: Offset(0.0, 1.0), //(x,y)
  //                         blurRadius: 5.0,
  //                       ),
  //                     ],
  //                   ),
  //                   height: 150,
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(15),
  //                     child: Container(
  //                       decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                           image: AssetImage(
  //                               imagePaths[index % imagePaths.length]),
  //                           fit: BoxFit.cover,
  //                           //alignment: Alignment.center,
  //                         ),
  //                       ),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           SizedBox(
  //                             height: 100,
  //                           ),
  //                           Container(
  //                             height: 50,
  //                             width: 150,
  //                             child: ElevatedButton(
  //                                 style: ElevatedButton.styleFrom(
  //                                     primary: HexColor("EDDFDF"),
  //                                     elevation: 3,
  //                                     shape: RoundedRectangleBorder(
  //                                         borderRadius:
  //                                             BorderRadius.circular(15.0))),
  //                                 onPressed: () {},
  //                                 child: Text(
  //                                   resName,
  //                                   style: TextStyle(
  //                                       color: Colors.black,
  //                                       fontWeight: FontWeight.bold),
  //                                 ) // bring restaurant name from database here

  //                                 ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //           separatorBuilder: (BuildContext context, int index) =>
  //               const Divider(),
  //         );
  //       });
  // }
}
