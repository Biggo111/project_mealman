import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'dart:math';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_mealman/app/core/app_colors.dart';

class CreditRequest extends StatefulWidget {
  @override
  State<CreditRequest> createState() => _CreditRequestState();
}

TextEditingController creddit = TextEditingController();

class _CreditRequestState extends State<CreditRequest> {
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Credit Topup"),
            backgroundColor: HexColor("FE7C00"),
          ),
          body: Container(
            decoration: (BoxDecoration(
              color: HexColor("eddfdf"),
              //borderRadius: BorderRadius.circular(15),
            )),
            child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Authenticated_User_Info")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String _UserName = snapshot.data!.data()!['name'];
                    CollectionReference _reference = FirebaseFirestore.instance
                        .collection("Authenticated_User_Info");
                    return StreamBuilder<QuerySnapshot>(
                        stream: _reference.snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            QuerySnapshot querySnapshot = snapshot.data;
                            List<QueryDocumentSnapshot> documents =
                                querySnapshot.docs;
                            List<Map> items =
                                documents.map((e) => e.data() as Map).toList();
                            return Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    Map thisItem = items[index];
                                    if ('${thisItem['userType']}' ==
                                        "restaurant") {
                                      return Padding(
                                        padding:  EdgeInsets.all(8.sp),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.sp),
                                          ),
                                          child: Container(
                                            height: 50.h,
                                            width: 120.w,
                                            child: Row(
    
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only( bottomRight: Radius.circular(20.r),),
                                                      color: AppColors.mainColor
                                                    ),
                                                      height: 50.h,
                                                      width: 150.w,
                                                      child: Padding(
                                                        padding:  EdgeInsets.only(left: 20.sp, top: 10.sp),
                                                        child: Text(
                                                            '${thisItem['name']}',style: TextStyle(fontSize: 20.sp),),
                                                      )),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      
                                                    ),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                AlertDialog(
    
                                                                  title: Text(
                                                                      "Enter Credit Amount"),
                                                                  content: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      TextField(
                                                                          controller:
                                                                              creddit,
                                                                          decoration:
                                                                              InputDecoration(hintText: "Enter Total credit")),
                                                                    ],
                                                                  ),
                                                                  actions: [],
                                                                ));
                                                      },
                                                      child:
                                                          Text("Enter Credit",style: TextStyle(fontSize: 15.sp,color: Colors.black),)),
                                                  Container(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: AppColors.mainColor
                                                      ),
                                                        onPressed: () {
                                                          check(
                                                              '${thisItem['name']}',
                                                              creddit.text,
                                                              _UserName);
                                                        },
                                                        child:
                                                            Text("Send Request")),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                            );
                          } else {
                            return Container();
                          }
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          )),
    );
  }

  Future check(String a, String b, String c) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('collection name').get();
    Random random = Random();
    int randomNumber = random.nextInt(111111111);
    String stringValue = randomNumber.toString();
    if (snapshot.size == 0) {
      final docuser = FirebaseFirestore.instance
          .collection('$a User Credit list')
          .doc(stringValue);
      RquestCredit(a, b, c);
    } else {
      RquestCredit(a, b, c);
    }
  }

  void RquestCredit(String ResturentName, String Credit, String UserName) {
    Random random = new Random();
    int randomNumber = random.nextInt(111111111);
    String stringValue = randomNumber.toString();
    final jsona = {
      'UserName': UserName,
      'Credit': Credit,
      "CreditStatus": "False",
      "RequestNumber": stringValue,
    };
    FirebaseFirestore.instance
        .collection('$ResturentName Credit Request')
        .doc(stringValue)
        .set(jsona);
  }
}