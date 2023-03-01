import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:hexcolor/hexcolor.dart';
//import 'package:project_mealman/app/screens/RestaurentEnd/Controllers/AddEvent.dart';
//import 'package:project_mealman/app/screens/RestaurentEnd/drawer.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/allorder.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/checkorderlist.dart';

import '../../core/app_colors.dart';
//import 'package:project_mealman/app/screens/RestaurentEnd/eventorderrr.dart';
class EventOrder extends StatefulWidget {
  const EventOrder({super.key});
 
  @override
  State<EventOrder> createState() => _EventOrderState();
}
 
class _EventOrderState extends State<EventOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Here is all your event list"),backgroundColor: HexColor("FE7C00"), actions: [
          SizedBox(
                height: 45,
                width: 140,
                child: FloatingActionButton(
                  onPressed: () {
                    //Get.to(() => );
                    Get.to(() => CheckOrderList());
                  },
                  elevation: 2,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Event Orders",
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
        ],),
        body: Container(
          decoration: (BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/userend_images/pizza.jpg"),
                  fit: BoxFit.cover),
              color: Colors.brown,
              //borderRadius: BorderRadius.circular(15),
            )),
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("Authenticated_User_Info")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String _resName = snapshot.data!.data()!['name'];
                  CollectionReference _reference = FirebaseFirestore.instance.collection("Resturnent Event");
                  print(_resName);
                  return StreamBuilder<QuerySnapshot>(
                      stream: _reference.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          QuerySnapshot querySnapshot = snapshot.data;
                          List<QueryDocumentSnapshot> documents =
                              querySnapshot.docs;
                          List<Map> items =
                              documents.map((e) => e.data() as Map).toList();
                          return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map thisItem = items[index];
                                if ('${thisItem['returentname']}' == _resName) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
 decoration: (BoxDecoration(
 
              color: Colors.white,
              //borderRadius: BorderRadius.circular(15),
            )),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(width: 150,height: 80, child: Text('\nEvent Name\n${thisItem['eventtitle']} ', style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),),
                                              Container(
                                                height: 50,
                                                width: 100,
                                                child: ElevatedButton(
 
                                                    style: ElevatedButton.styleFrom(shadowColor: Colors.purple),
                                                    onPressed: () {
                                                        Navigator.push( context, MaterialPageRoute( builder: (context) => AllOrder( '${thisItem['eventtitle']}'),));
                                                    },
                                                    child: Text(
                                                        "visit",),),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        } else {
                          return Container();
                        }
                      });
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ));
  }
 
}