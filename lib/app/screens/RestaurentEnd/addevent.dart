import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:project_mealman/app/screens/RestaurentEnd/Controllers/AddEvent.dart';
// import 'package:project_mealman/app/screens/RestaurentEnd/drawer.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/allorder.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/eventorder.dart';

import '../../core/app_colors.dart';

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
  TextEditingController Time = TextEditingController();
  TextEditingController EventTitle = TextEditingController();
  TextEditingController EndTime = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
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
                    SizedBox(width: 70,),
                    SizedBox(
                height: 45,
                width: 140,
                child: FloatingActionButton(
                  onPressed: () {
                    //Get.to(() => );
                    Get.to(() => EventOrder());
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
              ],
            ))),
        body: SingleChildScrollView(
          child: Container(
            decoration: (BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.circular(15),
            )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Create your event",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    _getEventFormFields(),
                  ],
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getName(),
              SizedBox(
                height: 10,
              ),
              _getEventDate(),
              SizedBox(
                height: 10,
              ),
              _getEventTime(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select Items for event",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              _getSubmitButton(context),
              _getEventItemList(),
            ],
          ),
        ),
      ),
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

  Widget _getEventTime() {
    return TextFormField(
        controller: Time,
        decoration: const InputDecoration(labelText: "Enter dellivary time"));
  }

  Widget _getEventDate() {
    return TextFormField(
        controller: EndTime,
        decoration: const InputDecoration(labelText: "Enter Event end time "));
  }

  Widget _getEventItemList() {
    return Container(
      height: 300,
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
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map thisItem = items[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Text(
                                        '${thisItem['itemName']}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor("FE7C00")),
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: HexColor("FE7C00"),
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0))),
                                          onPressed: () {
                                            names
                                                .add("${thisItem['itemName']}");
                                            names.add(
                                                "${thisItem['itemPrice']}");
                                            names
                                                .add("${thisItem['imageURL']}");
                                            names.add(_resName);
                                          },
                                          child: Text(
                                            "Add",
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
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
    final json = {
      'eventtitle': eventtitle,
      'deliverytime': Time.text,
      'endtime': EndTime.text,
      'returentname': _resName
    };
    docuser.set(json);
    int j = 0;

    for (int i = 0; i < names.length; i++) {
      j++;
      if (j == 4) {
        String d = names[i - 3];
        final docuse =
            FirebaseFirestore.instance.collection("$eventtitle").doc('$d');
        final jsona = {
          'name': names[i - 3],
          'price': names[i - 2],
          'imageurl': names[i - 1],
          'returentname': names[i],
        };
        docuse.set(jsona);
        j = 0;
      }
    }
    //Logger().i("$UserName");
  }

  Future AddOrder() async {
    String eventtitle = EventTitle.text;
    final docuse =
        FirebaseFirestore.instance.collection('$eventtitle menue').doc('ok');
    final jsona = {"name": "creation"};
    docuse.set(jsona);
  }
}
