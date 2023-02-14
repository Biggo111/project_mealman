import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/Data/RestaurantEnd%20Repositories/resownerrepository.dart';
import 'package:project_mealman/app/Utils/diamensions.dart';
import 'package:project_mealman/app/core/app_colors.dart';

class HomeSellerTab extends StatefulWidget {
  const HomeSellerTab({super.key});

  @override
  State<HomeSellerTab> createState() => _HomeSellerTabState();
}

class _HomeSellerTabState extends State<HomeSellerTab> {
  final _firestore = FirebaseFirestore.instance;
  String _resName = "";

  Future<QuerySnapshot?>fetchResName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      //Logger().i("Inside the try ${user!.uid}");
      if (user == null) {
        _resName = "You are not logged in";
      } else {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("Authenticated_User_Info")
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
           Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          // Logger().i(snapshot.data());
          
          _resName = data['name'];
        } else {
          _resName = "No data found for the user";
        }
        return _firestore.collection("$_resName Menu").get(); 
        // _resName = (snapshot.data() as Map<String, dynamic>)['name'];
        //Logger().i(snapshot.toString());
        // await FirebaseFirestore.instance
        //     .collection("Authenticated_User_Info")
        //     .doc(user.uid)
        //     .get()
        //     .then((value) {
        //     _resName = value.data()!['name'];
        //     Logger().i(value.toString());
        //     return value.toString();
        //     });
      }
    } catch (e) {
      Logger().i(_resName);
    }
    return null;
  }
  // void getResName() async {
  //   final resOwnerRepository = Get.put(ResOwnerRepository());
  //   resName = await resOwnerRepository.fetchResName().toString();
  //   //Logger().i(resName);
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchResName(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.done) {
          //   return const Center(child: Text("check your internet connection"));
          // }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Your menu is empty"));
          }
          final documents = snapshot.data!.docs;
          return Padding(
            padding: EdgeInsets.only(
                left: Diamensions.paddingOnly, right: Diamensions.paddingOnly),
            child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (_, index) {
                  return Container(
                    padding: EdgeInsets.all(Diamensions.paddingAll20),
                    margin: EdgeInsets.all(Diamensions.paddingAll10),
                    height:
                        MediaQuery.of(context).size.height / 4.818604651162792,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Diamensions.borderRadius30),
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
                    child: Row(
                      children: [
                        Image.network(
                          documents[index]['imageURL'],
                          width: Diamensions.containerWidth60,
                          height: Diamensions.containerHeight150,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: Diamensions.paddingOnly20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    documents[index]['itemName'],
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: Diamensions.fontSize30,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: Diamensions.sizedBoxWidth95,
                                  // ),
                                  // Text(
                                  //   documents[index]["itemPrice"].toString(),
                                  //   style: TextStyle(
                                  //     fontFamily: 'Jua',
                                  //     fontSize: Diamensions.fontSize16,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  //color: Colors.amber,
                                  padding: EdgeInsets.only(
                                    top: Diamensions.paddingOnly10,
                                  ),
                                  margin: EdgeInsets.only(
                                      left: Diamensions.paddingOnly20),
                                  height: Diamensions.containerHeight95,
                                  width: Diamensions.containerWidth250 - 50,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      documents[index]["itemDescription"],
                                    ),
                                  ),
                                ),
                                Text(
                                  documents[index]["itemPrice"].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Jua',
                                    fontSize: Diamensions.fontSize16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
