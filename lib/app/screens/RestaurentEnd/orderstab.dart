import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(itemBuilder: (_, index) {
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(10),
          height: 160,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Arafat Qurashi",
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Pending",
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    "See Order",
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 20,
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
