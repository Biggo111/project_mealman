import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/Item_order_page/cart_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
 
class ItemOrder extends StatefulWidget {
  String itemName;
  String itemDescription;
  String itemPrice;
  String imageURL;
  String restaurantName;
  ItemOrder(
      {super.key,
      required this.itemName,
      required this.itemDescription,
      required this.itemPrice,
      required this.imageURL,
      required this.restaurantName});
 
  @override
  State<ItemOrder> createState() => _ItemOrderState();
}
 
class _ItemOrderState extends State<ItemOrder> {
  double rating = 0;
  int quantity = 1;
  String itemName = "";
  String restaurantName = "";
  String itemDescription = "";
  String itemPrice = "";
  String imageURL = "";
  @override
  Widget build(BuildContext context) {
    itemName = widget.itemName;
    itemDescription = widget.itemDescription;
    itemPrice = widget.itemPrice;
    imageURL = widget.imageURL;
    restaurantName = widget.restaurantName;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.white,
          //foregroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){
              //Get.back();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: HexColor("FE7C00"),
          ),
 
          title: Title(
            child: Text(
              restaurantName,
              style: TextStyle(color: HexColor("FE7C00")),
            ),
            color: HexColor("FE7C00"),
          ),
 
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              _getItemImageBig(),
              SizedBox(height: 20,),
              _getItemOrderInfo(),
            ],
          ),
        ),
      ),
    );
  }
 
  Widget _getItemImageBig() {
    return Container(
      height: 250,
 
      width:350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          image: DecorationImage(
              image: NetworkImage(imageURL), //fetch image from database here
              fit: BoxFit.cover)),
    );
  }
 
  Widget _getItemOrderInfo() {
    return Container(
      height: 475,
      width: double.infinity,
      color: HexColor("FE7C00"),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemName, //Fetch item name from database
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ), // Fetch item name here from database
 
            _getRatingView(),
            _getDescription(),
            _getAddsOn(),
            _getQuantity(),
            _getTotalPrice(),
            _getRatingButton(),
          ],
        ),
      ),
    );
  }
 
  Widget _getQuantity() {
    return Row(
      children: [
        Text(
          "Quantity",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        SizedBox(
          width: 25,
        ),
        Container(
            height: 40,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: HexColor("FE7C00"),
                    )),
                Text(
                  "$quantity",
                  style: TextStyle(color: HexColor("FE7C00"), fontSize: 20),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (quantity < 1) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("This is the less"),
                                content:
                                    Text("Please, select more or order it!"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          quantity--;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.remove,
                      color: HexColor("FE7C00"),
                    )),
              ],
            )),
      ],
    );
  }
 
  Widget _getDescription() {
    return Text(
      itemDescription,
      style: TextStyle(color: Colors.white, fontSize: 15),
    );
  }
 
  Widget _getAddsOn() {
    return Row(
      children: [
        Text(
          "Adds On",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_rounded,
              color: Colors.white,
              size: 35,
            ))
      ],
    );
  }
 
  Widget _getTotalPrice() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${int.parse(itemPrice)*quantity}TK",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>CartPage(
                              itemName: itemName,
                              imageURL: imageURL,
                              itemPrice: (int.parse(itemPrice)*quantity).toString(),
                              restaurantName: restaurantName,
                              quantity: quantity,
                            ));
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                                color: HexColor("FE7C00"), fontSize: 20),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              // Get.to(()=>CartPage(
                              //   itemName: itemName,
                              //   imageURL: imageURL,
                              //   itemPrice: (int.parse(itemPrice)*quantity).toString(),
                              //   restaurantName: restaurantName,
                              //   quantity: quantity,
                              // ));
                            },
                            icon: Icon(
                              Icons.shopping_cart,
                              color: HexColor("FE7C00"),
                            )),
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
 
  Widget _getBuildRating() {
    return RatingBar.builder(
        minRating: 1,
        itemSize: 40,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
        onRatingUpdate: (rating) {
          setState(() {
            this.rating = rating;
          });
        });
  }
 
  Widget _getRatingButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Rate this item"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getBuildRating(),
                      ],
                    ),
                    actions: [
                      TextButton(onPressed: () {}, child: Text("Ok")),
                    ],
                  ));
        },
        child: Text(
          "Leave a Rating",
          style: TextStyle(color: HexColor("FE7C00")),
        ));
  }
 
  Widget _getRatingView() {
    return RatingBar.builder(
      initialRating:
          rating, //fetch average rating number of this item from database here
      itemSize: 30,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (double value) {},
    );
  }
}