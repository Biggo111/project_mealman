import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/core/services/firebase_auth_methods.dart';
import 'package:project_mealman/app/core/services/firebase_service.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/addnewitem.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/itemstab.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/order_history.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/see_order_page.dart';
import 'package:project_mealman/app/screens/Signup_Page/signup_page.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/Item_order_page/item_order.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPage_Screen/restaurant_page_screen.dart';
import 'package:project_mealman/app/screens/UserEnd/RestaurantPart/restaurant_list.dart';
import 'package:project_mealman/app/screens/global_home_screen.dart';

import 'app/screens/RestaurentEnd/Controllers/resend_controller.dart';
import 'app/screens/RestaurentEnd/restaurent_home_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.enableFirebase();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  //Get.put(ResEndController());
  runApp(MyApp(auth: auth, firestore: firestore,));
  //runApp(const MyApp());
}
class MyApp extends StatelessWidget {

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const MyApp({Key? key, required this.auth, required this.firestore,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //CollectionReference which_user = FirebaseFirestore.instance.collection('Authenticated_User_Info');
    //Stream documentStream = FirebaseFirestore.instance.collection('Authenticated_User_Info').doc(UserCredential.user.uid).snapshots();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //home: RestaurentHomeScreen(),     
      home: SignupPage(),
      //home: GlobalHomeScreen(),
      //home: AddNewItem(),
      //home: RestaurentList(),
      //home: ItemsTab(),
      //home: RestaurantPageScreen(),
      //home: ItemOrder(),
      //home: SeeOrderPage(),
      //home: OrderHistory(),
    );
  }
}