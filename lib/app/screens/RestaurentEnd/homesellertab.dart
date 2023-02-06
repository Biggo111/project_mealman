import 'package:flutter/material.dart';
import 'package:project_mealman/app/Utils/diamensions.dart';
import 'package:project_mealman/app/core/app_colors.dart';

class HomeSellerTab extends StatefulWidget {
  const HomeSellerTab({super.key});

  @override
  State<HomeSellerTab> createState() => _HomeSellerTabState();
}

class _HomeSellerTabState extends State<HomeSellerTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Diamensions.paddingOnly, right: Diamensions.paddingOnly),
      child: ListView.builder(itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.all(Diamensions.paddingAll20),
          margin: EdgeInsets.all(Diamensions.paddingAll10),
          height: MediaQuery.of(context).size.height/4.818604651162792,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Diamensions.borderRadius30),
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
                width: Diamensions.containerWidth60,
                height: Diamensions.containerHeight150,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: Diamensions.paddingOnly20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rui Fish",
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: Diamensions.fontSize30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                          ),
                        ),
                        SizedBox(
                          width: Diamensions.sizedBoxWidth95,
                        ),
                        Text(
                          "120tk",
                          style: TextStyle(
                            fontFamily: 'Jua',
                            fontSize: Diamensions.fontSize16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: Diamensions.paddingOnly10,),
                    margin: EdgeInsets.only(left: Diamensions.paddingOnly20),
                    height: Diamensions.containerHeight95,
                    width: Diamensions.containerWidth250,
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
    );
  }
}
