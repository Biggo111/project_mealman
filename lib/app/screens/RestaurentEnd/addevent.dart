import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_mealman/app/core/app_colors.dart';
 
class AddEvent extends StatefulWidget {
  const AddEvent({super.key});
 
  @override
  State<AddEvent> createState() => _AddEventState();
}
 
class _AddEventState extends State<AddEvent> {
  String _date = "Not set";
  String _time = "Not set";
  String _resName = "";
  List<String> names = [];
  TextEditingController Deleevirytime = TextEditingController();
  TextEditingController EventTitle = TextEditingController();
  TextEditingController EndTime = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
 
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage("assets/userend_images/rice.jpg"),
          //     fit: BoxFit.cover)
              
              ),
      child: SafeArea(
        child: Scaffold(
         // backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: AppColors.mainColor,
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
                          _resName = snapshot.data!.data()!['name'];
                          return Text(_resName);
                        } else {
                          return Container();
                        }
                      }),
                  SizedBox(
                    width: 70,
                  ),
                 
                ],
              ))),
          body: SingleChildScrollView(
            child: Container(
              height: 760,
              color: HexColor("EDDFDF"),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " Create your event",
                        style: TextStyle(fontSize: 25, color: AppColors.mainColor),
                      ),
                      _getEventFormFields(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
 
  Widget _getEventFormFields() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 600,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getName(),
                  SizedBox(
                    height: 7,
                  ),
                  _geteventendtime(),
                  SizedBox(
                    height: 7,
                  ),
                  _getDeliveryTime(),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Select Items for event",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  _getEventItemList(),
                  _getSubmitButton(context),
                ],
              ),
            ),
          )),
    );
  }
 
  Widget _getSubmitButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("FE7C00"),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              onPressed: () {
                Addevent();
                AddOrder();
              },
              child: Text(
                "Launch Event",
                style: TextStyle(fontSize: 20),
              )),
        ),
      ],
    );
  }
 
  Widget _getName() {
    return TextFormField(
      controller: EventTitle,
      decoration: const InputDecoration(labelText: "Enter Event Title"),
    );
  }
 
  Widget _getDeliveryTime() {
    return TextFormField(
        controller: Deleevirytime,
        decoration: const InputDecoration(labelText: "Delivery time"));
  }
 
  Widget _geteventendtime() {
    return TextFormField(
        controller: EndTime,
        decoration: const InputDecoration(labelText: "End time"));
  }
 
  Widget _getEventItemList() {
    return Container(
      // height: 300,
      width: double.infinity,
      child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("$_resName Menu").get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              CollectionReference _reference =
                  FirebaseFirestore.instance.collection("$_resName Menu");
              print("$_resName Menu");
              return StreamBuilder<QuerySnapshot>(
                  stream: _reference.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      QuerySnapshot querySnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> documents =
                          querySnapshot.docs;
                      List<Map> items =
                          documents.map((e) => e.data() as Map).toList();
                      return SizedBox(
                        height: 290,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map thisItem = items[index];
                              return Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${thisItem['imageURL']}'"),
                                                )),
                                          ),
                                        ),
                                        Container(
                                          height: 80,
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${thisItem['itemName']}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ), //
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${thisItem['itemPrice']}Tk  ",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            HexColor("FE7C00")),
                                                  ), //fetch from localdatabase from orderpage
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
                                                         names
                                                .add("${thisItem['itemName']}");
                                            names.add(
                                                "${thisItem['itemPrice']}");
                                            names
                                                .add("${thisItem['imageURL']}");
                                            names.add(_resName);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "${thisItem['itemName']} added to the card"),
                                                        ));
                                                      },
                                                      child: Text(
                                                        "Add",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return Container();
                    }
                  });
            } else {
              return Container();
            }
          }),
    );
  }
 
  Future Addevent() async {
    String eventtitle = EventTitle.text;
    eventtitle = _resName + eventtitle;
    final docuser = FirebaseFirestore.instance
        .collection('Resturnent Event')
        .doc('$eventtitle');
    print(eventtitle);
    int hour = int.parse(EndTime.text.split('-')[0]);
    int mint = int.parse(EndTime.text.split('-')[1]);
    final now = DateTime.now();
    final int endtime = DateTime(now.year, now.month, now.day, hour, mint)
        .millisecondsSinceEpoch;
    print(hour);
    print(mint);
    final json = {
      'eventtitle': eventtitle,
      'deliverytime': Deleevirytime.text,
      'endtime': endtime,
      'returentname': _resName
    };
    print(hour);
    print(mint);
    docuser.set(json);
    int j = 0;
    print("res name is $_resName");
    for (int i = 0; i < names.length; i++) {
      j++;
      if (j == 4) {
        String d = names[i - 3];
        final docuse =   FirebaseFirestore.instance.collection("$eventtitle").doc('$d');
        final jsona = {
          'name': names[i - 3],
          'price': names[i - 2],
          'imageurl': names[i - 1],
          'returentname': names[i],
        };
        print("added");
        docuse.set(jsona);
        j = 0;
      }
    }
  }
 
  Future AddOrder() async {
    String eventtitle = EventTitle.text;
    eventtitle = _resName + eventtitle;
    final docuse =
        FirebaseFirestore.instance.collection('$eventtitle menue').doc('ok');
    final jsona = {"name": "creation"};
    docuse.set(jsona);
  }
}