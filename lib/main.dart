import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/core/services/firebase_auth_methods.dart';
import 'package:project_mealman/app/core/services/firebase_service.dart';
import 'package:project_mealman/app/screens/Signup_Page/signup_page.dart';
import 'package:project_mealman/app/screens/global_home_screen.dart';

import 'app/screens/RestaurentEnd/restaurent_home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.enableFirebase();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
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
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: RestaurentHomeScreen(),
      //home: SignupPage(),
      //home: GlobalHomeScreen(),
    );
    // final authMethods = FirebaseAuthMethods(auth);
    // String? userID = authMethods.userID;
    // return StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //       .collection('Authenticated_User_Info')
    //       .doc(userID)
    //       .snapshots(),
    //   builder: ((context, snapshot){
    //     if(snapshot.hasData && snapshot.data != null){
    //       //Logger().i(userID);
    //       var userType = snapshot.data?['userType'];
    //       if(userType=='student' || userType=='teacher'){
    //         return const GetMaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           home: GlobalHomeScreen(),
    //         );
    //       }
    //       else if (userType == 'restaurant') {
    //         return const GetMaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           home: RestaurentHomeScreen(),
    //         );
    //       }
    //       else {
    //         return const GetMaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           home: SignupPage(),
    //         );
    //       }
    //     }
    //     else {
    //       return const GetMaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         home: SignupPage(),
    //       );
    //     }
    //   }),
    // );
  }
}