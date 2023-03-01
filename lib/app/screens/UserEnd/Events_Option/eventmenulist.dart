import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:logger/logger.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:project_mealman/app/screens/UserEnd/creditreq.dart';
 
class EventMenuList extends StatefulWidget {
  String username = "";
  EventMenuList(this.username);
  @override
  State<EventMenuList> createState() => _eventmenueState();
}
 
class _eventmenueState extends State<EventMenuList> {
  Map<String, int> map = {};
  int flg = 0;
  int totalcost = 0;
  String phonenumer = "";
  String cred = "";
  List<String> names = [];
  List<int> okcount = [];
  List<String> okstring = [];
  int count = 0;
  String resName = "";
  String userName = "";
  String end = "";
  String delevery = "";
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geteventname();
  }
 
  String ok="";
  void geteventname() async {
    // print("aschi");
    ok = widget.username;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Resturnent Event')
        .where("eventtitle", isEqualTo: widget.username)
        .get();
    end = querySnapshot.docs[0].get('endtime');
    delevery = querySnapshot.docs[0].get('deliverytime');
    print(end);
    print('$resName User Credit list');
    //dopayment();
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("FE7C00"),
            title: Expanded(
                child: Row(
              children: [
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("Authenticated_User_Info")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        userName = snapshot.data!.data()!['name'];
                        phonenumer = snapshot.data!.data()!['phone'];
                        print('$userName');
                        return Text(userName);
                      } else {
                        return Container();
                      }
                    }),
                Text(" Welcome to our event"),
              ],
            )),
            leading: GestureDetector(
              onTap: () {
                cart();
              },
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
          body: Container(
            decoration: (BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/userend_images/rice.jpg"),
                  fit: BoxFit.cover),
              color: Colors.brown,
              //borderRadius: BorderRadius.circular(15),
            )),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 150,
                      width: 350,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(color: Colors.white24),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("Event Name:$ok",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("Event End : $end",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("Delivery : $delevery",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ]),
                    ),
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("Authenticated_User_Info")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String _UserName = snapshot.data!.data()!['name'];
                            CollectionReference _reference = FirebaseFirestore
                                .instance
                                .collection(widget.username);
                            return StreamBuilder<QuerySnapshot>(
                                stream: _reference.snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    QuerySnapshot querySnapshot = snapshot.data;
                                    List<QueryDocumentSnapshot> documents =
                                        querySnapshot.docs;
                                    List<Map> items = documents
                                        .map((e) => e.data() as Map)
                                        .toList();
                                    return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: items.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Map thisItem = items[index];
 
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Container(
                                              //decoration: BoxDecoration(borderRadius:BorderRadius.circular(30)),
 
                                              child: Container(
                                                //decoration: BoxDecoration(borderRadius:BorderRadius.circular(30)),
 
                                                color: Colors.white,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Container(
                                                          height: 90,
                                                          width: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                            image: NetworkImage(
                                                                "${thisItem['imageurl']}'"),
                                                          )),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 100,
                                                        width: 170,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                // height: 80,
                                                                //width: 100,
                                                                child: Text(
                                                                    '${thisItem['name']}',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Container(
                                                                // height: 80,
                                                                //width: 100,
                                                                child: Text(
                                                                    '${thisItem['price']} Tk',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      // Container(
                                                      //   height: 140,
                                                      //   width: 100,
                                                      //   child: Text(
                                                      //       '\n\n\nIteam Name\n${thisItem['name']}',
                                                      //       style: TextStyle(
                                                      //           fontWeight: FontWeight.bold)),
                                                      // ),
                                                      // Container(
                                                      //   height: 140,
                                                      //   width: 100,
                                                      //   child: Text(
                                                      //       '\n\n\nIteam Price\n${thisItem['price']} Tk',
                                                      //       style: TextStyle(
                                                      //           fontWeight: FontWeight.bold)),
                                                      // ),
 
                                                      // Container(
                                                      //   height: 100,
                                                      //   width: 30,
                                                      //   child: IconButton(
                                                      //       onPressed: () {
                                                      //         print(widget.username);
                                                      //         int cost = int.parse(
                                                      //             '${thisItem['price']}');
                                                      //         totalcost = totalcost + cost;
                                                      //         names
                                                      //             .add("${thisItem['name']}");
                                                      //       },
                                                      //       icon: Icon(Icons.add)),
                                                      // ),
                                                      // Container(
                                                      //   height: 100,
                                                      //   width: 30,
                                                      //   child: IconButton(
                                                      //       onPressed: () {
                                                      //         print(widget.username);
                                                      //         int cost = int.parse(
                                                      //             '${thisItem['price']}');
                                                      //         totalcost = totalcost - cost;
                                                      //         names.remove(
                                                      //             "${thisItem['name']}");
                                                      //       },
                                                      //       icon: Icon(Icons.remove)),
                                                      // ),
                                                      // Container(
                                                      //   //decoration: ,
                                                      //   child: ElevatedButton(onPressed: (){}, child: Text("order"),))
                                                      ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              primary: HexColor(
                                                                  "FE7C00"),
                                                              elevation: 3,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.0))),
                                                          onPressed: () {
                                                            int cost = int.parse(
                                                                '${thisItem['price']}');
                                                            totalcost =
                                                                totalcost +
                                                                    cost;
                                                            names.add(
                                                                "${thisItem['name']}");
                                                          },
                                                          child: Text(
                                                            "Add",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                    ]),
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return Container();
                                  }
                                });
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ],
                ),
              ],
            ),
          )),
    );
  }
 
  void cart() {
    print(names);
 
    AlertDialog alert = AlertDialog(
      title: Text("Welcome to your cart"),
      actions: [
        Text(
            "the iteams you picked are :$names and your total cost is $totalcost"),
        ElevatedButton(
          onPressed: () {
            getresname();
          },
          child: Text("place order"),
        )
      ],
    );
 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
 
  void getresname() async {
    // print("aschi");
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Resturnent Event')
        .where("eventtitle", isEqualTo: widget.username)
        .get();
    print(widget.username);
    resName = querySnapshot.docs[0].get('returentname');
    print(resName);
    print('$resName User Credit list');
    dopayment();
  }
 
  void dopayment() async {
    print(userName);
    //String stringValue = randomNumber.toString();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('$resName User Credit list')
        .where("UserName", isEqualTo: userName)
        .get();
    String creditString = querySnapshot.docs[0].get('Credit');
    int Creditt = int.parse(creditString);
    print(Creditt);
    if (Creditt >= totalcost) {
      int leftamount = Creditt - totalcost;
      String stringValue = leftamount.toString();
      print(leftamount);
      dotransaction(stringValue);
    } else {
      AlertDialog alert = AlertDialog(
        title: Text("Sorry you dont have ebough credit!"),
        actions: [],
      );
 
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
 
  void dotransaction(addcredt) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('$resName User Credit list')
        .where('UserName', isEqualTo: userName)
        .get();
    final doc = querySnapshot.docs[0];
    final jsona = {
      'UserName': userName,
      'Credit': addcredt,
    };
    await FirebaseFirestore.instance
        .collection('$resName User Credit list')
        .doc(doc.id)
        .set(jsona);
 
    AlertDialog alert = AlertDialog(
      title: Text("Your order is succesfull"),
      actions: [],
    );
    AddOrder();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
 
  void AddOrder() async {
    String eventtitle = widget.username;
    print("$eventtitle menue");
    final docuse = FirebaseFirestore.instance
        .collection('$eventtitle menue')
        .doc(userName);
    final jsona = {
      "Iteams": names,
      "PhoneNumber": phonenumer,
      "Username": userName,
      "OrderStatus": "Placed"
    };
    String d = widget.username;
    await FirebaseFirestore.instance.collection("$d menue").doc().set(jsona);
  }
}