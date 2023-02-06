import 'package:flutter/material.dart';
import 'package:project_mealman/app/Utils/diamensions.dart';

import '../../core/app_colors.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Diamensions.paddingOnly10, right: Diamensions.paddingOnly10),
      child: ListView.builder(itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.all(Diamensions.paddingAll20),
          margin: EdgeInsets.all(Diamensions.paddingAll10),
          height: Diamensions.containerHeight160,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Arafat Qurashi",
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: Diamensions.fontSize20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Pending",
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Diamensions.borderRadius40),
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
      }),
    );
  }
}
