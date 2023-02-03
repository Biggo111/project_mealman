import 'package:flutter/material.dart';

import '../Utils/diamensions.dart';

class GridviewItem extends StatefulWidget {
  const GridviewItem({super.key});

  @override
  State<GridviewItem> createState() => _GridviewItemState();
}

class _GridviewItemState extends State<GridviewItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: Colors.amber,
              ),
            ),
            Align(
              alignment: const Alignment(0,1.8),
              child: Container(
                height: 70,
                width: 140,
                margin: const EdgeInsets.only(left: 28, right: 25, bottom: 8,),
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
                      Text("data")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}