import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class ItemsTab extends StatefulWidget {
  const ItemsTab({super.key});

  @override
  State<ItemsTab> createState() => _ItemsTabState();
}

class _ItemsTabState extends State<ItemsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(itemBuilder: (_, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
              child: Row(
                children: [
                  Image.asset(
                    "assets/signuppage_images/signupPageBackground.png",
                    width: 60,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Rui Fish",
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(
                              width: 95,
                            ),
                            Text(
                              "120tk",
                              style: TextStyle(
                                fontFamily: 'Jua',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        margin: const EdgeInsets.only(left: 20),
                        height: 95,
                        width: 250,
                        child: const SingleChildScrollView(
                          child: Text(
                            "1 piece fried Rui fish with masala gravy",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
        floatingActionButton: SizedBox(
          height: 45,
          width: 385,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Text(
              "Add Item",
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
              ),
            ),
          ),
        ));
  }
}
