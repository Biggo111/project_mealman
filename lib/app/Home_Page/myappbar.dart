import 'package:flutter/material.dart';
import 'package:project_mealman/app/core/app_colors.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget{
  double screenSize;
   MyAppBar({super.key, required this.screenSize});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight*1.9);
  //Size get preferredSize => const Size(widget.screenSize,kToolbarHeight*1.9);
}

class _MyAppBarState extends State<MyAppBar> {
  //final size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  @override
  Widget build(BuildContext context) {
    final HeightofAppBar = MediaQuery.of(context).size.height;
    final WidthofAppBar = MediaQuery.of(context).size.width;
    return Container(
      //height: widget.screenSize/4,
      height: kToolbarHeight*1.9,
      color: AppColors.mainColor,
      child: Column(
        children: [
          //const SizedBox(height: 1,),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 40,
                color: Colors.white,
                onPressed: (){},
              ),
              const Text(
                "MealMan",
                style: TextStyle(
                  fontFamily: "Jua",
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: widget.screenSize/2.5),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  color: Colors.white,
                  onPressed: (){},
                ),
              ),
            ],
          ),
          Container(
            height: HeightofAppBar-780,
            width: WidthofAppBar-30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: TextField(
            decoration: const InputDecoration(
              //focusedBorder: InputBorder.none,
              border: InputBorder.none,
              focusColor: Colors.transparent,
              prefixIcon: Icon(Icons.search, color: AppColors.mainColor,),
              hintText: "Search",
              hintStyle: TextStyle(
                color: Colors.black38,
                fontFamily: 'Ubuntu',
                fontSize: 20,
              ),
            ),
            //controller: loginEmailController,
            onChanged: (String value) {},
        ),
          ),
        ],
      ),
    );
  }
}