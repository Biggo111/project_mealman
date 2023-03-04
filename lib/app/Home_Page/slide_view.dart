import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/Item_order_page/item_order.dart';
import 'package:project_mealman/widgets/big_text.dart';
import 'package:project_mealman/widgets/small_text.dart';

import '../Utils/diamensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideView extends StatefulWidget {
  const SlideView({super.key});

  @override
  State<SlideView> createState() => _SlideViewState();
}

class _SlideViewState extends State<SlideView> {


  String sliderItemName="Chicken Khichuri";
  String sliderItemPrice="70Tk";
  String sliderRestaurantName="Cafeteria";
  double sliderItemRating=4.5;

  // String slider2ItemName="";
  // String slider2ItemPrice="";
  // String slider2RestaurantName="";
  // double slider2ItemRating=5.0;

  // String slider3ItemName="";
  // String slider3ItemPrice="";
  // String slider3RestaurantName="";
  // double slider3ItemRating=5.0;

  // String slider4ItemName="";
  // String slider4ItemPrice="";
  // String slider4RestaurantName="";
  // double slider4ItemRating=5.0;

  // Future<void>getSlider1value()async{
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Cafeteria Menu").doc("Chicken Khichuri").get();
  //   Map<String, dynamic> itemData = snapshot.data() as Map<String, dynamic>;
  //   slider1ItemName = itemData['itemName'];
  //   Logger().i(slider1ItemName);
  //   slider1ItemPrice = itemData['itemPrice'];
  // }



  List slidingImageList = [
    {"id": 1, "image_path": 'assets/global_homepage_images/image 1.png'},
    {"id": 2, "image_path": 'assets/global_homepage_images/image 2.png'},
    {"id": 3, "image_path": 'assets/global_homepage_images/image 3.png'},
    {"id": 4, "image_path": 'assets/global_homepage_images/image 4.png'},
    {"id": 5, "image_path": 'assets/global_homepage_images/image 6.png'}
  ];

  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.0;
  double scaleFactor = 0.8;
  double _height = Diamensions.pageviewContainer1;
  @override
  void initState() {
    super.initState();
    //getSlider1value();
    
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Logger().i(MediaQuery.of(context).size.width.toString());
    return Column(
      children: [
        Container(
          //color: Colors.purple,
          padding:
               EdgeInsets.only(top: 5.h, left: 15.w, right: 15.w, bottom: 2.h),
          height: 265.h,//MediaQuery.of(context).size.height / 3.1,
          child: FutureBuilder(
            //future: getSlider1value(),
            builder: (context, snapshot){
              return PageView.builder(
                itemCount: 5,
                controller: pageController,
                itemBuilder: (context, position) {
                  return _buildPageItem(position);
                },
              );
            }
          ),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r)),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {


    if(index==0){
      sliderItemName = "Chicken Khichuri";
      sliderItemPrice = "70";
      sliderItemRating = 4.5;
      sliderRestaurantName = "Cafeteria";
    }
    else if(index==1){
      sliderItemName = "Mini Burger";
      sliderItemPrice = "40";
      sliderItemRating = 3.5;
      sliderRestaurantName = "Cafeteria";
    }
    else if(index==2){
      sliderItemName = "Sandwich";
      sliderItemPrice = "50";
      sliderItemRating = 5.0;
      sliderRestaurantName = "Cafeteria";
    }
    else if(index==3){
      sliderItemName = "Pizza";
      sliderItemPrice = "60";
      sliderItemRating = 4.0;
      sliderRestaurantName = "Cafeteria";
    }
    else if(index==4){
      sliderItemName = "Shingara";
      sliderItemPrice = "7";
      sliderItemRating = 5.0;
      sliderRestaurantName = "Cafeteria";
    }

    Matrix4 matrix = Matrix4.identity();
    //Logger().i("index = $index and currentpage = $currentPageValue");
    if (index == currentPageValue.floor()) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: (){
          if(index==0){
            Get.to(()=> ItemOrder(itemName: "Chicken Khichuri", itemDescription: "It is one of the rice types items. We provide two pieces of chicken and enough in quantity rice with it", itemPrice: "70", imageURL: "https://firebasestorage.googleapis.com/v0/b/project-mealman.appspot.com/o/images%2Fdata%2Fuser%2F0%2Fcom.example.project_mealman%2Fcache%2FEggKhichuri.jpeg?alt=media&token=2222211d-06f1-4fd9-82e9-afc94190f929", restaurantName: "Cafeteria"));
          }
          if(index==1){
            Get.to(()=> ItemOrder(itemName: "Mini Burger", itemDescription: "It is one of the fast food types items. It is good enough to kill your hunger!", itemPrice: "40", imageURL: "https://firebasestorage.googleapis.com/v0/b/project-mealman.appspot.com/o/images%2Fdata%2Fuser%2F0%2Fcom.example.project_mealman%2Fcache%2Fsandwitch.jpeg?alt=media&token=8e669a2a-6b2e-46f3-bf10-10ad05f22baa", restaurantName: "Cafeteria"));
          }
          if(index==2){
            Get.to(()=> ItemOrder(itemName: "Sandwich", itemDescription: "It is one of the fast food types items. It is good enough to kill your hunger!", itemPrice: "50", imageURL: "https://firebasestorage.googleapis.com/v0/b/project-mealman.appspot.com/o/images%2Fdata%2Fuser%2F0%2Fcom.example.project_mealman%2Fcache%2Fsandwitch.jpeg?alt=media&token=8e669a2a-6b2e-46f3-bf10-10ad05f22baaa", restaurantName: "Cafeteria"));
          }
          if(index==3){
            Get.to(()=> ItemOrder(itemName: "Pizza", itemDescription: "It is one of the fast food types items. It is good enough to kill your hunger!", itemPrice: "60", imageURL: "https://firebasestorage.googleapis.com/v0/b/project-mealman.appspot.com/o/images%2Fdata%2Fuser%2F0%2Fcom.example.project_mealman%2Fcache%2FPizza.jpeg?alt=media&token=5d71a9c7-9a73-41d0-83d1-1e010e8ae09e", restaurantName: "Cafeteria"));
          }
          if(index==4){
            Get.to(()=> ItemOrder(itemName: "Shingara", itemDescription: "It is one of the fast food types items. We provide the best one among all!", itemPrice: "7", imageURL: "https://firebasestorage.googleapis.com/v0/b/project-mealman.appspot.com/o/images%2Fdata%2Fuser%2F0%2Fcom.example.project_mealman%2Fcache%2Fsingara.jpeg?alt=media&token=fb0f3a2e-b22a-401e-9406-5e84b0d59bf9", restaurantName: "Cafeteria"));
          }
        },
        child: Stack(
          children: [
            Container(
              height: 190.h,
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                //color: Colors.amber,
                image: DecorationImage(
                  image: AssetImage(slidingImageList[index]["image_path"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 140.h,
                margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 8.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
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
                  padding: EdgeInsets.all(5.sp),
                  //height: 140,
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       SizedBox(
                        height: 20.h,
                      ),
                      BigText(text: sliderItemName),
                      //Text("Chicken Khichuri", style: TextStyle(fontSize: 20.sp),),
                       SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Wrap(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                                size: 15.sp,
                              );
                            }),
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          SmallText(
                            text: sliderItemRating.toString(),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          Text(
                            "$sliderItemPrice TK",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BigText(text: sliderRestaurantName),
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
