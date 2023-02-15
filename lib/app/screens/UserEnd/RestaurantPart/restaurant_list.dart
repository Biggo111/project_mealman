import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
                  child: _getRunningRestaurantDataList(),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget _getRunningRestaurantDataList() {
    return ListView.separated(
      padding: const EdgeInsets.all(2),
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image:
                      AssetImage("assets/userend_images/sarahKitchenCover.png"),
                  fit: BoxFit.cover), // Bring images from database here

              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            height: 150,
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
                              borderRadius: BorderRadius.circular(15.0))),
                      onPressed: () {},
                      child: Text(
                        "Restaurant Name",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ) // bring restaurant name from database here

                      ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
