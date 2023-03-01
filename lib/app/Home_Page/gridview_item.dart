import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mealman/app/screens/UserEnd/Events_Option/eventslist.dart';
import 'package:project_mealman/app/screens/UserEnd/MealCoin_Option/credit_request.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPart/restaurant_list.dart';

import '../Utils/diamensions.dart';

class GridviewItem extends StatefulWidget {
  int index;
  GridviewItem({super.key, required this.index});

  @override
  State<GridviewItem> createState() => _GridviewItemState();
}

class _GridviewItemState extends State<GridviewItem> {
  List slidingImageList = [
    {"id": 1, "image_path": 'assets/global_homepage_images/image 8.png'},
    {"id": 2, "image_path": 'assets/global_homepage_images/image 10.png'},
    {"id": 3, "image_path": 'assets/global_homepage_images/image 9.png'},
    {"id": 4, "image_path": 'assets/global_homepage_images/image 5.png'},
  ];

  List services = ["Restaurants", "Home Catering", "Events", "MealCoin"];

  List servicesDescription = [
    "Order in your desired restaurents",
    "Catering from our students",
    "See events and order your food!",
    "Request MealCoin!"
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (services[widget.index] == "Restaurants") {
          Get.to(() => const RestaurentList());
        }
        if(services[widget.index] == "MealCoin"){
          Get.to(()=>CreditRequest());
        }
        if(services[widget.index] == "Events"){
          Get.to(()=>EventsList());
        }
      },
      child: Container(
        height: 160,
        width: 180,
        child: Stack(
          children: [
            Container(
              height: 170,
              width: 180,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                //color: Colors.amber,
                image: DecorationImage(
                  image:
                      AssetImage(slidingImageList[widget.index]["image_path"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 1.8),
              child: Container(
                height: 70,
                width: 140,
                margin: const EdgeInsets.only(
                  left: 28,
                  right: 25,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
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
                child: Container(
                  padding: const EdgeInsets.all(5),
                  //height: 140,
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        services[widget.index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "Jua",
                        ),
                      ),
                      Center(
                        child: Text(
                          servicesDescription[widget.index],
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: "Ubuntu",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
