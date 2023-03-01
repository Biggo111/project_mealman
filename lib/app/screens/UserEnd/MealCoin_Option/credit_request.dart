import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'dart:math';
import 'package:hexcolor/hexcolor.dart';
 
class CreditRequest extends StatefulWidget {
  @override
  State<CreditRequest> createState() => _CreditRequestState();
}
 
TextEditingController creddit = TextEditingController();
 
class _CreditRequestState extends State<CreditRequest> {
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Credit Topup"),
          backgroundColor: HexColor("FE7C00"),
        ),
        body: Container(
          decoration: (BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/userend_images/crdit.jpg"),
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
                          return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map thisItem = items[index];
                                if ('${thisItem['userType']}' == "restaurant") {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Container(
                                          decoration: BoxDecoration( ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
 
                                                  height: 50,
                                                  width: 100,
                                                  child: Text(
                                                      '${thisItem['name']}')),
                                              TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) =>
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
                                                  child: Text("Enter Credit")),
                                              Container(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      check(
                                                          '${thisItem['name']}',
                                                          creddit.text,
                                                          _UserName);
                                                    },
                                                    child: Text("Send Request")),
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