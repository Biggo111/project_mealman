import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
//import 'package:project_mealman/app/screens/RestaurentEnd/eventorderrr.dart';
import 'package:hexcolor/hexcolor.dart';
class AllOrder extends StatefulWidget {
  String username = "";
  AllOrder(this.username);
 
  @override
  State<AllOrder> createState() => _AllOrderState();
}
 
class _AllOrderState extends State<AllOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("All the orders"),backgroundColor: HexColor("FE7C00")),
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
                  String ok = widget.username;
                  print("It is$ok");
                  CollectionReference _reference =
                      FirebaseFirestore.instance.collection("$ok menue");
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
                                if ('${thisItem['OrderStatus']}' == "Placed") {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: (BoxDecoration(
 
 
 
              color: Color.fromARGB(255, 231, 210, 202),
              //borderRadius: BorderRadius.circular(15),
            )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  width:  100,
                                                  height: 200,
                                                  child: Text(
                                                      'Order Iteams \n${thisItem['Iteams']}')),
                                              Container(
                                                width: 100,
                                                height: 200,
                                                child: Column(
                                                  children: [
                                                      Container(
 
                                                    child: Text(
                                                        'Phonenumber:${thisItem['PhoneNumber']} ',textAlign: TextAlign.center),),
                                                Container(
 
                                                    child: Text(
                                                        'User:${thisItem['Username']}')),
                                                Container(
 
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Done(
                                                            '${thisItem['Username']}',
                                                            '${thisItem['Iteams']}',
                                                            '${thisItem['PhoneNumber']}');
                                                      },
                                                      child: Text("Finished")),
                                                ),
                                                  ],
                                                ),
                                              )
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
 
  void Done(String userName, String names, String phonenumber) async {
    String eventtitle = widget.username;
    print("$eventtitle menue");
    final docuse = FirebaseFirestore.instance
        .collection('$eventtitle menue')
        .doc(userName);
    final jsona = {
      "Iteams": names,
      "PhoneNumber": phonenumber,
      "Username": userName,
      "OrderStatus": "Done"
    };
    String d = widget.username;
    print(d);
    await FirebaseFirestore.instance
        .collection("$d menue")
        .doc(userName)
        .set(jsona);
  }
}