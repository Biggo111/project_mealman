import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';
 
class EventUserEnd extends StatefulWidget {//this will show the menu of a particular event
  final String username;
  const EventUserEnd({required this.username, super.key});
 
  @override
  State<EventUserEnd> createState() => _EventUserEndState();
}
 
class _EventUserEndState extends State<EventUserEnd> {
  final FirebaseAuth auth = FirebaseAuth.instance;
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
  List<Map> cart = [];
  void initState() {
    super.initState();
    geteventname();
   // getcurrentcreadit();
    WidgetsBinding.instance.addPostFrameCallback((_) => geteventname());
    //WidgetsBinding.instance.addPostFrameCallback((_) => getcurrentcreadit());
  }
 
  String ok = "";
  int done = 0;
  String rest = "";
  String userr = "";
  String p = "";
  String cr = "0";
 
  // void getcurrentcreadit() async {
  //   print('hide');
  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection('Resturnent Event')
  //       .where("eventtitle", isEqualTo: widget.username)
  //       .get();
  //   rest = querySnapshot.docs[0].get('endtime');
  //   userr = (await FirebaseFirestore.instance
  //           .collection('Authenticated_User_Info')
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           .get())
  //       .data()!['name'];
  //   print(userr);
  //   final querySnapshott = await FirebaseFirestore.instance
  //       .collection('$rest User Credit list')
  //       .where("Credit", isEqualTo: userr)
  //       .get();
  //   cr = rest = querySnapshott.docs[0].get('Credit');
  //   print("Done $cr");
  //   setState(() {
  //     this.cr = cr;
  //   });
  // }
 
  void geteventname() async {
    done = 1;
    ok = widget.username;
 
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Resturnent Event')
        .where("eventtitle", isEqualTo: widget.username)
        .get();
    // end = querySnapshot.docs[0].get('endtime');
    end = DateTime.fromMillisecondsSinceEpoch(
            querySnapshot.docs[0].get('endtime'))
        .toString()
        .substring(10, 16);
    delevery = querySnapshot.docs[0].get('deliverytime');
    resname = querySnapshot.docs[0].get('returentname');
    // phonenumer=querySnapshot.docs[0].get('returentname');
    setState(() {
      this.end = end;
      this.delevery = delevery;
    });
  }
 
  String resname = "";
  String Credit = "0";
  final varusername = "";
  final name = "";
 
  @override
  Widget build(BuildContext context) {
    double screnwidth = MediaQuery.of(context).size.width;
    double screheight = MediaQuery.of(context).size.height;
 
    return SafeArea(
      child: Container(
        // decoration: BoxDecoration(
        //     // image: DecorationImage(
        //     //     image: AssetImage("assets/userend_images/rice.jpg"),
        //     //     fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: HexColor("EDDFDF"),
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            leading: BackButton(color: Colors.white),
            // title: Text("$cr"),
            title: Text("$resname",style: TextStyle(color: Colors.white),),
            actions: [
   
              IconButton(
                onPressed: (() {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return MyCartPage(
                            itemlist: cart,
                            name: resname,
                            eventname: widget.username);
                      },
                    ));
   
                 
                 
                }),
   
   
                icon: Icon(Icons.shopping_cart),)
             
            ],
          ),
          body: Container(
            height: screheight,
            width: screnwidth,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: screheight - 700,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),),
                        // image: DecorationImage(
                        //     image: AssetImage("assets/userend_images/rice.jpg"),
                        //     fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 250,
                         
                            decoration: BoxDecoration(
                                color: Colors.white,
   
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
   
   
   
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.only(left :8.0),
                              child: Text(
                              "$resname presents $ok",
                              style: TextStyle(
                               
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainColor,
                              ),
                          ),
                            ), //Event name from database,
   
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Order Ends: $end am/pm",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ), //Event date from database
                         
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Delivery starts: $delevery am/pm",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ), //Event Time from database
                         
                        ],
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("Authenticated_User_Info")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String _UserName = snapshot.data!.data()!['name'];
                        print(" Your user name is $userName");
                        CollectionReference _reference = FirebaseFirestore
                            .instance
                            .collection(widget.username);
                        return StreamBuilder<QuerySnapshot>(
                            stream: _reference.snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                QuerySnapshot querySnapshot = snapshot.data;
                                List<QueryDocumentSnapshot> documents =
                                    querySnapshot.docs;
                                List<Map> items = documents
                                    .map((e) => e.data() as Map)
                                    .toList();
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 500,
                                    decoration: BoxDecoration(
                                       color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
 
 
                                    ),
                                   
                                   
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: items.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Map thisItem = items[index];
   
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              //decoration: BoxDecoration(borderRadius:BorderRadius.circular(30)),
   
                                              child: Container(
                                                //decoration: BoxDecoration(borderRadius:BorderRadius.circular(30)),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                    color: Colors.white,
   
                                                ),
   
                                             
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          height: 90,
                                                          width: 90,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(15),
                                                              color: Colors.white,
                                                              image: DecorationImage(
                                                                image: NetworkImage(
                                                                    "${thisItem['imageurl']}'"),
                                                                    fit: BoxFit.cover,
                                                              )),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          height: 90,
                                                          width: 240,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    15),
                                                            color: Colors.white,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${thisItem['name']} ",
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ), //fetch from events collection
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "${thisItem['price']} tk",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: AppColors.mainColor)
                                                                    ), //fetch from localdatabase from orderpage
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: AppColors.mainColor,
                                                                               
                                                                            elevation:
                                                                                3,
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius:
                                                                                    BorderRadius.circular(15.0))),
                                                                        onPressed: () {
                                                                          cart.add(
                                                                              thisItem);
                                                                          style:
                                                                          ElevatedButton.styleFrom(
                                                                              primary:
                                                                                  Colors
                                                                                      .green,
                                                                              elevation:
                                                                                  3,
                                                                              shape: RoundedRectangleBorder(
                                                                                  borderRadius:
                                                                                      BorderRadius.circular(15.0)));
                                                                          ScaffoldMessenger.of(
                                                                                  context)
                                                                              .showSnackBar(
                                                                                  SnackBar(
                                                                            content: Text(
                                                                                "${thisItem['name']} added to the card"),
                                                                          ));
                                                                        },
                                                                        child: Text(
                                                                          "Order",
                                                                          style:
                                                                              TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                          ),
                                                                        )),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                );
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
          ),
        ),
      ),
    );
  }
}
 
class MyCartPage extends StatefulWidget {
  final List<Map> itemlist;
  final String name;
  final String eventname;
  const MyCartPage(
      {super.key,
      required this.itemlist,
      required this.name,
      required this.eventname});
 
  @override
  State<MyCartPage> createState() => _MyCartPageState();
}
 
class _MyCartPageState extends State<MyCartPage> {
  String dropdownvalue = 'COD';
 
  // List of items in our dropdown menu
  var items = [
    'COD',
    'Mealcoin',
    'Bkash',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          leading: BackButton(color: Colors.white,),
          title: Text(
            "Event Cart",
            style: TextStyle(color:Colors.white),
          ),
          elevation: 0,
        ),
        body: Container(
          color: HexColor("EDDFDF"),
          height: 700,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                    "Confirm event order",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                    height: 10,
                ),
                _getOrderListForCart(),
                SizedBox(
                    height: 20,
                ),
                _getOrderConfirmationContainer(),
              ]),
                  ),
            ),
          ),
        ),
      ),
    );
  }
 
  Widget _getOrderListForCart() {
    return Container(
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(2),
        itemCount:
            widget.itemlist.length, // as per number of orders in database
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, //HexColor("FE7C00"),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              height: 105,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.itemlist[index]['imageurl']))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 90,
                      width: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.itemlist[index]['name'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ), //fetch from localdatabase from orderpage
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.itemlist[index]['price'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainColor),
                                ), //fetch from localdatabase from orderpage
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.mainColor,
                                       // primary: HexColor("FE7C00"),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                    onPressed: () {
                                      widget.itemlist.removeAt(index);
                                      setState(() {});
                                    },
                                    child: Text(
                                      "Remove",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
 
  Widget _getOrderConfirmationContainer() {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Confirm Order",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(labelText: "Enter location")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.itemlist
                        .sum((p) => int.parse(p['price']))
                        .toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HexColor('FE7C00')),
                  ),
                  DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: HexColor("FE7C00"),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        onPressed: () async {
                          final Username = (await FirebaseFirestore.instance
                                  .collection('Authenticated_User_Info')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get())
                              .data()!['name'];
                          //print(Username);
 
                          if (dropdownvalue == 'Mealcoin') {
                            final prevCred = (await FirebaseFirestore.instance
                                    .collection(
                                        '${widget.name} User Credit list')
                                    .doc(Username) //Curren user name load
                                    .get())
                                .data()!['Credit'];
                            final total = widget.itemlist
                                .sum((p0) => int.parse(p0['price']));
                            FirebaseFirestore.instance
                                .collection('${widget.name} User Credit list')
                                .doc("$Username")
                                .set({
                              'Username': Username,
                              'Credit':
                                  (int.parse(prevCred) - total).toString(),
                            });
                          }
                          // final Usrname = (await FirebaseFirestore.instance
                          //         .collection('Authenticated_User_Info')
                          //         .doc(FirebaseAuth.instance.currentUser!.uid)
                          //         .get())
                          //     .data()!['name'];
                          final phone = (await FirebaseFirestore.instance
                                  .collection('Authenticated_User_Info')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get())
                              .data()!['phone'];
                          FirebaseFirestore.instance
                              .collection('${widget.eventname} menue')
                              .doc()
                              .set({
                            'Items':
                                widget.itemlist.map((e) => e['name']).toList(),
                            'OrderStatus': 'Placed',
                            'PhoneNumber': phone,
                            'Username': Username,
                            'PaymentMethod': dropdownvalue,
                            'Total':widget.itemlist
                                .sum((p0) => int.parse(p0['price'])),
 
                          });
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}