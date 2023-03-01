import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CheckOrderList extends StatefulWidget {
  State<CheckOrderList> createState() => _CheckOrderListState();
}
 
class _CheckOrderListState extends State<CheckOrderList> {
  TextEditingController full = TextEditingController();
  String _resName = "";
  List<String> names = [];
  List<String> okstring = [];
  String ev = "ok";
  String done = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: HexColor("FE7C00"),
          title: Row(
            children: [
 
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("Authenticated_User_Info")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _resName = snapshot.data!.data()!['name'];
                      return Text(_resName);
                    } else {
                      return Container();
                    }
                  }),
            ],
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Container(
              width: 400,
              height: 50,
              child: TextField(
                controller: full,
                decoration: InputDecoration(
                  hintText: 'Your date should be in 02-02-02 this formate',
                  suffixIcon: IconButton(
                    onPressed: () {
                      int flg = 0;
                      okstring = full.text.split('and');
                      if (okstring.length > 1) {
                        done = okstring[1];
                        String done1 = okstring[0];
                        print(done.length);
                        if (done.length > 5) {
                          if (done[2] == "-" && done[5] == "-") {
                            for (int i = 0; i < _resName.length; i++) {
                              if (_resName[i] != done1[i]) {
                                flg = 1;
                              }
                            }
                          }
                          if (flg == 1) {
                            check2();
                          }
                          if (flg == 0) {
                            if (okstring.length > 0) {
                              ev = okstring[0];
                              ev = ev + " menue";
                              print(ev);
                            }
                          }
                        } else {
                          check();
                        }
                      } else {
                        check();
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 450,
            height: 700,
            decoration: (BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/userend_images/pizza.jpg"),
                  fit: BoxFit.cover),
              color: Colors.brown,
              //borderRadius: BorderRadius.circular(15),
            )),
            child: FutureBuilder (
                future:  FirebaseFirestore.instance.collection("$ev").get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    CollectionReference _reference =
                        FirebaseFirestore.instance.collection("$ev");
                    print("$ev menue");
                    return StreamBuilder<QuerySnapshot>(
                        stream: _reference.snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            QuerySnapshot querySnapshot = snapshot.data;
                            List<QueryDocumentSnapshot> documents =
                                querySnapshot.docs;
                            List<Map> items =
                                documents.map((e) => e.data() as Map).toList();
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: items.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Map thisItem = items[index];
                                  if ('${thisItem['Date']}' == "$done") {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: (BoxDecoration(
                                            color: HexColor("FE7C00"),
                                            //borderRadius: BorderRadius.circular(15),
                                          )),
                                          width: 200,
                                          height: 200,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 200,
                                                      child: Text(
                                                          'User Name: ${thisItem['Username']}')),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 200,
                                                      child: Text(
                                                          'Order Date: ${thisItem['Date']}')),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                      height: 50,
                                                      width: 200,
                                                      child: Text(
                                                          'User Phone Number: ${thisItem['PhoneNumber']}')),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                      height: 50,
                                                      width: 200,
                                                      child: Text(
                                                          'The Iteams : ${thisItem['Iteams']}')),
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
          ),
        ],
      ),
    );
  }
 
  void check() {
    AlertDialog alert = AlertDialog(
      title: Text("Your Name should be Eventtitleand02-02-2022 formate!"),
    );
 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
 
  void check2() {
    AlertDialog alert = AlertDialog(
      title: Text("It's not your resturent getout!"),
    );
 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
 